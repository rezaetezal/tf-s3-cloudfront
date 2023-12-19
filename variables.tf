#####################################################################
# General
#####################################################################

variable "site_name" {
  type = string

  description = "A unique name for the site. Used as the name of the S3 bucket."
}

variable "site_description" {
  type        = string
  description = "The site description. Used for the comment field in CloudFron distribution."
}

variable "site_fqdn" {
  type        = string
  description = "The site FQDN. Used as the alias for the CloudFront distributopn."
}

variable "common_tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) Map of tags applied to all applicable resources."
}

#####################################################################
# CloudFront
#####################################################################

variable "cloudfront_cache_behavior_compress" {
  default     = "true"
  type        = string
  description = "(Optional) Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header."
}

variable "cloudfront_allowed_methods" {
  default     = ["*"]
  type        = list(string)
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
}

variable "cloudfront_cached_methods" {
  default     = ["*"]
  type        = list(string)
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
}

variable "cloudfront_cache_policy_name" {
  default     = "CachingDisabled"
  type        = string
  description = "The name of the Managed Cache Policy to use for this CloudFront distribution. Must be one of: CachingOptimized, CachingDisabled, CachingOptimizedForUncompressedObjects, Elemental-MediaPackag, Amplify. (Default: CachingDisabled)"
  validation {
    condition     = contains(["CachingOptimized", "CachingDisabled", "CachingOptimizedForUncompressedObjects", "Elemental-MediaPackage", "Amplify"], var.cloudfront_cache_policy_name)
    error_message = "Value must be one of: CachingOptimized, CachingDisabled, CachingOptimizedForUncompressedObjects, Elemental-MediaPackag, Amplify"
  }
}

variable "cloutfront_http_version" {
  default     = "http2"
  type        = string
  description = "Maximum HTTP version to support on the distribution. Must be one of http1.1, http2, http2and3 and http3. Default: http2."
  validation {
    condition     = contains(["http1.1", "http2", "http2and3", "http3"], var.cloutfront_http_version)
    error_message = "Value must be one of: http1.1, http2, http2and3, http3"
  }
}

variable "cloutfront_viewer_protocol_policy" {
  default     = "redirect-to-https"
  type        = string
  description = "Maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3. Default: redirect-to-https"
  validation {
    condition     = contains(["allow-all", "https-only", "redirect-to-https"], var.cloutfront_viewer_protocol_policy)
    error_message = "Value must be one of: allow-all, https-only, redirect-to-https"
  }
}

variable "cloutfront_price_class" {
  default     = "PriceClass_All"
  type        = string
  description = "Maximum HTTP version to support on the distribution. Allowed values are PriceClass_All, PriceClass_200, PriceClass_100. Default: PriceClass_All"
  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.cloutfront_price_class)
    error_message = "Value must be one of: PriceClass_All, PriceClass_200, PriceClass_100"
  }
}

# variable "cloudfront_security_policy" {
#   type        = string
#   description = "Minimum version of the SSL protocol for HTTPS connections"
#   default     = "TLSv1.2_2019"
# }
