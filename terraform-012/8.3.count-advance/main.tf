provider "aws" {
  region = "us-east-1"
}

module "db" {
  source       = "./db"
  # passing arguments to child module
  server_names = ["mariadb", "mysql", "mssql"]

}

output "private_ips" {
  value = module.db.PrivateIPs
}