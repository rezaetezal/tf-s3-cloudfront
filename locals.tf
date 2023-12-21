#####################################################################
# Provider Configurations
#####################################################################
provider "aws" {
  default_tags {
    tags = local.common_tags
  }
}

#####################################################################
# Synthetic Values
#####################################################################

locals {
  site_name        = var.site_name
  site_description = var.site_description
  site_fqdn        = var.site_fqdn

  cloudfront_allowed_methods        = var.cloudfront_allowed_methods
  cloudfront_cached_methods         = var.cloudfront_cached_methods
  cloudfront_cache_policy_name      = var.cloudfront_cache_policy_name
  cloutfront_http_version           = var.cloutfront_http_version
  cloudfront_price_class            = var.cloutfront_price_class
  cloutfront_viewer_protocol_policy = var.cloutfront_viewer_protocol_policy


  common_tags = var.common_tags
}
