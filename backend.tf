terraform {
  backend "s3" {
    bucket = "new-bmpd-state-files"
    key    = "infra-provisioners/eks.tfstate"
    region = "us-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region              = local.region
  allowed_account_ids = [778122232551]
  default_tags {
    tags = local.tags
  }
}

# data "aws_eks_cluster" "default" {
#   name = local.cluster_name
# }

# data "aws_eks_cluster_auth" "default" {
#   name = local.cluster_name
# }

# provider "kubernetes" {
#   host                   = module.eks.cluster_details.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_details.cluster_ca_certificate[0].data)
#   token                  = module.eks.cluster_details.token
# }

provider "kubernetes" {
  host                   = module.eks.cluster_details.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_details.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_details.cluster_id]
  }
}