output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_instance_dev.id
}

output "public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.my_instance_dev.public_ip
}
