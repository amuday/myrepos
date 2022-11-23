provider "aws" {
    region = "us-east-1"
  
}


module "ec2module" {
  # relative path to the module
  source = "./ec2"
  # pass variable to the module. ec2name is a variable in the ec2 module.
  ec2name = "Name Provided from Module"
}


# getting the output value from a child module.
output "module_output" {
    # syntax : module.<module name>.<child output variable name>
  value = module.ec2module.instance_id
}