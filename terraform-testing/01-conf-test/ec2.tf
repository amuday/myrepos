
resource "aws_instance" "web" {
  subnet_id     = "subnet-public"
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "m7g.8xlarge"
}