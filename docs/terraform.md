## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_certificates"></a> [certificates](#module\_certificates) | git::https://github.com/cloudopsworks/terraform-module-aws-acm-certificate.git | v1.2.9 |
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [aws_cognito_resource_server.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server) | resource |
| [aws_cognito_user_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts"></a> [alerts](#input\_alerts) | ACM certificate alert metadata forwarded to the certificate helper module. | <pre>object({<br/>    enabled       = optional(bool, false)<br/>    priority      = optional(number, 3)<br/>    sns_topic_arn = optional(string, "")<br/>  })</pre> | `{}` | no |
| <a name="input_cross_account_acm"></a> [cross\_account\_acm](#input\_cross\_account\_acm) | Whether certificate/domain operations use the aws.cross\_account provider alias supplied by the caller. | `bool` | `false` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Set to true to enable Cognito deletion protection on the user pool. Defaults to true. | `bool` | `true` | no |
| <a name="input_device_configuration"></a> [device\_configuration](#input\_device\_configuration) | Remembered-device challenge and prompt behavior for the user pool. Defaults to null. | <pre>object({<br/>    challenge_required = optional(bool, false)<br/>    remember_on_prompt = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_domain_alias"></a> [domain\_alias](#input\_domain\_alias) | Host label for the Cognito custom domain. When set with domain\_zone, the module creates <domain\_alias>.<domain\_zone>. Defaults to empty. | `string` | `""` | no |
| <a name="input_domain_certificate"></a> [domain\_certificate](#input\_domain\_certificate) | Whether to attach an ACM certificate to the Cognito custom domain. Defaults to true. | `bool` | `true` | no |
| <a name="input_domain_certificate_arn"></a> [domain\_certificate\_arn](#input\_domain\_certificate\_arn) | Existing ACM certificate ARN for the Cognito custom domain. Leave empty to use the module ACM helper or Terragrunt dependency injection. | `string` | `""` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | Base DNS zone for the Cognito custom domain. When set with domain\_alias, the module creates <domain\_alias>.<domain\_zone>. Defaults to empty. | `string` | `""` | no |
| <a name="input_email_configuration"></a> [email\_configuration](#input\_email\_configuration) | Email sending configuration for Cognito default email or SES developer mode. Defaults to null. | <pre>object({<br/>    default_method        = optional(bool, true)<br/>    from                  = optional(string, null)<br/>    reply_to_address      = optional(string, null)<br/>    ses_configuration_set = optional(string, null)<br/>    ses_source_arn        = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_enable_mfa"></a> [enable\_mfa](#input\_enable\_mfa) | Enable required MFA for the Cognito user pool. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_mfa_soft_token"></a> [enable\_mfa\_soft\_token](#input\_enable\_mfa\_soft\_token) | Enable software-token MFA when MFA is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags merged into all taggable resources. | `map(string)` | `{}` | no |
| <a name="input_invite_message_template"></a> [invite\_message\_template](#input\_invite\_message\_template) | Invitation message template used when administrators create users. | <pre>object({<br/>    email_message = optional(string, "Your username is {username} and temporary password is {####}.")<br/>    email_subject = optional(string, "Your temporary password")<br/>    sms_message   = optional(string, "Your username is {username} and temporary password is {####}.")<br/>  })</pre> | <pre>{<br/>  "email_message": "Your username is {username} and temporary password is {####}.",<br/>  "email_subject": "Your temporary password",<br/>  "sms_message": "Your username is {username} and temporary password is {####}."<br/>}</pre> | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Whether this deployment represents a hub environment instead of a spoke environment. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Explicit Cognito user pool name. Leave empty to derive the name from name\_prefix and the generated system name. | `string` | `""` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix used for the generated Cognito user pool name when name is empty. | `string` | `"user-pool"` | no |
| <a name="input_only_admin_create_user"></a> [only\_admin\_create\_user](#input\_only\_admin\_create\_user) | Set to true to allow only administrators to create users. Defaults to true. | `bool` | `true` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization and environment metadata loaded from Cloud Ops Works env-inputs.yaml. | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | Password policy for the Cognito user pool. Null uses AWS provider defaults. | <pre>object({<br/>    minimum_length                   = number<br/>    require_lowercase                = bool<br/>    require_numbers                  = bool<br/>    require_symbols                  = bool<br/>    require_uppercase                = bool<br/>    temporary_password_validity_days = number<br/>  })</pre> | `null` | no |
| <a name="input_recovery_mechanisms"></a> [recovery\_mechanisms](#input\_recovery\_mechanisms) | Account recovery mechanisms and priorities for the user pool. Defaults to an empty list. | <pre>list(object({<br/>    name     = string<br/>    priority = number<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_servers"></a> [resource\_servers](#input\_resource\_servers) | OAuth resource servers and scopes exposed by the user pool. Defaults to an empty list. | `any` | `[]` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | Custom Cognito user attribute schema definitions. Defaults to an empty list. | <pre>list(object({<br/>    attribute_data_type      = string<br/>    developer_only_attribute = optional(bool, false)<br/>    mutable                  = optional(bool, true)<br/>    name                     = string<br/>    number_attribute_constraints = optional(object({<br/>      max_value = optional(string, null)<br/>      min_value = optional(string, null)<br/>    }), null)<br/>    required = optional(bool, false)<br/>    string_attribute_constraints = optional(object({<br/>      max_length = optional(string, null)<br/>      min_length = optional(string, null)<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_sms_authentication_message"></a> [sms\_authentication\_message](#input\_sms\_authentication\_message) | SMS MFA challenge message. Use {####} as the verification code placeholder. | `string` | `"Your authentication code is {####}"` | no |
| <a name="input_sms_configuration"></a> [sms\_configuration](#input\_sms\_configuration) | SMS IAM role and region configuration for Cognito SMS messages. Required when SMS MFA or SMS verification is enabled. | <pre>object({<br/>    external_id    = string<br/>    sns_caller_arn = string<br/>    sns_region     = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_sms_verification_message"></a> [sms\_verification\_message](#input\_sms\_verification\_message) | SMS verification message. Defaults to null and can conflict with verification\_message\_template in some AWS provider modes. | `string` | `null` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Three-digit spoke identifier used by the Cloud Ops Works naming and tagging convention. | `string` | `"001"` | no |
| <a name="input_username_attributes"></a> [username\_attributes](#input\_username\_attributes) | Attributes that can be used as username aliases for the user pool. Defaults to email. | `list(string)` | <pre>[<br/>  "email"<br/>]</pre> | no |
| <a name="input_verification_message_template"></a> [verification\_message\_template](#input\_verification\_message\_template) | Verification message template for code or link based verification. Defaults to null and can conflict with sms\_verification\_message in some AWS provider modes. | <pre>object({<br/>    confirm_with_link     = optional(bool, false)<br/>    email_message         = optional(string, "Your verification code is {####}")<br/>    email_message_by_link = optional(string, "Please Click {##Click Here##} to verify your email address.")<br/>    email_subject         = optional(string, "Your verification code")<br/>    email_subject_by_link = optional(string, "Your verification link")<br/>    sms_message           = optional(string, "Your verification code is {####}")<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognito_arn"></a> [cognito\_arn](#output\_cognito\_arn) | ARN of the Cognito user pool. |
| <a name="output_cognito_custom_domain"></a> [cognito\_custom\_domain](#output\_cognito\_custom\_domain) | CloudFront distribution details for the Cognito custom domain when configured. |
| <a name="output_cognito_domain"></a> [cognito\_domain](#output\_cognito\_domain) | AWS-managed domain prefix for the Cognito user pool. |
| <a name="output_cognito_endpoint"></a> [cognito\_endpoint](#output\_cognito\_endpoint) | Endpoint of the Cognito user pool. |
| <a name="output_cognito_id"></a> [cognito\_id](#output\_cognito\_id) | ID of the Cognito user pool. |
