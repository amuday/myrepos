variable "vpcname" {
  type        = string
  default     = "myvpc"
  description = "name of the vpc"

  # other fields.
  # validation - A block to define validation rules, usually in addition to type constraints.
  # sensitive - Limits Terraform UI output when the variable is used in configuration.
  # nullable - Specify if the variable can be null within the module.
}

variable "sshport" {
  type    = number
  default = 22

}

variable "enabled" {
  default = true
}

variable "mylist" {
  # list always of same type
  type    = list(string)
  default = ["value1", "value2"]
}

variable "mymap" {
  type = map(any)
  default = {
    key1 = "value1",
    key2 = "value2"
  }
}

variable "inputname" {
  type        = string
  description = "Enter VPC name"
}

variable "mytuple" {
  type    = tuple([String, number, string])
  default = ["cat", 1, "dog"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "testname"
    port = [22, 25, 80]
  }
}



resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = var.inputname
  }
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}

