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
  #subscription_id = "6be8a5c0-01e9-4fda-8034-3405c47f87bf"

  # get below from app registrations. Create an app registration and get client id from there
  #tenant_id = "588bdde1-4178-4c13-96e6-3d214b90c98c"
  #client_id = "7cff38c5-2d42-4ec1-abcc-27631e3ce0bf"

  # get secret from terrafrom app registration -> Certificates & secrets -> create a new secret
  #client_secret = "ShO8Q~ENg_gR23qeXqwU684XeF7CRg5QmsZ2rbh-"
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