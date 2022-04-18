####################################
## Route53: Hosted Zone Variables ##
####################################

variable "hosted_zones" {
  description = "Specified settings for zones"
  type = map(object({
      name = string
      comment = string
      force_destroy = bool
      delegation_set_id = string
      private_zone = bool
      private_zone_settings = map(string)
      tags = map(string)
  }))
  default     = {}
}

###################################
## Route53: DNS Record Variables ##
###################################

variable "route53_records" {
  description = "Map of objects for DNS records to be created"
  type = map(object({
    zone_key = string
    name = string
    type = string
    ttl = number
    multivalue_answer_routing_policy = bool
    records = list(string)
    health_check_id = string
    set_identifier = string
    policy = map(any)
    create_alias = bool
    alias = map(object({
      name = string
      zone_key = string
      evaluate_target_health = bool
    }))
    allow_overwrite = bool
  }))
  default = null
}