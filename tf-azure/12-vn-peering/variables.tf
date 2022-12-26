variable "location" {
  type        = string
  description = "location"
}

variable "resource_group" {
  type        = string
  description = "resource group"
}


variable "environment" {
  type = map(any)
  default = {
    staging = "10.0.0.0/16"
    test    = "10.1.0.0/16"
  }

}