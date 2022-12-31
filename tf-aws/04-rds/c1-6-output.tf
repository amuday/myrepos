output "instance" {
  value = aws_instance.test_instance.public_ip
}

output "rds" {
  value = aws_db_instance.mariadb.endpoint
}