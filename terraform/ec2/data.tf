data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "my-tf-state-gonzaloarce"
    key            = "neogenomics-devops-test/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "my-tf-lock"
  }
}
