resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "private_key.pem"
  content  = tls_private_key.this.private_key_pem
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.this.public_key_openssh
}

data "template_file" "script" {
  template = file("${path.module}/templates/script.sh")
  vars = {
    "app" = var.app_name
  }
}

resource "aws_instance" "test_ec2_instance" {
  # lookup can have default value  as 3rd argument
  ami           = lookup(var.AMIS, var.region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  #vpc_security_group_ids = ["sg-04e9c4fbe8808dc57"]
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.name]

  provisioner "local-exec" {
    command = "echo %date%%time% ${self.private_ip} >> private-ip.txt"
  }

  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "ec2-user"
    ##private_key = tls_private_key.this.private_key_openssh
    private_key = tls_private_key.this.private_key_pem
  }


  provisioner "file" {
    # if the source is a file use the below
    #source      = "scripts/app1.sh"

    # if source is a text use content as below
    content     = data.template_file.script.rendered
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
}

# provisioners can be independent of resource. Add depenends on if there is any error.
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo %date%%time% ${aws_instance.test_ec2_instance.private_ip} >> private-ip.txt"
  }
}