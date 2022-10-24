output "for_output_list" {
  description = "For loop with list"
  # user myvar as instance for making it better.
  value = [for myvar in aws_instance.my_instance : myvar.public_dns]

}

output "for_output_map" {
  description = "For loop with map"
  value       = { for myvar in aws_instance.my_instance : myvar.id => myvar.public_dns }

}

# advanced map
output "for_output_map_adv" {
  description = "For loop with advanced map"
  value       = { for c, myvar in aws_instance.my_instance : c => myvar.public_dns }
}

# legacy splat operator - returns a list
output "legacy_splat_instance_publicdns" {
  description = "Legacy splat operator"
  value       = aws_instance.my_instance.*.public_dns

}

# latest splat operator - returnd a list
output "latest_splat_instance_publicdns" {
  description = "Legacy splat operator"
  value       = aws_instance.my_instance[*].public_dns

}