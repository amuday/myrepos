variable "location" {
  type        = string
  description = "location"
}

variable "resource_group" {
  type        = string
  description = "resource group"
}


variable "virtual_network" {
  type = map(any)
  default = {
    name          = "app-network"
    address_space = "10.0.0.0/16"
  }
}

# url paths of applications
variable "function" {
  type    = list(string)
  default = ["app1", "app2"]
}
