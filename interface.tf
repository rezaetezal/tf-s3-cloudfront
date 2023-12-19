#####################################################################
# General
#####################################################################

variable "stack_name" {
  type = string

  description = <<DESC
The stack's name; used to derive component resource names throughout the stack.
DESC
}

variable "pod_name" {
  type = string

  description = <<DESC
VC pod identity (i.e. sit1, na2, etc.); used to derive component resource names
throughout the stack. If the stack does not have a designated pod, please
specify the core (i.e. dlore1, ore1, fra1 etc.).
DESC
}

variable "stack_description" {
  type        = string
  description = "A description of the stack;: what it does, who it serves, etc."
}

variable "common_tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) Map of tags applied to all applicable resources."
}

#####################################################################
# DNS
#####################################################################

variable "hostname" {
  type        = string
  description = "Hostname for the CloudFront distribution"
}

variable "domain" {
  type        = string
  description = "Domain name for the CloudFront distribution"
}

variable "alt_domain" {
  type        = string
  description = "Alt Domain name for AWS Route 53 Zone"
  default     = null
}

variable "create_r53" {
  type        = bool
  default     = true
  description = "Boolean to control whether R53 alias create is created for Cloudfront distro"
}

#####################################################################
# S3 Bucket
#####################################################################

variable "s3_bucket_acceleration_status" {
  default     = "Suspended"
  type        = string
  description = <<DESC
(Optional) Sets the accelerate configuration of an existing bucket. Can be
"Enabled" or "Suspended"
DESC
}

variable "s3_bucket_force_destroy" {
  default     = true
  type        = string
  description = <<DESC
(Optional) A boolean that indicates all objects (including any locked objects)
should be deleted from the bucket so that the bucket can be destroyed without
error. These objects are not recoverable.
DESC
}

variable "s3_bucket_cors_rules" {
  default = []
  type = list(object({
    allowed_headers = optional(list(string))
    allowed_methods = optional(list(string))
    allowed_origins = optional(list(string))
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
    id              = optional(string)
  }))
  description = <<DESC
(Optional) A list of CORS Rule maps. Each map can have key values of
allowed_headers (list), allowed_methods (list), allowed_origins (list), 
expose_headers (list), max_age_seconds (number), and id (string).
e.g.
[
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website-test.hashicorp.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    { 
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
    }
]
DESC
}

#####################################################################
# CloudFront
#####################################################################

variable "cloudfront_default_cache_behavior_compress" {
  default     = "true"
  type        = string
  description = <<DESC
(Optional) Whether you want CloudFront to automatically compress content for
web requests that include Accept-Encoding: gzip in the request header.
DESC
}

variable "cloudfront_forwarded_headers" {
  default     = []
  type        = list(string)
  description = "A list of headers that CloudFront should forward to S3."
}

variable "cloudfront_security_policy" {
  type        = string
  description = "Minimum version of the SSL protocol for HTTPS connections"
  default     = "TLSv1.2_2019"
}

#####################################################################
# DUALHOME CERT
#####################################################################
variable "dualhome_cert_arn" {
  type        = string
  description = "ARN for the DualHome ACM cert"
  default     = null
}
