

output "intances_publicip" {
  description = "to get public ips of instances"
  value = [for instance in aws_instance.my_instance: instance.public_ip]
}

output "instance_publicdns" {
  description = "Legacy splat operator"
  #value       = [for instance in aws_instance.my_instance: instance.public_dns]
  # add set, to convert all elements to same type
  value       = toset([for instance in aws_instance.my_instance: instance.public_dns])

}

output "instance_publicdns_2" {
  description = "Legacy splat operator"
  #value       = {for az, instance in aws_instance.my_instance: az => instance.public_ip}
  # to have map of same type
  value       = tomap({for az, instance in aws_instance.my_instance: az => instance.public_ip})

}