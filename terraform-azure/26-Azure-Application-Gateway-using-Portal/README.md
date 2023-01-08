---
title: Azure Application Gateway Standard using Azure Portal
description: Create Azure Application Gateway Standard using Azure Portal
---

## Step-00: Introduction
1. Create Virtual Network and VMSS using Terraform
2. Create Azure Application Gateway using Azure Portal and explore the features
### Azure Application Gateway Features
0. Application Gateway -> Overview Tab
1. Settings -> Configuration 
2. Settings -> Backend Pools
3. Settings -> HTTP Settings
4. Settings -> Frontend IP Configurations
5. Settings -> SSL Settings
6. Settings -> Listeners
7. Settings -> Rules
8. Settings -> Rewrites
9. Settings -> Healht Probes
10. Monitoring -> Insights
11. Monitoring -> Backend Health
12. Monitoring -> Connection Troubleshoot
13. Settings -> Web Application Firewall

## Step-01: Review TF Configs
- Review TF Configs which will create following resources using Terraform
1. Azure Virtual Network
2. Azure Network Security Groups
3. Azure Virtual Machine Scale Set
4. Azure Bastion Host and Service (Commented)
5. Azure AG Subnet with NSG (c6-07-ag-subnet-and-nsg.tf)

## Step-02: c6-07-ag-subnet-and-nsg.tf

## Step-03: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
```

## Step-04: Create Azure Application Gateway
- Go to Load Balancers -> Application Gateway -> Create
- **Resource Group:** same as above resources created using Terraform `hr-dev-randomid`
### Basics Tab
- **Application Gateway Name:** ag-manual-1
- **Region:** East US
- **Tier:** Standard V2
- **Enable autoscaling:** Yes
- **Minimum instance count:** 0
- **Maximum instance count:** 10
- **Availability Zone:** None
- **HTTP2:** Disabled
- **Virtual network:** hr-dev-vnet
- **Subnet:** hr-dev-vnet-agsubnet(10.1.51.0/24)
- Click on **Next: Frontends**
### Frontends Tab
- **Frontend IP address type:** Public
- **Public IP address:** Add New - **Name:** ag-pip1
- Click on **Next: Backends**
### Backends Tab
- **Name:** app1-vmss
- **Add a backend pool without target:** No
- **Target Type:** vmss
- **Target:** hr-dev-web-vmss
- Click on **Add**
- Click on **Next: Configuration**
### Configuration Tab
- Click on **Add a Routing Rule**
- **Rule name:** basic-rule
#### Configuration Tab - Listener Tab
- **Listener name:** http-80-listener
- **Frontend IP:** Public
- **Protocol:** HTTP
- **Port:** 80
- **Additional settings:** basic
- **Error page url:** No
#### Configuration Tab - Backend Targets
- **Target type:** Backend Pool
- **Backend Target:** app1-vmss
- **HTTP Settings:** Add New
  - **HTTP settings name:** http-settting-1
  - **Backend protocol:** HTTP
  - **Backend port:** 80
  - **Cookie-based affinity:** Disable
  - **Connection draining:** Disable
  - **Request time-out (seconds):** 20
  - **Override backend path:** leave empty
  - Rest all leave to defaults
  - Click **Add**
- Click on **Add**
- Click on **Next: Tags**
- Click on **Next: Review + Create**
- Click on **Create**

## Step-05: Verify Azure Application Gateway
- Go to Load Balancers -> Application Gateway -> ag-manual-1
0. Overview
1. Settings -> Configuration 
2. Settings -> Backend Pools
3. Settings -> HTTP Settings
4. Settings -> Frontend IP Configurations
5. Settings -> SSL Settings
6. Settings -> Listeners
7. Settings -> Rules
8. Settings -> Rewrites
9. Settings -> Healht Probes
10. Monitoring -> Insights
11. Monitoring -> Backend Health
12. Monitoring -> Connection Troubleshoot
13. Settings -> Web Application Firewall

## Step-06: Access Application
- Go to Load Balancers -> Application Gateway -> ag-manual-1 -> Overview
- Frontend Public IP Address
```t
# Access Application
http://<AG-Public-IP>
http://<AG-Public-IP>/app1/index.html
http://<AG-Public-IP>/app1/metadata.html
http://<AG-Public-IP>/app1/status.html
http://<AG-Public-IP>/app1/hostname.html
```

## Step-07: Destroy Azure Application Gateway
- Go to Load Balancers -> Application Gateway -> ag-manual-1 
- Go to Settings -> Backend Pools
- **Add backend pool without targets:** Yes
- Click on **Save**
- Go to Overview Tab -> Click on **Delete**
- Once Application Gateway is completely deleted then only move to next step, else below error is expected and we need to run `terraform apply -destroy -auto-approve` twice
```log
╷
│ Error: deleting Subnet: (Name "hr-dev-vnet-agsubnet" / Virtual Network Name "hr-dev-vnet" / Resource Group "hr-dev-rg-iiqlft"): network.SubnetsClient#Delete: Failure sending request: StatusCode=0 -- Original Error: Code="InUseSubnetCannotBeDeleted" Message="Subnet hr-dev-vnet-agsubnet is in use by /subscriptions/82808767-144c-4c66-a320-b30791668b0a/resourceGroups/hr-dev-rg-iiqlft/providers/Microsoft.Network/applicationGateways/ag-manual-1/gatewayIPConfigurations/appGatewayIpConfig and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet." Details=[]
│ 
│ 
╵
Kalyans-Mac-mini:terraform-manifests kalyanreddy
```

## Step-08: Destroy other Azure Resources created using Terraform
```t
# Destroy Resources
terraform apply -destroy -auto-approve
or
terraform destroy -auto-approve

# Clean-Up
rm -rf .terraform*
rm -rf terraform.tfstate*
```


## Additional Reference
- [Azure Application Gateway Components](https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-components)






