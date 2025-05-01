variable "ssl_certs" {
  description = "SSL certificate for the web app"
  type        = list(string)
  default     = null
}