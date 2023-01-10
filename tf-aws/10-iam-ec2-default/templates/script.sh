#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo "<h1>Hello world from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/${app}
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/${app}/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/${app}/metadata.html
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Hello from EC2 instance $(hostname -f) " > test.txt
aws s3 cp test.txt s3://${s3_bucket_name}/test.txt