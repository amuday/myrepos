resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "ssh-keys/private_key.pem"
  content  = tls_private_key.this.private_key_pem
}

resource "local_file" "public_key" {
  filename = "ssh-keys/public_key.pub"
  content  = tls_private_key.this.public_key_pem
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.this.public_key_openssh
}