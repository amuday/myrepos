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