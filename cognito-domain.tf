##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
locals {
  cognito_domain = format("%s.%s", var.domain_alias, var.domain_zone)
}

resource "aws_cognito_user_pool_domain" "this" {
  count        = var.domain_alias != "" && var.domain_zone != "" ? 1 : 0
  domain       = local.cognito_domain
  user_pool_id = aws_cognito_user_pool.this.id
  certificate_arn = var.domain_certificate ? (var.domain_certificate_arn != "" ?
    var.domain_certificate_arn : module.certificates.acm_certificate_arn
  ) : null
  depends_on = [
    module.certificates
  ]
}

