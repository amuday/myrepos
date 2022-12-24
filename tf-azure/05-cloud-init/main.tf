


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

data "template_file" "cloudinitdata" {
  template = file("script.sh")
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "linux-machine"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  custom_data = base64encode(data.template_file.cloudinitdata.rendered)

  network_interface_ids = [
    azurerm_network_interface.subnetA.id,
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
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  

}

