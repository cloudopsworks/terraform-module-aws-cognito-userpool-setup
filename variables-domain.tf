##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "domain_alias" {
  description = "The domain alias for the user pool, defaults to empty."
  type        = string
  default     = ""
}

variable "domain_zone" {
  description = "The domain zone for the user pool, defaults to empty."
  type        = string
  default     = ""
}

variable "domain_certificate" {
  description = "Enable/Disable domain certificate for the user pool, defaults to true."
  type        = bool
  default     = true
  nullable    = false
}

variable "domain_certificate_arn" {
  description = "The domain certificate ARN for the user pool, defaults to empty."
  type        = string
  default     = ""
}

variable "cross_account_acm" {
  description = "The cross account to use for the Certificate domain, aws.cross_account provider must be set to module."
  type        = bool
  default     = false
  nullable    = false
}

variable "alerts" {
  description = "Enable alerts for API Gateway"
  type = object({
    enabled       = optional(bool, false)
    priority      = optional(number, 3)
    sns_topic_arn = optional(string, "")
  })
  default  = {}
  nullable = false
}