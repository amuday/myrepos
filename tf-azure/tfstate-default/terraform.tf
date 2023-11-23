terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~>2.4"
    }
  }

  required_version = "~>1.6"

  backend "azurerm" {
    resource_group_name  = "a0a-12345-app-dev-rg-001"
    storage_account_name = "a0a12345appdevst001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    ## needed below for azure AD authentication
    use_azuread_auth = true

    #use_oidc = true

    #use_msi = true
  }
}
