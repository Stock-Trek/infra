provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.40.0"
    }
  }
  backend "s3" {
    bucket         = "state.stock-trek.com"
    key            = "live/terraform.tfstate"
    region         = "eu-west-1"
    use_lockfile   = true
    encrypt        = true
  }
}
