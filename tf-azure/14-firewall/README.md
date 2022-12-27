# Firewall
    Fully managed service
    To deploy a firewall, you need to have a subnet and firewall name should be same as subnet
    No IP address for firewall

    ## setup

    You need a separate subnet for firewall
    Firewall subnet 
        need a public IP address for internet facing 
        a private IP address

    Once firewall is created, rules need to setup else it does not have any impact.
    Create a route table and rules
        Destination IP : 0.0.0.0/0
        hop type: virtual appliciance 
        hop address: firewall private address
    Associate routetable with subnet where application is running

    Add NAT rule
        firewallpolicy -> DNAT rules -> Add rule collection 
    
    You can connect to firewall public IP and port 4000, from there you can access your VMs, eventhough your VMs have only private IP.

Need to validate