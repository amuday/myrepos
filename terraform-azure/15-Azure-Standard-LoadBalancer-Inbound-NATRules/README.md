---
title: Azure Load Balancer Inbound NAT Rules using Terraform
description: Create Azure Standard Load Balancer Inbound NAT Rules using Terraform
---
https://learn.microsoft.com/en-us/azure/load-balancer/inbound-nat-rules

## Inbound NAT rules
	Allows to ssh into VMs using load balancer IP. 
	You can ssh into VM through bastion host as well.

## Introduction
- We are going to create Inbound NAT Rule for Standard Load Balancer in this demo
1. azurerm_lb_nat_rule
2. azurerm_network_interface_nat_rule_association
3. Verify the SSH Connectivity to Web Linux VM using Load Balancer Public IP with port 1022


# Verify Inbound NAT Rules
ssh -i ssh-keys/terraform-azure.pem -p 1022 azureuser@<LB-Public-IP>

