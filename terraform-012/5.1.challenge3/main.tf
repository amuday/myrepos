provider "aws" {
  region = "us-east-1"

}


module "db" {
  source = "./db"
}

module "web" {
  source = "./web"
}

# getting output from child module
output "dbserverPrivateIP" {
  value = module.db.dbserverPrivateIP

}

output "webpublicip" {
  value = module.web.pub_ip
}
