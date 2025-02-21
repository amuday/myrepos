resource "azurerm_resource_group" "vmss" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vmss" {
  name                = "vmss-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.vmss.name
  tags                = var.tags
}

resource "azurerm_subnet" "vmss" {
  name                 = "vmss-subnet"
  resource_group_name  = azurerm_resource_group.vmss.name
  virtual_network_name = azurerm_virtual_network.vmss.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "this" {
  name                = "vmss-nsg"
  location            = azurerm_resource_group.vmss.location
  resource_group_name = azurerm_resource_group.vmss.name

  security_rule {
    name                       = "http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.vmss.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tls_private_key" {
  content  = tls_private_key.this.private_key_openssh
  filename = "${path.module}/private_key_openssh"
}

resource "azurerm_public_ip_prefix" "vmss" {
  name                = "vmsspublicipprefix"
  resource_group_name = azurerm_resource_group.vmss.name
  location            = azurerm_resource_group.vmss.location
  prefix_length       = 28
}


resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "test-vmss"
  resource_group_name = azurerm_resource_group.vmss.name
  location            = azurerm_resource_group.vmss.location
  sku                 = "Standard_B1s"
  instances           = 1
  admin_username      = "adminuser"
  user_data = filebase64("${path.module}/app-scripts/nginx.sh")

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.this.public_key_openssh
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.vmss.id

      public_ip_address {
        name         = "vmss-public-ip"
        public_ip_prefix_id = azurerm_public_ip_prefix.vmss.id
      }
    }
  }
}