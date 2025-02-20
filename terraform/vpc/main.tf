terraform {
  backend "s3" {
    bucket         = "my-tf-state-gonzaloarce" # appended my name to be able to actually test this on my Free tier account (due to unique name contraints on S3)
    key            = "neogenomics-devops-test/terraform.tfstate"
    dynamodb_table = "my-tf-lock"
    region         = "eu-north-1" # I used Stockholm for testing, as I already have other test resources here in my Free Tier account.
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs                  = ["eu-north-1a"]
  public_subnets       = ["10.0.1.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false # we do not need a NAT gateway for this example as the assignment states to have only a public subnet  

  tags = {
    Name        = "my-vpc"
    Environment = "neogenomics-test"
    Repository  = "neogenomics-devops-test"
  }
}

