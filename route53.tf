##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

data "aws_route53_zone" "this" {
  count = var.domain_create_cert || var.domain_create_record ? 1 : 0
  name  = var.domain_zone
}

resource "aws_route53_record" "this" {
  count   = var.domain_create_record ? 1 : 0
  name    = aws_cognito_user_pool_domain.this[0].domain
  type    = "A"
  zone_id = data.aws_route53_zone.this[0].id
  alias {
    evaluate_target_health = false
    name                   = aws_cognito_user_pool_domain.this[0].cloudfront_distribution_arn
    # This zone_id is fixed
    zone_id = aws_cognito_user_pool_domain.this[0].cloudfront_distribution_zone_id
  }
}
