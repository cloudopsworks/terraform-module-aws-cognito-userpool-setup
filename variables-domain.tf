##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "domain_alias" {
  description = "Host label for the Cognito custom domain. When set with domain_zone, the module creates <domain_alias>.<domain_zone>. Defaults to empty."
  type        = string
  default     = ""
  nullable    = false
}

variable "domain_zone" {
  description = "Base DNS zone for the Cognito custom domain. When set with domain_alias, the module creates <domain_alias>.<domain_zone>. Defaults to empty."
  type        = string
  default     = ""
  nullable    = false
}

variable "domain_certificate" {
  description = "Whether to attach an ACM certificate to the Cognito custom domain. Defaults to true."
  type        = bool
  default     = true
  nullable    = false
}

variable "domain_certificate_arn" {
  description = "Existing ACM certificate ARN for the Cognito custom domain. Leave empty to use the module ACM helper or Terragrunt dependency injection."
  type        = string
  default     = ""
  nullable    = false
}

variable "cross_account_acm" {
  description = "Whether certificate/domain operations use the aws.cross_account provider alias supplied by the caller."
  type        = bool
  default     = false
  nullable    = false
}

variable "alerts" {
  description = "ACM certificate alert metadata forwarded to the certificate helper module."
  type = object({
    enabled       = optional(bool, false)
    priority      = optional(number, 3)
    sns_topic_arn = optional(string, "")
  })
  default  = {}
  nullable = false
}