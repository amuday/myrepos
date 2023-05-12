
output "secret1" {
  value = data.aws_ssm_parameter.param1
  sensitive = true
}

output "secret2" {
  value = data.aws_ssm_parameter.param2
  sensitive = true
}