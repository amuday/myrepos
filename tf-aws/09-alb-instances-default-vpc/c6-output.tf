
output "app1_url" {
  value = [
    aws_lb.this.id
  ]
}

output "template_out" {
  value = data.template_file.script.rendered
}