# Setup
1. Create VMs
2. Create LB
    a. Create public IP
    b. Create LB
    c. define backend address pool
    d. attach VMs to backend address pool through network interface 
         azurerm_lb_backend_address_pool 
         azurerm_lb_backend_address_pool_address
    e. Define health probe
3. Go to azure portal and verify 
    a. load balancer
    b. frontend ip configuration
    c. backend pools
    d. health probes
    e. Load balancing rules


# Verification

1. Go to public ip of load balancer in a browser
2. http://IP
   http://IP/app1
   Check different IPs in below response
   http://4.227.227.188/app1/metadata.html 

# DNS
Add DNS server names into domain name service (free norm)
*** its not tested ***
