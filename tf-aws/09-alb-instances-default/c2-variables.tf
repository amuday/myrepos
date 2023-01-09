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

variable "instance_count" {
  type = number
}

variable "s3_bucket_name" {
  type = string
}

variable "elb_account_id" {
  type = string
}