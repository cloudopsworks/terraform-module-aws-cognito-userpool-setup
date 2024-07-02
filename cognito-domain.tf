##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  cognito_domain = format("%s.%s", var.domain_alias, var.domain_zone)
}

resource "aws_cognito_user_pool_domain" "this" {
  count           = var.domain_alias != "" && var.domain_zone != "" ? 1 : 0
  domain          = local.cognito_domain
  user_pool_id    = aws_cognito_user_pool.this.id
  certificate_arn = var.domain_certificate_arn != "" ? var.domain_certificate_arn : (var.domain_create_cert ? module.certificate.acm_certificate_arn : null)
}

