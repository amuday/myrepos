
# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name = "devopsdemo.tk"
}

# Output MyDomain Zone ID
output "mydomain_zoneid" {
  description = "Hosted Zone id of the desired Hosted Zone."
  value       = data.aws_route53_zone.mydomain.zone_id
}


# Output MyDomain name
output "mydomain_name" {
  description = "Hosted Zone name of the desired Hosted Zone."
  value       = data.aws_route53_zone.mydomain.name
}