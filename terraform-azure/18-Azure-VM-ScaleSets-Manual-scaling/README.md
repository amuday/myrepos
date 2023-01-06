---
title: Azure Virtual Machine Scale Sets with Terraform
description: Create Azure Virtual Machine Scale Sets with Terraform
---

## Introduction
- Create Azure Virtual Machine Scale Sets (VMSS)
- Associate Azure Virtual Machine Scale Sets with Azure Standard Load Balancer
- Terraform Dynamic Blocks
- Network Security Group with Inline Security Rules (Nested Blocks)
- Inline Network Security Rules - Re-Implement with Dynamic Blocks

# PPT
VMSS Manual -Topology 

# Web LB: Verify Internet Facing: Standard Load Balancer Resources 
1. Verify Public IP Address for Standard Load Balancer
2. Verify Standard Load Balancer (SLB) Resource
3. Verify SLB - Frontend IP Configuration
4. Verify SLB - Backend Pools
5. Verify SLB - Health Probes
6. Verify SLB - Load Balancing Rules
7. Verify SLB - Insights
8. Verify SLB - Diagnose and Solve Problems

global search -> Virtual machine scale set -> hr-dev-web-vmss -> Instances -> select specific instance -> Networking -> Topology

# Perform Curl Test on App VM
curl http://<LB-Public-IP>
curl http://<LB-Public-IP>
