## load from terraform.tfvars

terraform apply

if the file terraform.tfvars not present will prompt for vaule

Even if you set TF_VAR_var1="newval", value is loading from the file.

## load vlue from file

terraform apply -var-file=variables.tfvars

## print TF_VAR value

set TF_VAR_var1="newval"
terraform apply

## load vlue from file

set TF_VAR_var1="newval"
terraform apply -var-file=variables.tfvars
