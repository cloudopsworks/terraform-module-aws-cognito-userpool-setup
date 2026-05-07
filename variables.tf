##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# Establish this is a HUB or spoke configuration
variable "is_hub" {
  description = "Whether this deployment represents a hub environment instead of a spoke environment."
  type        = bool
  default     = false
}

variable "spoke_def" {
  description = "Three-digit spoke identifier used by the Cloud Ops Works naming and tagging convention."
  type        = string
  default     = "001"
  validation {
    condition     = (length(var.spoke_def) == 3) && tonumber(var.spoke_def) != null
    error_message = "The spoke_def must be a 3 digit number as string."
  }
}

variable "org" {
  description = "Organization and environment metadata loaded from Cloud Ops Works env-inputs.yaml."
  type = object({
    organization_name = string
    organization_unit = string
    environment_type  = string
    environment_name  = string
  })
}

variable "extra_tags" {
  description = "Additional tags merged into all taggable resources."
  type        = map(string)
  default     = {}
}
