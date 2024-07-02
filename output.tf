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