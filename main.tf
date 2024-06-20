module "eks" {
  #count = local.environment == "admin" ? 0 : 1

  source         = "git::https://gitlab.com/aws-modules/eks.git?ref=main"
  environment    = local.environment
  product        = var.product
  use_case       = var.use_case
  cluster_config = local.cluster_config

  node_security_group_tags = {
    "karpenter.sh/discovery/generic-bmpd-generic-cluster" = "bmpd-generic-cluster"
  }
  
  # kubelet_extra_args = {
  #   container-runtime = "remote"
  #   container-runtime-endpoint = "unix:///var/run/containerd/containerd.sock"
  # }
}

# resource "null_resource" "update_kubeconfig" {
#   provisioner "local-exec" {
#     command = "aws eks --region ${"us-west-2"} update-kubeconfig --name ${"generic-bmpd-generic-cluster"}"
#   }
#   #depends_on = [generic-bmpd-generic-cluster]
# }
