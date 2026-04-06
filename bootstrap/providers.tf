provider "aws" {
  region = local.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.22.0"
    }
  }
  backend "s3" {
    bucket         = "state.stock-trek.com"
    key            = "bootstrap/terraform.tfstate"
    region         = "eu-west-1"
    use_lockfile   = true
    encrypt        = true
  }
}
