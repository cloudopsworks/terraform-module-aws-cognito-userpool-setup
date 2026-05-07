##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name" {
  description = "Explicit Cognito user pool name. Leave empty to derive the name from name_prefix and the generated system name."
  type        = string
  default     = ""
  nullable    = false
}

variable "name_prefix" {
  description = "Prefix used for the generated Cognito user pool name when name is empty."
  type        = string
  default     = "user-pool"
  nullable    = false
}

variable "deletion_protection" {
  description = "Set to true to enable Cognito deletion protection on the user pool. Defaults to true."
  type        = bool
  default     = true
}
variable "password_policy" {
  description = "Password policy for the Cognito user pool. Null uses AWS provider defaults."
  type = object({
    minimum_length                   = number
    require_lowercase                = bool
    require_numbers                  = bool
    require_symbols                  = bool
    require_uppercase                = bool
    temporary_password_validity_days = number
  })
  default = null
}

variable "enable_mfa" {
  description = "Enable required MFA for the Cognito user pool. Defaults to false."
  type        = bool
  default     = false
  nullable    = false
}

variable "enable_mfa_soft_token" {
  description = "Enable software-token MFA when MFA is enabled. Defaults to false."
  type        = bool
  default     = false
  nullable    = false
}

variable "sms_configuration" {
  description = "SMS IAM role and region configuration for Cognito SMS messages. Required when SMS MFA or SMS verification is enabled."
  type = object({
    external_id    = string
    sns_caller_arn = string
    sns_region     = optional(string, null)
  })
  default = null
}

variable "username_attributes" {
  description = "Attributes that can be used as username aliases for the user pool. Defaults to email."
  type        = list(string)
  default     = ["email"]
  nullable    = false
}

variable "sms_authentication_message" {
  description = "SMS MFA challenge message. Use {####} as the verification code placeholder."
  type        = string
  default     = "Your authentication code is {####}"
  nullable    = false
}

variable "sms_verification_message" {
  description = "SMS verification message. Defaults to null and can conflict with verification_message_template in some AWS provider modes."
  type        = string
  default     = null
}

variable "recovery_mechanisms" {
  description = "Account recovery mechanisms and priorities for the user pool. Defaults to an empty list."
  type = list(object({
    name     = string
    priority = number
  }))
  default  = []
  nullable = false
}

variable "only_admin_create_user" {
  description = "Set to true to allow only administrators to create users. Defaults to true."
  type        = bool
  default     = true
  nullable    = false
}

variable "invite_message_template" {
  description = "Invitation message template used when administrators create users."
  type = object({
    email_message = optional(string, "Your username is {username} and temporary password is {####}.")
    email_subject = optional(string, "Your temporary password")
    sms_message   = optional(string, "Your username is {username} and temporary password is {####}.")
  })
  default = {
    email_message = "Your username is {username} and temporary password is {####}."
    email_subject = "Your temporary password"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }
  nullable = false
}

variable "verification_message_template" {
  description = "Verification message template for code or link based verification. Defaults to null and can conflict with sms_verification_message in some AWS provider modes."
  type = object({
    confirm_with_link     = optional(bool, false)
    email_message         = optional(string, "Your verification code is {####}")
    email_message_by_link = optional(string, "Please Click {##Click Here##} to verify your email address.")
    email_subject         = optional(string, "Your verification code")
    email_subject_by_link = optional(string, "Your verification link")
    sms_message           = optional(string, "Your verification code is {####}")
  })
  default = null
}

variable "schema" {
  description = "Custom Cognito user attribute schema definitions. Defaults to an empty list."
  type = list(object({
    attribute_data_type      = string
    developer_only_attribute = optional(bool, false)
    mutable                  = optional(bool, true)
    name                     = string
    number_attribute_constraints = optional(object({
      max_value = optional(string, null)
      min_value = optional(string, null)
    }), null)
    required = optional(bool, false)
    string_attribute_constraints = optional(object({
      max_length = optional(string, null)
      min_length = optional(string, null)
    }), null)
  }))
  default  = []
  nullable = false
}

variable "email_configuration" {
  description = "Email sending configuration for Cognito default email or SES developer mode. Defaults to null."
  type = object({
    default_method        = optional(bool, true)
    from                  = optional(string, null)
    reply_to_address      = optional(string, null)
    ses_configuration_set = optional(string, null)
    ses_source_arn        = optional(string, null)
  })
  default = null
}

variable "device_configuration" {
  description = "Remembered-device challenge and prompt behavior for the user pool. Defaults to null."
  type = object({
    challenge_required = optional(bool, false)
    remember_on_prompt = optional(bool, false)
  })
  default = null
}

variable "resource_servers" {
  description = "OAuth resource servers and scopes exposed by the user pool. Defaults to an empty list."
  type        = any
  default     = []
  nullable    = false
}