#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM app - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app
sudo echo "Welcome to stacksimplify - WebVM app - VM Hostname: $(hostname)" > /var/www/html/app/hostname.html
sudo echo "Welcome to stacksimplify - WebVM app - App Status Page" > /var/www/html/app/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app/metadata.html