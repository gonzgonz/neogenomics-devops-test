variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "my_instance_dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name to access EC2 instance"
  type        = string
}

variable "volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 8
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}
