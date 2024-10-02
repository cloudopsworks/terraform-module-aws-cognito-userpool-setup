##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

variable "name" {
  description = "The name of the user pool."
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "The prefix of the user pool."
  type        = string
  default     = "user-pool"
}

variable "deletion_protection" {
  description = "Set to true to enable deletion protection on the user pool, defaults to true."
  type        = bool
  default     = true
}
variable "password_policy" {
  description = "Password policy for the user pool"
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
  description = "Enable MFA for the user pool, defaults to false."
  type        = bool
  default     = false
}

variable "enable_mfa_soft_token" {
  description = "Enable software token MFA for the user pool, defaults to false."
  type        = bool
  default     = false
}

variable "sms_configuration" {
  description = "SMS configuration for the user pool, defaults to 'null', required if MFA is enabled."
  type = object({
    external_id    = string
    sns_caller_arn = string
    sns_region     = optional(string, null)
  })
  default = null
}

variable "username_attributes" {
  description = "The attributes to be used as the username for the user pool, defaults to 'email'."
  type        = list(string)
  default     = ["email"]
}

variable "sms_authentication_message" {
  description = "The SMS authentication message for the user pool, defaults to 'Your authentication code is {####}'."
  type        = string
  default     = "Your authentication code is {####}"
}

variable "sms_verification_message" {
  description = "The SMS verification message for the user pool, defaults to null, can conflict with 'verification_message_template'."
  type        = string
  default     = null
}

variable "recovery_mechanisms" {
  description = "The recovery mechanisms for the user pool, defaults to empty list."
  type = list(object({
    name     = string
    priority = number
  }))
  default = []
}

variable "only_admin_create_user" {
  description = "Set to true to only allow admins to create users, defaults to true."
  type        = bool
  default     = true
}

variable "invite_message_template" {
  description = "The invite message template for the user pool, defaults to null."
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
}

variable "verification_message_template" {
  description = "The verification message template for the user pool, defaults to null, can conflict with 'sms_verification_message'."
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
  description = "The schema for the user pool, defaults to empty list."
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
  default = []
}

variable "email_configuration" {
  description = "Email configuration for the user pool, defaults to 'null'."
  type = object({
    default_method        = optional(string, true)
    from                  = optional(string, null)
    reply_to_address      = optional(string, null)
    ses_configuration_set = optional(string, null)
    ses_source_arn        = optional(string, null)
  })
  default = null
}

variable "device_configuration" {
  description = "Device configuration for the user pool, defaults to 'null'."
  type = object({
    challenge_required = optional(bool, false)
    remember_on_prompt = optional(bool, false)
  })
  default = null
}

variable "resource_servers" {
  description = "Resource servers for the user pool, defaults to empty list."
  type        = any
  default     = []
}