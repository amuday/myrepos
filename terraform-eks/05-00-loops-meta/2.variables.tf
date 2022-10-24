variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "Instance Key pair"
  type        = string
  default     = "terraform-key"

}

variable "instance_type_list" {
  description = "instance types"
  type        = list(string)
  default     = ["t2.micro", "t3.micro"]
}

variable "instance_type_map" {
  description = "instance types"
  type        = map(string)
  default = {
    "dev" = "t3.micro",
    "qa"  = "t2.micro"
  }
}