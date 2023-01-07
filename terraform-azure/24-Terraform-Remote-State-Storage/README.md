---
title: Terraform Remote State Storage & Locking
description: Learn about Terraform Remote State Storage & Locking
---
## Step-01: Introduction
- Understand Terraform Backends
- Understand about Remote State Storage and its advantages
- This state is stored by default in a local file named `terraform.tfstate`, but it can also be stored remotely, which works better in a team environment.
- Create Azure Storage Account to store `terraform.tfstate` file and enable backend configurations in terraform settings block
- All the TF Configs copy from Section-19

## Step-02: Create Azure Storage Account
### Step-02-01: Create Resource Group
- Go to Resource Groups -> Add 
- **Resource Group:** terraform-storage-rg 
- **Region:** East US
- Click on **Review + Create**
- Click on **Create**

### Step-02-02: Create Azure Storage Account
- Go to Storage Accounts -> Add
- **Resource Group:** terraform-storage-rg 
- **Storage Account Name:** terraformstate201 (THIS NAME SHOULD BE UNIQUE ACROSS AZURE CLOUD)
- **Region:** East US
- **Performance:** Standard
- **Redundancy:** Geo-Redundant Storage (GRS)
- In `Data Protection`, check the option `Enable versioning for blobs`
- REST ALL leave to defaults
- Click on **Review + Create**
- Click on **Create**

### Step-02-03: Create Container in Azure Storage Account
- Go to Storage Account -> `terraformstate201` -> Containers -> `+Container`
- **Name:** tfstatefiles
- **Public Access Level:** Private (no anonymous access)
- Click on **Create**



# Verify Azure Storage Account for project-1-eastus2-terraform.tfstate file
Observation: 
1. Finally at this point you should see the project-1-eastus2-terraform.tfstate file in Azure Storage Account with content in it.

# Access Application
http://<LB-Public-IP>/app1
