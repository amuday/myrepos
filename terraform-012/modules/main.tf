provider "aws" {
    region = "us-east-1"
  
}


module "ec2module" {
  source = "./ec2"
  ec2name = "Name Provided from Module"
}


# getting the output value from a child module.
output "module_output" {
    # syntax : module.<module name>.<child output variable name>
  value = module.ec2module.instance_id
}