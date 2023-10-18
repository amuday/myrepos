
/*
provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "ec2" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  count = 3
}
*/

variable "file" {
  default = [
    "file1",
    "file2",
    "file3"
  ]
  
}

resource "local_file" "main" {
  count = length(var.file)
  filename = "C:/Users/udayk/AppData/Local/Temp/test_${var.file[count.index]}.txt"
  content = "Hello world!!!"
}