resource "aws_eip" "bastion_eip" {

  # IGW need to be created before creating bastion eip
  depends_on = [
    module.ec2_public,
    module.vpc
  ]
  instance = module.ec2_public.id
  vpc      = true
  tags     = local.common_tags
}