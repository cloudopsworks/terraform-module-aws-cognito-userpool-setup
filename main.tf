##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_cognito_user_pool" "this" {
  name                       = "user-pool-${local.system_name}"
  deletion_protection        = var.deletion_protection ? "ACTIVE" : "INACTIVE"
  username_attributes        = var.username_attributes
  sms_authentication_message = var.sms_authentication_message
  sms_verification_message   = var.sms_verification_message

  dynamic "sms_configuration" {
    for_each = tolist(var.sms_configuration != null ? [var.sms_configuration] : [])
    content {
      external_id    = sms_configuration.value.external_id
      sns_caller_arn = sms_configuration.value.sns_caller_arn
      sns_region     = sms_configuration.value.sns_region
    }
  }

  mfa_configuration = var.enable_mfa ? "ON" : "OFF"
  dynamic "software_token_mfa_configuration" {
    for_each = tolist(var.enable_mfa_soft_token && var.enable_mfa ? [var.enable_mfa_soft_token] : [])
    content {
      enabled = software_token_mfa_configuration.value
    }
  }

  dynamic "email_configuration" {
    for_each = var.email_configuration != null ? [var.email_configuration] : []
    content {
      email_sending_account  = email_configuration.value.default_method ? "COGNITO_DEFAULT" : "DEVELOPER"
      from_email_address     = email_configuration.value.from_address
      reply_to_email_address = email_configuration.value.reply_to_address
      configuration_set      = email_configuration.value.ses_configuration_set
      source_arn             = email_configuration.value.ses_source_arn
    }
  }

  account_recovery_setting {
    dynamic "recovery_mechanism" {
      for_each = var.recovery_mechanisms
      content {
        name     = recovery_mechanism.value.name
        priority = recovery_mechanism.value.priority
      }
    }
  }

  dynamic "password_policy" {
    for_each = tolist(var.password_policy != null ? [var.password_policy] : [])
    content {
      minimum_length                   = password_policy.value.minimum_length
      require_lowercase                = password_policy.value.require_lowercase
      require_numbers                  = password_policy.value.require_numbers
      require_symbols                  = password_policy.value.require_symbols
      require_uppercase                = password_policy.value.require_uppercase
      temporary_password_validity_days = password_policy.value.temporary_password_validity_days
    }
  }

  dynamic "device_configuration" {
    for_each = var.device_configuration != null ? [var.device_configuration] : []
    content {
      challenge_required_on_new_device      = device_configuration.value.challenge_required
      device_only_remembered_on_user_prompt = device_configuration.value.remember_on_prompt
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = var.only_admin_create_user
    invite_message_template {
      email_message = var.invite_message_template.email_message
      email_subject = var.invite_message_template.email_subject
      sms_message   = var.invite_message_template.sms_message
    }
  }

  dynamic "verification_message_template" {
    for_each = tolist(var.verification_message_template != null ? [var.verification_message_template] : [])
    content {
      default_email_option  = verification_message_template.value.confirm_with_link ? "CONFIRM_WITH_LINK" : "CONFIRM_WITH_CODE"
      email_message         = verification_message_template.value.email_message
      email_message_by_link = verification_message_template.value.email_message_by_link
      email_subject         = verification_message_template.value.email_subject
      email_subject_by_link = verification_message_template.value.email_subject_by_link
      sms_message           = verification_message_template.value.sms_message
    }
  }

  dynamic "schema" {
    for_each = var.schema
    content {
      attribute_data_type      = schema.value.attribute_data_type
      developer_only_attribute = schema.value.developer_only_attribute
      mutable                  = schema.value.mutable
      name                     = schema.value.name
      dynamic "number_attribute_constraints" {
        for_each = schema.value.number_attribute_constraints != null ? [schema.value.number_attribute_constraints] : []
        content {
          max_value = number_attribute_constraints.value.max_value
          min_value = number_attribute_constraints.value.min_value
        }
      }
      required = schema.value.required
      dynamic "string_attribute_constraints" {
        for_each = schema.value.string_attribute_constraints != null ? [schema.value.string_attribute_constraints] : []
        content {
          max_length = string_attribute_constraints.value.max_length
          min_length = string_attribute_constraints.value.min_length
        }

      }
    }
  }

  tags = local.all_tags
}

output "schema" {
  value = var.schema
}