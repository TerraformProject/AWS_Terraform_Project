#########################
## Hosted Zone Outputs ##
#########################

output "Hosted_Zone_Zone_1" {
  description = "Zone of Route53 zone"
  value       = aws_route53_zone.this["Zone1"]
}

############################
## Route53 Record Outputs ##
############################

output "Hosted_Zone_Records" {
  description = "Records of Route53 zone"
  value       = aws_route53_record.this[*]
}