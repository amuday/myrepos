
resource "tls_private_key" "linuxkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "linuxpemkey" {
  filename = "linuxkey.pem"
  content  = tls_private_key.linuxkey.private_key_pem
  depends_on = [
    tls_private_key.linuxkey
  ]
}
# Every VM need one network interface each

resource "azurerm_network_interface" "subnetA" {
  for_each            = var.environment
  name                = "${each.key}-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_virtual_network.this[each.key].subnet.*.id[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip[each.key].id
  }
}

# added public ip temporary, can deleted later
resource "azurerm_public_ip" "ip" {
  for_each            = var.environment
  name                = "${each.key}-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "this" {

  for_each            = var.environment
  name                = "VirtualMachine-${each.key}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.subnetA[each.key].id,
  ]


  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.linuxkey.public_key_openssh
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

