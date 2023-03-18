provider "azurerm" {
  version = "~> 3.37"
  features {}
}

terraform {
  required_version = "~> 1.3"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "terratest-rg-${var.postfix}"
  location = var.location
}