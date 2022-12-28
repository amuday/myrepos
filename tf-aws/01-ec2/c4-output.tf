output "public-ip" {
  value = aws_instance.test_ec2_instance.public_ip
}

output "app1_url" {
  value = [
    "http://${aws_instance.test_ec2_instance.public_ip}",
    "http://${aws_instance.test_ec2_instance.public_ip}/${var.app_name}",
    "http://${aws_instance.test_ec2_instance.public_ip}/${var.app_name}/metadata.html"
  ]
}

output "template_out" {
  value = data.template_file.script.rendered
}