## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
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
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Set to true to enable deletion protection on the user pool, defaults to true. | `bool` | `true` | no |
| <a name="input_device_configuration"></a> [device\_configuration](#input\_device\_configuration) | Device configuration for the user pool, defaults to 'null'. | <pre>object({<br/>    challenge_required = optional(bool, false)<br/>    remember_on_prompt = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_domain_alias"></a> [domain\_alias](#input\_domain\_alias) | The domain alias for the user pool, defaults to empty. | `string` | `""` | no |
| <a name="input_domain_certificate_arn"></a> [domain\_certificate\_arn](#input\_domain\_certificate\_arn) | The domain certificate ARN for the user pool, defaults to empty. | `string` | `""` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | The domain zone for the user pool, defaults to empty. | `string` | `""` | no |
| <a name="input_email_configuration"></a> [email\_configuration](#input\_email\_configuration) | Email configuration for the user pool, defaults to 'null'. | <pre>object({<br/>    default_method        = optional(string, true)<br/>    from                  = optional(string, null)<br/>    reply_to_address      = optional(string, null)<br/>    ses_configuration_set = optional(string, null)<br/>    ses_source_arn        = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_enable_mfa"></a> [enable\_mfa](#input\_enable\_mfa) | Enable MFA for the user pool, defaults to false. | `bool` | `false` | no |
| <a name="input_enable_mfa_soft_token"></a> [enable\_mfa\_soft\_token](#input\_enable\_mfa\_soft\_token) | Enable software token MFA for the user pool, defaults to false. | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_invite_message_template"></a> [invite\_message\_template](#input\_invite\_message\_template) | The invite message template for the user pool, defaults to null. | <pre>object({<br/>    email_message = optional(string, "Your username is {username} and temporary password is {####}.")<br/>    email_subject = optional(string, "Your temporary password")<br/>    sms_message   = optional(string, "Your username is {username} and temporary password is {####}.")<br/>  })</pre> | <pre>{<br/>  "email_message": "Your username is {username} and temporary password is {####}.",<br/>  "email_subject": "Your temporary password",<br/>  "sms_message": "Your username is {username} and temporary password is {####}."<br/>}</pre> | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Establish this is a HUB or spoke configuration | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the user pool. | `string` | `""` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix of the user pool. | `string` | `"user-pool"` | no |
| <a name="input_only_admin_create_user"></a> [only\_admin\_create\_user](#input\_only\_admin\_create\_user) | Set to true to only allow admins to create users, defaults to true. | `bool` | `true` | no |
| <a name="input_org"></a> [org](#input\_org) | n/a | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | Password policy for the user pool | <pre>object({<br/>    minimum_length                   = number<br/>    require_lowercase                = bool<br/>    require_numbers                  = bool<br/>    require_symbols                  = bool<br/>    require_uppercase                = bool<br/>    temporary_password_validity_days = number<br/>  })</pre> | `null` | no |
| <a name="input_recovery_mechanisms"></a> [recovery\_mechanisms](#input\_recovery\_mechanisms) | The recovery mechanisms for the user pool, defaults to empty list. | <pre>list(object({<br/>    name     = string<br/>    priority = number<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_servers"></a> [resource\_servers](#input\_resource\_servers) | Resource servers for the user pool, defaults to empty list. | `any` | `[]` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | The schema for the user pool, defaults to empty list. | <pre>list(object({<br/>    attribute_data_type      = string<br/>    developer_only_attribute = optional(bool, false)<br/>    mutable                  = optional(bool, true)<br/>    name                     = string<br/>    number_attribute_constraints = optional(object({<br/>      max_value = optional(string, null)<br/>      min_value = optional(string, null)<br/>    }), null)<br/>    required = optional(bool, false)<br/>    string_attribute_constraints = optional(object({<br/>      max_length = optional(string, null)<br/>      min_length = optional(string, null)<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_sms_authentication_message"></a> [sms\_authentication\_message](#input\_sms\_authentication\_message) | The SMS authentication message for the user pool, defaults to 'Your authentication code is {####}'. | `string` | `"Your authentication code is {####}"` | no |
| <a name="input_sms_configuration"></a> [sms\_configuration](#input\_sms\_configuration) | SMS configuration for the user pool, defaults to 'null', required if MFA is enabled. | <pre>object({<br/>    external_id    = string<br/>    sns_caller_arn = string<br/>    sns_region     = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_sms_verification_message"></a> [sms\_verification\_message](#input\_sms\_verification\_message) | The SMS verification message for the user pool, defaults to null, can conflict with 'verification\_message\_template'. | `string` | `null` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | n/a | `string` | `"001"` | no |
| <a name="input_username_attributes"></a> [username\_attributes](#input\_username\_attributes) | The attributes to be used as the username for the user pool, defaults to 'email'. | `list(string)` | <pre>[<br/>  "email"<br/>]</pre> | no |
| <a name="input_verification_message_template"></a> [verification\_message\_template](#input\_verification\_message\_template) | The verification message template for the user pool, defaults to null, can conflict with 'sms\_verification\_message'. | <pre>object({<br/>    confirm_with_link     = optional(bool, false)<br/>    email_message         = optional(string, "Your verification code is {####}")<br/>    email_message_by_link = optional(string, "Please Click {##Click Here##} to verify your email address.")<br/>    email_subject         = optional(string, "Your verification code")<br/>    email_subject_by_link = optional(string, "Your verification link")<br/>    sms_message           = optional(string, "Your verification code is {####}")<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognito_arn"></a> [cognito\_arn](#output\_cognito\_arn) | n/a |
| <a name="output_cognito_custom_domain"></a> [cognito\_custom\_domain](#output\_cognito\_custom\_domain) | n/a |
| <a name="output_cognito_domain"></a> [cognito\_domain](#output\_cognito\_domain) | n/a |
| <a name="output_cognito_endpoint"></a> [cognito\_endpoint](#output\_cognito\_endpoint) | n/a |
| <a name="output_cognito_id"></a> [cognito\_id](#output\_cognito\_id) | n/a |
