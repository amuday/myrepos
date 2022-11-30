
Update to latest versions of modules.
Used locals to handle instance ids between instance creation and ALB.

# Terraform Plan
terraform plan -var-file="secrets.tfvars"

# Terraform Apply
terraform apply -var-file="secrets.tfvars"

To verify DB data
    cd /var/log
    ls -lrt
    sudo tail -100f cloud-init-output.log
    mysql -h webappdb.cmp76joavw16.us-east-1.rds.amazonaws.com -u dbadmin -pdbpassword11
    
    MySQL [(none)]> show schemas
    MySQL [(none)]> use webappdb;
    MySQL [webappdb]> show tables;
    MySQL [webappdb]> select * from user;



https://dns-to-db.devopsdemo.tk/app1/index.html

https://dns-to-db.devopsdemo.tk/app2/index.html

https://dns-to-db.devopsdemo.tk/
Username: admin101
Password: password101