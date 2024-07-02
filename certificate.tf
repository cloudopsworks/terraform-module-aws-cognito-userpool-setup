##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

# module "certificate" {
#   count = var.domain_create_cert ? 1 : 0
#   providers = {
#     aws.cross_account = aws.cross_account
#   }
#   source            = "github.com/cloudopsworks/terraform-module-aws-acm-certificate.git//?ref=master"
#   is_hub            = var.is_hub
#   org               = var.org
#   spoke_def         = var.spoke_def
#   domain_alias      = var.domain_alias
#   domain_zone       = var.domain_zone
#   domain_alternates = var.domain_alternates
#   cross_account     = var.dns_cross_account
# }