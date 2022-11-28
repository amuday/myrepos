variable "filename" {
  type        = string
  description = "file name"
  default     = "test1.txt"
}

variable "content" {
  default = "Hello from terraform!!!"

}

variable "mylist" {
  #type    = list(any)
  type    = list(string)
  default = ["val1", "val2", "val3"]

}

variable "mymap" {
  #type = map(any)
  type = map(string)
  default = {
    # keys need not not be in double quotes. If it starts with a number then it should be in quotes.
    "key1" = "mapval1",
    "key2" = "mapval2"
    "key3" = "mapval3"
  }
}

# set elements cant be accessed using index. Need to iterate the entire set.
variable "myset" {
  #type    = set(any)
  type    = set(number)
  default = [2, 3, 7]

}

variable "myobject" {
  type = object({
    name  = string
    age   = number
    marks = list(number)
    pass  = bool

  })

  default = {
    name  = "John"
    age   = 10
    marks = [80, 85, 92, 76]
    pass  = true

  }

}

# tuple similar to list but can have elements od different types
variable "mytuple" {
  type    = tuple([string, number, bool])
  default = ["Mike", 10, true]
}