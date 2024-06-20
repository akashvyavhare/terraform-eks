data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "new-bmpd-state-files"
    key    = "infra-provisioners/vpc.tfstate"
    region = "us-west-2"
  }
  workspace = local.environment
}