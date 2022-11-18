# variables automatically loaded from
#    terraform.tfvars
#    *.auto.tfvars

servers = [
  {
    name   = "server1",
    size   = "s-2vcpu-2gb"
    image  = "ubuntu-21-10-x64"
    region = "ams3",
    tags   = ["web", "development"]
  },
  {
    name   = "server2",
    size   = "s-2vcpu-2gb"
    image  = "ubuntu-20-04-x64"
    region = "lon1",
    tags   = ["web", "staging"]
  }
]