variable "prefix" {
    type = string
    description = "prefix"
}

variable "tags" {
    type = map(string)
    description = "tags"
    default = {
        project = "packer-demo"
        created-by = "terraform"
    }
}
