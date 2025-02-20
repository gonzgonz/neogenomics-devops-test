terraform {
  backend "s3" {
    bucket         = "my-tf-state-gonzaloarce"
    key            = "neogenomics-devops-test/ec2.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "my-tf-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}


resource "aws_instance" "my_instance_dev" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  associate_public_ip_address = true

  key_name = "gonzaloarce-k8s" # Replace with your actual AWS key pair if you want to run this -- I used an existing keypair of mine.

  security_groups = [aws_security_group.instance_sg.id]


  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "my_instance_dev"
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Allow SSH access for Ansible
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Should be restricted to a jumphost address, for example, but open for the purpose of this test
  }

  # Allow HTTP access for web server
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance_sg"
  }
}
