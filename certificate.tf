##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

module "certificates" {
  source = "git::https://github.com/cloudopsworks/terraform-module-aws-acm-certificate.git?ref=v1.2.9"
  providers = {
    aws               = aws
    aws.cross_account = aws.cross_account
  }
  is_hub            = var.is_hub
  spoke_def         = var.spoke_def
  org               = var.org
  extra_tags        = var.extra_tags
  create            = (var.domain_certificate_arn == "")
  domain_zone       = var.domain_zone
  domain_alias      = var.domain_alias
  domain_alternates = []
  cross_account     = var.cross_account_acm
  alerts            = var.alerts
  name_prefix       = format("cognito-%s", local.cognito_name)
}