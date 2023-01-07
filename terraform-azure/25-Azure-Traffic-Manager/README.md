---
title: Azure Traffic Manager using Terraform
description: Create Azure Traffic Manager using Terraform
---
## Step-01: Introduction
- Understand about [Terraform Remote State Datasource](https://www.terraform.io/docs/language/state/remote-state-data.html)
- Terraform Remote State Storage Demo with two projects
- Both project 1 and project 2 are similar, only region is different. deploying them in 2 different regions.


## Step-02: Project-1: project-1-eastus2-vmss
- Review TF Configs in folder `project-1-eastus2-vmss`

## Step-03: Project-1: Execute Terraform Commands
```t
# Change Directory 
cd project-1-eastus2-vmss

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Observation
1. Verify all resources in eastus2 region
2. Verify Storage Account - TFState file
```
## Step-04: Project-2: project-2-westus2-vmss
- Review TF configs in folder `project-2-westus2-vmss`

## Step-05: Project-2: Execute Terraform Commands
```t
# Change Directory 
cd project-2-westus2-vmss

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Observation
1. Verify all resources in westus2 region
2. Verify Storage Account - TFState file
```

## Step-06: Project-3: project-3-azure-traffic-manager
- Folder: project-3-azure-traffic-manager

### Step-06-00: c0-terraform-remote-state-datasource.tf
- Understand in depth about Terraform Remote State Datasource
```t
# Project-1: East US2 Datasource
data "terraform_remote_state" "project1_eastus2" {
  backend = "azurerm"
  config = {
    resource_group_name   = "terraform-storage-rg"
    storage_account_name  = "terraformstate201"
    container_name        = "tfstatefiles"
    key                   = "project-1-eastus2-terraform.tfstate"
  }
}

# Project-2: West US2 Datasource
data "terraform_remote_state" "project2_westus2" {
  backend = "azurerm"
  config = {
    resource_group_name   = "terraform-storage-rg"
    storage_account_name  = "terraformstate201"
    container_name        = "tfstatefiles"
    key                   = "project-2-westus2-terraform.tfstate"
  }
}

/* 
1. Project-1: Web LB Public IP Address
data.terraform_remote_state.project1_eastus2.outputs.web_lb_public_ip_address_id
1. Project-2: Web LB Public IP Address
data.terraform_remote_state.project2_westus2.outputs.web_lb_public_ip_address_id
*/

## Step-07: Project-3: Execute Terraform Commands
```t
# Change Directory 
cd project-3-azure-traffic-manager

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Observation
1. Verify Azure Traffic Manager Resources
2. Verify Storage Account - TFState file

# Access Apps from both regions eastus2 and westus2
http://<Traffic-Manager-DNS-Name>
```

## Step-08: Project-3: Clean-Up
```t
# Change Directory 
cd project-3-azure-traffic-manager

# Destroy Resources
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
```

## Step-09: Project-2: Clean-Up
```t
# Change Directory 
cd project-2-westus2-vmss

# Destroy Resources
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
```

## Step-10: Project-1: Clean-Up
```t
# Change Directory 
cd project-1-eastus2-vmss

# Destroy Resources
terraform destroy -auto-approve

# Delete Files
rm -rf .terraform*
```
