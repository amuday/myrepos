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


ec2_instances = {
  "one" = {
    "arn" = "arn:aws:ec2:us-east-1:760030951132:instance/i-057016e571540dffd"
    "capacity_reservation_specification" = [
      {
        "capacity_reservation_preference" = "open"
        "capacity_reservation_target"     = "yes"
      },
    ]
    "id"                           = "i-057016e571540dffd"
    "instance_state"               = "running"
    "outpost_arn"                  = ""
    "password_data"                = ""
    "primary_network_interface_id" = "eni-09fdc0d0a5f92d5af"
    "private_dns"                  = "ip-172-31-19-154.ec2.internal"
    "private_ip"                   = "172.31.19.154"
    "public_dns"                   = "ec2-54-242-191-123.compute-1.amazonaws.com"
    "public_ip"                    = "54.242.191.123"
    "spot_bid_status"              = ""
    "spot_instance_id"             = ""
    "spot_request_state"           = ""
    "tags_all" = {
      "Environment" = "dev"
      "Name"        = "instance-one"
      "Terraform"   = "true"
    }
  }
  "three" = {
    "arn" = "arn:aws:ec2:us-east-1:760030951132:instance/i-0f53f0477ae10483b"
    "capacity_reservation_specification" = [
      {
        "capacity_reservation_preference" = "open"
        "capacity_reservation_target"     = "yes"
      },
    ]
    "id"                           = "i-0f53f0477ae10483b"
    "instance_state"               = "running"
    "outpost_arn"                  = ""
    "password_data"                = ""
    "primary_network_interface_id" = "eni-0f33d0aed9aa7e7db"
    "private_dns"                  = "ip-172-31-26-38.ec2.internal"
    "private_ip"                   = "172.31.26.38"
    "public_dns"                   = "ec2-34-228-58-69.compute-1.amazonaws.com"
    "public_ip"                    = "34.228.58.69"
    "spot_bid_status"              = ""
    "spot_instance_id"             = ""
    "spot_request_state"           = ""
    "tags_all" = {
      "Environment" = "dev"
      "Name"        = "instance-three"
      "Terraform"   = "true"
    }
  }
  "two" = {
    "arn" = "arn:aws:ec2:us-east-1:760030951132:instance/i-06d6485cc920dc9ba"
    "capacity_reservation_specification" = [
      {
        "capacity_reservation_preference" = "open"
        "capacity_reservation_target"     = "yes"
      },
    ]
    "id"                           = "i-06d6485cc920dc9ba"
    "instance_state"               = "running"
    "outpost_arn"                  = ""
    "password_data"                = ""
    "primary_network_interface_id" = "eni-0948276daf6b4a9bf"
    "private_dns"                  = "ip-172-31-28-84.ec2.internal"
    "private_ip"                   = "172.31.28.84"
    "public_dns"                   = "ec2-34-202-163-254.compute-1.amazonaws.com"
    "public_ip"                    = "34.202.163.254"
    "spot_bid_status"              = ""
    "spot_instance_id"             = ""
    "spot_request_state"           = ""
    "tags_all" = {
      "Environment" = "dev"
      "Name"        = "instance-two"
      "Terraform"   = "true"
    }
  }
}


containers = {
  "container1" = {
    "context"  = "tfst"
    "instance" = "01"
  }
  "container2" = {
    "context"  = "tfst"
    "instance" = "02"
  }
}