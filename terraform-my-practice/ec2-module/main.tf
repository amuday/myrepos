module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  monitoring             = true
  vpc_security_group_ids = ["sg-04e9c4fbe8808dc57"]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

output "ec2_instances" {
  value       = module.ec2_instance
}


output "ec2_instances_created_map" {
  value       = { for myvar in module.ec2_instance : myvar.tags_all.Name => myvar.id }
}

output "ec2_instances_ids" {
  value       = [ for myvar in module.ec2_instance : myvar.id ]
}

output "ec2_instances_single_id" {
  value = [ for myvar in module.ec2_instance : myvar.id ][0]
}