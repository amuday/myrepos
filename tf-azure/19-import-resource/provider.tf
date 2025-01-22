terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  # Configuration options

  subscription_id="8174109a-86db-4fdb-a978-e4a3657503fa"
  features {}
}