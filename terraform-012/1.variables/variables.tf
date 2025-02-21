variable "vpcname" {
  type        = string
  default     = "myvpc"
  description = "name of the vpc"
}
variable "sshport" {
  type    = number
  default = 22

}

variable "enabled" {
  default = true
}


# in list all elements should be of same type
variable "mylist" {
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

# As the value is not specified, terraform will prompt the user to enter the data.
variable "inputname" {
  type        = string
  description = "Enter VPC name"
  default = null
}

# tuple - similar to list but can have different types
variable "mytuple" {
  type    = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "testname"
    port = [22, 25, 80]
  }
}


variable "servers" {
  type = list(object({
    name   = string,
    size   = string,
    image  = string,
    region = string,
    tags   = list(string)
  }))
}

variable "ec2_instances" {

}


variable "containers" {
  type = map(map(string))
  default = {
    "container1" = {
      "context"  = "tfst"
      "instance" = "01"
    }
  }

}

