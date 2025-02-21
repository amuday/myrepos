terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      #version = "4.19.0"
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
  subscription_id = "8174109a-86db-4fdb-a978-e4a3657503fa"
}