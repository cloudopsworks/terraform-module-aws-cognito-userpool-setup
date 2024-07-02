##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

output "cognito_id" {
  value = aws_cognito_user_pool.this.id
}

output "cognito_arn" {
  value = aws_cognito_user_pool.this.arn
}

output "cognito_endpoint" {
  value = aws_cognito_user_pool.this.endpoint
}

output "cognito_domain" {
  value = aws_cognito_user_pool.this.domain
}

output "cognito_custom_domain" {
  value = var.domain_alias == "" || var.domain_zone == "" ? {} : {
    cloudfront_distribution = aws_cognito_user_pool_domain.this[0].cloudfront_distribution
    cloudfront_arn =aws_cognito_user_pool_domain.this[0].cloudfront_distribution_arn
    cloudfront_zone =aws_cognito_user_pool_domain.this[0].cloudfront_distribution_zone_id
    s3_bucket = aws_cognito_user_pool_domain.this[0].s3_bucket
    version= aws_cognito_user_pool_domain.this[0].version
  }
}
