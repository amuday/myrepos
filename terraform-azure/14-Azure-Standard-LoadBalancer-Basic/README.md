---
title: Azure Standard Load Balancer using Terraform
description: Create Azure Standard Load Balancer using Terraform
---

# Verify Standard Load Balancer Resources
1. Verify Public IP Address for Standard Load Balancer
2. Verify Standard Load Balancer (SLB) Resource
3. Verify SLB - Frontend IP Configuration
4. Verify SLB - Backend Pools
5. Verify SLB - Health Probes
6. Verify SLB - Load Balancing Rules
7. Verify SLB - Insights  *****
8. Verify SLB - Diagnose and Solve Problems

If you see warning in LB -> monitoring -> insights -> refresh and access LB url in browser

# Access Application
http://<LB-Public-IP>
http://<LB-Public-IP>/app1/index.html
http://<LB-Public-IP>/app1/metadata.html

There is an error in terraform destroy, delete the resource group from portal as an alternative.