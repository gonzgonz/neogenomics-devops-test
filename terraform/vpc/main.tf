terraform {
  backend "s3" {
    bucket         = "my-tf-state-gonzaloarce" # appended my name to be able to actually test this on my Free tier account (due to unique name contraints on S3)
    key            = "neogenomics-devops-test/terraform.tfstate"
    dynamodb_table = "my-tf-lock"
    region         = var.region # I used Stockholm for testing, as I already have other test resources here in my Free Tier account.
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                  = ["${var.region}a"]
  public_subnets       = var.public_subnet_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = var.vpc_name
    Environment = "neogenomics-test"
    Repository  = "neogenomics-devops-test"
  }
}
