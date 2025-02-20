variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}
