data "aws_ec2_instance_type_offerings" "instance_types" {
 
  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }

  location_type = "availability-zone"
}