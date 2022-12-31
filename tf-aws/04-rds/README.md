# RDS


# to get default parameters 
    https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.MariaDB.Parameters.html
    aws rds describe-engine-default-parameters --db-parameter-group-family mariadb10.6

# to run
terraform apply -var RDS_PASSWORD=mypassword123

# validation 
    * ssh into EC2
    sudo yum install mysql
    # get endpoint from RDS
    mysql -u root -h mariadb.cmp76joavw16.us-east-1.rds.amazonaws.com -p'mypassword123'
    show databases;
    exit
    host mariadb.cmp76joavw16.us-east-1.rds.amazonaws.com
