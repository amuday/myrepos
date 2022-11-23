Tested and working as expected.

# To login to private instance
    sudo ssh -i /tmp/terraform-key.pem ec2-user@10.0.2.168

# Create a free domain
    1. create domain, devopsdemo.tk in https://www.freenom.com/en/index.html?lang=en
    2. Steps is available at 
        https://medium.com/@kcabading/getting-a-free-domain-for-your-ec2-instance-3ac2955b0a2f
        https://www.howtoinmagento.com/2019/03/get-1-year-free-domain-and-point-to-aws.html
    3. Added domain to route 53
        Route 53 -> Create Hosted Zone 
        Enter Domain Name
        Keep domain as public and save
    4. Copy name servers from AWS and place it freenom.
        login to your Freenom account 
        Services-> My Domains -> Manage Domain -> Management Tools -> Nameservers -> Use custom nameservers (enter below)
            enter all the 4 nameservers and hit Change Nameservers.