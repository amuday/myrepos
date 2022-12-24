terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "app-grp"
  location = "East US"
}

resource "random_string" "random" {
  length  = 10
  lower   = true
  numeric = true
  special = false
  upper   = false
}

resource "azurerm_storage_account" "this" {
  name                     = "mysta${random_string.random.id}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # below is default storage
  account_kind = "StorageV2"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["73.174.231.228"]
    virtual_network_subnet_ids = [azurerm_subnet.subnetA.id]
  }


}


resource "azurerm_storage_container" "this" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "this" {
  name                   = "main.tf"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = "main.tf"

}