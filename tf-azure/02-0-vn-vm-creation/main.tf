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
  #subscription_id = "6be8a5c0-01e9-4fda-8034-3405c47f87bf"

  # get below from app registrations
  #tenant_id = "588bdde1-4178-4c13-96e6-3d214b90c98c"
  #client_id = "7cff38c5-2d42-4ec1-abcc-27631e3ce0bf"

  # get secret from terrafrom app registration -> Certificates & secrets -> create a new secret
  #client_secret = "ShO8Q~ENg_gR23qeXqwU684XeF7CRg5QmsZ2rbh-"
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "app-network"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnetA" {
  name                 = "subnetA"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnetB" {
  name                 = "subnetB"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_network_interface" "subnetA" {
  name                = "app-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_public_ip" "this" {
  name                = "mypublicIP"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "this" {
  name                = "app-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "allowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.subnetA.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")

}

resource "azurerm_managed_disk" "this" {
  name                 = "disk1"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  managed_disk_id    = azurerm_managed_disk.this.id
  virtual_machine_id = azurerm_linux_virtual_machine.this.id
  lun                = "10"
  caching            = "ReadWrite"
}