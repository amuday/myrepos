packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}