
# security group
    initially security group is not added and because of that not able to connect.
        vpc_security_group_ids = ["sg-04e9c4fbe8808dc57"]

# Topics covered
    key pair
    output variables
    provisioners
        file
        remote
        local
    template files
    security group

# terraform console
Add below into config files and try the commands

variable "myvar" {
    type = string
    default = "hello world!"  
}

variable "mymap" {
    type = map(string)
     default = {
    key1 = "value1",
    key2 = "value2"
  }
  
}

you can access terraform variables directly from console. commands are below.
        terraform console
        > var.myvar
            "hello world!"
        > "${var.myvar}"
            "hello world!"

        > var.mymap
        > var.mymap["key1"]            