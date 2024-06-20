locals {
  cluster_name   = "bmpd-generic-cluster"
  region         = var.regions[local.environment]
  environment    = terraform.workspace
  cluster_config = merge(var.cluster_config[local.environment], local.extra_cluster_config)
  extra_cluster_config = {
    vpc_id                   = "vpc-03c0aaade8a3b51fc" #data.terraform_remote_state.vpc.outputs.vpc_details.vpc_id
    node_subnet_ids          = ["subnet-0fa8e545069bdaf17", "subnet-0a0c91ed57798daf8", "subnet-016b0ede7f8419078","subnet-05f2f4c856f338708"] #data.terraform_remote_state.vpc.outputs.vpc_details.private_subnets
    control_plane_subnet_ids = ["subnet-0fa8e545069bdaf17", "subnet-0a0c91ed57798daf8", "subnet-016b0ede7f8419078", "subnet-05f2f4c856f338708"] #data.terraform_remote_state.vpc.outputs.vpc_details.private_subnets
  }
  tags = {
    Environment             = local.environment
    Product                 = var.product
    Use_case                = var.use_case
    Can_be_deleted          = true
    Created_using_terraform = true
  }
}

