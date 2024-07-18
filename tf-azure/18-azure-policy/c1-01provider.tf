terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.37"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}