1. Add below into main.tf file

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

Run terraform apply

2. Add below block in main.tf

resource "aws_vpc" "myvpc2" {
  cidr_block = "192.168.0.0/16"
}

3. create a VPC manullay for step 2
4. import the vpc created in step 3

    λ terraform import aws_vpc.myvpc2 vpc-074310688668eaa79
    aws_vpc.myvpc2: Importing from ID "vpc-074310688668eaa79"...
    aws_vpc.myvpc2: Import prepared!
    Prepared aws_vpc for import
    aws_vpc.myvpc2: Refreshing state... [id=vpc-074310688668eaa79]

    Import successful!

    The resources that were imported are shown above. These resources are now in
    your Terraform state and will henceforth be managed by Terraform.

5. Run terraform destroy now, 2 VPCs will be deleted