---
title: Terraform Meta-Argument Count 
description: Create multiple resources in Terraform with count
---

## Step-00: Introduction
- Terraform [Meta-Argument count](https://www.terraform.io/docs/language/meta-arguments/count.html) for Azure Web Linux VMs and VM Nics
- Terraform [Meta-Argument count](https://www.terraform.io/docs/language/meta-arguments/count.html) for Azure Standard Load Balancer for NIC to LB Associate Resource
- [Terraform Splat Expression](https://www.terraform.io/docs/language/expressions/splat.html)
- [Terraform element function](https://www.terraform.io/docs/language/functions/element.html)
### Changes as part of this Demo
- We are going to make change to following files
1. c7-01-web-linuxvm-input-variables.tf
2. terraform.tfvars
3. c7-03-web-linuxvm-network-interface.tf
4. c7-05-web-linuxvm-resource.tf
5. c7-06-web-linuxvm-outputs.tf
6. c9-02-web-loadbalancer-resource.tf
7. c9-04-web-loadbalancer-inbound-nat-rules.tf

### Bastion Host (Optional Changes)
- Additional Optional Changes to bastion host. As we are enabling Inbound NAT via LB bastion host in this usecase or demo is optional. 
- If you want you can comment all the code in below listed files to not to have Bastion Host created. 
- I am going to leave them as-is without commenting them. 
1. c8-01-bastion-host-input-variables.tf
2. c8-02-bastion-host-linuxvm.tf
3. c8-03-move-ssh-key-to-bastion-host.tf
4. c8-05-bastion-outputs.tf

### Additional Note for reference
1. Meta-Argument count - Terraform Function element()
2. Meta-Argument for_each with maps - Terraform Function lookup()

## Step-09: Verify Resources

# Verify Resources - Virtual Network
1. Azure Resource Group
2. Azure Virtual Network
3. Azure Subnets (Web, App, DB, Bastion)
4. Azure Network Security Groups (Web, App, DB, Bastion)
5. View the topology
6. Verify Terraform Outputs in Terraform CLI

# Verify Resources - Web Linux VM (2 Virtual Machines)
1. Verify Network Interface created for 2 Web Linux VMs
2. Verify 2 Web Linux VMs
3. Verify Network Security Groups associated with VM (web Subnet NSG)
4. View Topology at Web Linux VM -> Networking
5. Verify if only private IP associated with Web Linux VM

# Verify Resources - Bastion Host
1. Verify Bastion Host VM Public IP
2. Verify Bastion Host VM Network Interface
3. Verify Bastion VM
4. Verify Bastion VM -> Networking -> NSG Rules
5. Verify Bastion VM Topology

# Connect to Bastion Host VM
1. Connect to Bastion Host Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Host-LinuxVM-PublicIP>
sudo su - 
cd /tmp
ls 
2. terraform-azure.pem file should be present in /tmp directory

# Connect to Web Linux VM using Bastion Host VM
1. Connect to Web Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Web-LinuxVM-PrivateIP>
sudo su - 
cd /var/log
tail -100f cloud-init-output.log
cd /var/www/html
ls -lrt
cd /var/www/html/app1
ls -lrt
exit
exit

# Verify Standard Load Balancer Resources
1. Verify Public IP Address for Standard Load Balancer
2. Verify Standard Load Balancer (SLB) Resource
3. Verify SLB - Frontend IP Configuration
4. Verify SLB - Backend Pools
5. Verify SLB - Health Probes
6. Verify SLB - Load Balancing Rules
7. Verify SLB - Insights
8. Verify SLB - Diagnose and Solve Problems

# Access Application
http://<LB-Public-IP>
http://<LB-Public-IP>/app1/index.html
http://<LB-Public-IP>/app1/metadata.html

# Curl Test
curl http://<LB-Public-IP>

## Step-10: Verify Inbound NAT Rules for Port 22

# VM1 - Verify Inbound NAT Rule
ssh -i ssh-keys/terraform-azure.pem -p 1022 azureuser@<LB-Public-IP>

# VM2 - Verify Inbound NAT Rule
ssh -i ssh-keys/terraform-azure.pem -p 2022 azureuser@<LB-Public-IP>

# VM3 - Verify Inbound NAT Rule
ssh -i ssh-keys/terraform-azure.pem -p 3022 azureuser@<LB-Public-IP>

ssh -i ssh-keys\terraform-azure.pem -p 1022 azureuser@20.228.249.84
ssh -i ssh-keys\terraform-azure.pem -p 2022 azureuser@20.228.249.84
ssh -i ssh-keys\terraform-azure.pem -p 3022 azureuser@20.228.249.84