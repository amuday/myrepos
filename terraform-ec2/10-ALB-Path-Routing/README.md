Tested and working as expected.
Key pair gave error due to wrong file.

sudo ssh -i /tmp/terraform-key.pem ec2-user@10.0.2.168

created a domain devopsdemo.tk in https://www.freenom.com/en/index.html?lang=en

https://medium.com/@kcabading/getting-a-free-domain-for-your-ec2-instance-3ac2955b0a2f
https://www.howtoinmagento.com/2019/03/get-1-year-free-domain-and-point-to-aws.html


Route 53 -> Create Hosted Zone 
    Enter Domain Name
    Keep domain as public

Copy name servers from AWS and place it freenom.

login to your Freenom account go to 
    Services->My Domains -> Manage Domain ->Management Tools -> Nameservers -> select custom nameservers
    enter all the 4 nameservers and hit on the save button.