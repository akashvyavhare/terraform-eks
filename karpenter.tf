resource "aws_iam_instance_profile" "karpenter" {
  name = "KarpenterNodeInstanceProfile-${local.cluster_name}"
  role = module.eks.cluster_details.eks_managed_node_groups["primary"].iam_role_name

}

module "karpenter_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.0.0"

  role_name                          = "karpenter-controller-${local.cluster_name}"
  attach_karpenter_controller_policy = true

  karpenter_tag_key               = "karpenter.sh/discovery/${local.cluster_name}"
  karpenter_controller_cluster_id = module.eks.cluster_details.cluster_id
  karpenter_controller_node_iam_role_arns = [
    module.eks.cluster_details.eks_managed_node_groups["primary"].iam_role_arn
  ]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.cluster_details.oidc_provider_arn
      namespace_service_accounts = ["karpenter:karpenter"]
    }
  }
  depends_on = [
    aws_iam_instance_profile.karpenter
  ]
}

resource "aws_iam_role_policy" "karpenter_controller" {
  name = "karpenter-policy-${local.cluster_name}"
  role = module.karpenter_irsa.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "pricing:GetProducts"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "v0.16.1"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter_irsa.iam_role_arn
  }

  set {
    name  = "clusterName"
    value = module.eks.cluster_details.cluster_id
  }

  set {
    name  = "clusterEndpoint"
    value = module.eks.cluster_details.cluster_endpoint
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }
  depends_on = [
    module.karpenter_irsa
  ]
}

resource "kubectl_manifest" "karpenter_provisioner" {
  yaml_body = <<-YAML
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: default
  spec:
    consolidation:
        enabled: true
    requirements:
      - key: karpenter.sh/capacity-type
        operator: In
        values: ["spot", "on-demand"]
      - key: node.kubernetes.io/instance-type
        operator: In
        values: ["t4g.xlarge"]        
    limits:
      resources:
        cpu: 50
        memory: 100Gi
    provider:
      subnetSelector:
        Name: "${local.environment}-${var.product}-vpc-private*"
      securityGroupSelector:
        karpenter.sh/discovery/${module.eks.cluster_details.cluster_id}: "*"
      tags:
        karpenter.sh/discovery/${module.eks.cluster_details.cluster_id}: ${module.eks.cluster_details.cluster_id}
        
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}