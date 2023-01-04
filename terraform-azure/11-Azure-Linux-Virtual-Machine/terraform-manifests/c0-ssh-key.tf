
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "ssh-keys/terraform-azure.pem"
  content  = tls_private_key.this.private_key_pem
}

resource "local_file" "public_key" {
  filename = "ssh-keys/terraform-azure.pub"
  content  = tls_private_key.this.public_key_pem
}