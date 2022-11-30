# AWS EC2 Instance Terraform Module
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private_app1" {
  depends_on = [module.vpc] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source     = "terraform-aws-modules/ec2-instance/aws"
  #version    = "2.17.0"
  version = "4.2.1"
  # insert the 10 required variables here
  name          = "${var.environment}-app1"
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring             = true
  vpc_security_group_ids = [module.private_sg.security_group_id]
  #subnet_id              = module.vpc.public_subnets[0]  

  for_each = local.multiple_instances
  subnet_id              = each.value.subnet_id


  user_data = file("${path.module}/app1-install.sh")
  tags      = local.common_tags
}


