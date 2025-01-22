packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 1"
    }
  }
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type    = string
  default = "${env("ARM_CLIENT_SECRET")}"
}

variable "managed_resource_group" {
  type    = string
  default = "${env("ARM_RESOURCE_GROUP_NAME")}"
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}
# The following azure-arm source will use an Ubuntu v22.04 VM Image
# to install Nginx
source "azure-arm" "nginx" {
  client_id                         = "${var.client_id}"
  client_secret                     = "${var.client_secret}"
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "Canonical"
  image_sku                         = "22_04-lts-gen2"
  location                          = "East US"
  managed_image_name                = "nginx-packer-${formatdate("MM-DD-YY_hh-mm-ss", timestamp())}"
  managed_image_resource_group_name = "${var.managed_resource_group}"
  os_type                           = "Linux"
  subscription_id                   = "${var.subscription_id}"
  tenant_id                         = "${var.tenant_id}"
  vm_size                           = "Standard_B1s"
}
# The following will setup Nginx using Ansible Provisioner
# inside the azure-arm source
# After this build, there should now be a new Azure Image
build {
  sources = ["source.azure-arm.nginx"]

  provisioner "ansible" {
    extra_arguments = ["--scp-extra-args", "'-O'", "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa"]
    playbook_file   = "nginx.yaml"
    user            = "ubuntu"
  }

}