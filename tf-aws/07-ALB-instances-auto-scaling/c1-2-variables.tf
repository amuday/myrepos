variable "region" {
  type        = string
  description = "Region"
  default     = "us-east-1"

}

variable "AMIS" {
  type = map(string)
  default = {
    "us-east-1" = "ami-026b57f3c383c2eec"
  }
}

variable "app_name" {
  type    = string
  default = "myapp"

}

variable "prefix" {
  type    = string
  default = "dev"
}

variable "project" {
  type    = string
  default = "demo"
}

variable "contact" {
  type = string
}
