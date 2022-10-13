output "instance_public_ip" {
  description = "EC2 instance public IP"
  value       = aws_instance.my_instance_1.public_ip

}

output "instance_public_dns" {
  description = "EC2 instance public dns"
  value       = aws_instance.my_instance_1.public_dns
}