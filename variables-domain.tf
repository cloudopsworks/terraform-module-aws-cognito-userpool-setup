##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
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

variable "domain_certificate_arn" {
  description = "The domain certificate ARN for the user pool, defaults to empty."
  type        = string
  default     = ""
}

# variable "domain_create_cert" {
#   description = "Set to true to create a certificate for the domain, defaults to false."
#   type        = bool
#   default     = false
# }
#
# variable "domain_create_record" {
#   description = "Set to true to create a record for the domain, defaults to false."
#   type        = bool
#   default     = false
# }
#
# variable "domain_alternates" {
#   description = "The domain alternate aliases to use for the Certificate domain"
#   type        = list(string)
#   default     = []
# }
#
# variable "dns_cross_account" {
#   type    = bool
#   default = false
# }