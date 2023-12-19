#####################################################################
# Cloudfront Data Sources
#####################################################################

data "aws_cloudfront_cache_policy" "s3hosting" {
  name = "Managed-${local.cloudfront_cache_policy_name}"
}

#####################################################################
# Cloudfront Resources
#####################################################################

resource "aws_cloudfront_distribution" "s3hosting" {
  depends_on = [aws_s3_bucket.s3hosting]

  comment      = local.site_description
  enabled      = true
  price_class  = local.cloudfront_price_class
  http_version = local.cloutfront_http_version

  aliases = compact([
    local.site_fqdn,
  ])

  origin {
    origin_id                = "origin-${local.site_name}"
    domain_name              = aws_s3_bucket.s3hosting.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3hosting.id
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  default_cache_behavior {
    cache_policy_id = data.aws_cloudfront_cache_policy.s3hosting.id

    target_origin_id = "origin-${local.site_name}"
    allowed_methods  = local.cloudfront_allowed_methods
    cached_methods   = local.cloudfront_cached_methods

    viewer_protocol_policy = local.cloutfront_viewer_protocol_policy
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "s3hosting" {
  name                              = "${local.site_name}-origin-acl"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
