# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

# App1 - Private EC2 Instances
## ec2_private_instance_ids
output "app1_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = local.app1_instances[0]
}

## ec2_private_ip
/*
output "app1_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2_private_app1.private_ip
}
*/

# App2 - Private EC2 Instances
## ec2_private_instance_ids
output "app2_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = local.app2_instances[0]
}

## ec2_private_ip
/*
output "app2_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2_private_app2.private_ip
}
*/

# App3 - Private EC2 Instances
## ec2_private_instance_ids
output "app3_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = local.app3_instances[0]
}
## ec2_private_ip
/*
output "app3_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2_private_app3.private_ip
}
*/