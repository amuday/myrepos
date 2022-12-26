variable "location" {
  type        = string
  description = "location"
}

variable "resource_group" {
  type        = string
  description = "resource group"
}

variable "number_of_machines" {
  type        = number
  description = "This defines the number of virtual machines in the virtual network"
  default     = 2
}