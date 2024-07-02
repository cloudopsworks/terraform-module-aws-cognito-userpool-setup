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

output "cognito_domain_cloudfront" {
  value = aws_cognito_user_pool_domain.this.cloudfront_distribution
}

output "cognito_domain_cloudfront_arn" {
  value = aws_cognito_user_pool_domain.this.cloudfront_distribution_arn
}

output "cognito_domain_cloudfront_zone" {
  value = aws_cognito_user_pool_domain.this.cloudfront_distribution_zone_id
}

output "cognito_domain_s3_bucket" {
  value = aws_cognito_user_pool_domain.this.s3_bucket
}

output "cognito_domain_version" {
  value = aws_cognito_user_pool_domain.this.version
}