# tf-s3-cloudfront
---
> NOTE: In order to stay within (or, rather, to not go  much over) the expected ~2 hour limit allotted for this exercise, this is a very simple CF-S3 setup and lacks configration options for CORS rules for S3, or more robust cache and response header configuration in CloudFront. Nor does it handle the creation/management of thing such as Route53 records or ACM certificates. In order for this module to be production-worthy, it should probably be fleshed out with those, and more.

## This module will create a simple setup for hosting a website in S3 and distributed through CloudFront.
It will create/configure the following
* CloudFront Distribution with several config options (see [Inputs](#inputs-section) below)
* Origin Access Control (OAC)
* S3 bucket
    * Pivate ACL
    * Aliased to site's FQDN
    * Read-only access restricted to CloudFront distribution's OAC

## TFDOCS

### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

### Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |

### Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_s3_bucket.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_cloudfront_cache_policy.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_iam_policy_document.s3hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

### Inputs <a name='inputs-section'></a> 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| site\_description | The site description. Used for the comment field in CloudFron distribution. | `string` | n/a | yes |
| site\_fqdn | The site FQDN. Used as the alias for the CloudFront distributopn. | `string` | n/a | yes |
| site\_name | A unique name for the site. Used as the name of the S3 bucket. | `string` | n/a | yes |
| cloudfront\_allowed\_methods | Which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. | `list(string)` | <pre>[ "*" ]</pre> | no |
| cloudfront\_cache\_behavior\_compress | Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header. | `string` | `"true"` | no |
| cloudfront\_cache\_policy\_name | The name of the Managed Cache Policy to use for this CloudFront distribution. Must be one of: CachingOptimized, CachingDisabled, CachingOptimizedForUncompressedObjects, Elemental-MediaPackag, Amplify. (Default: CachingDisabled) | `string` | `"CachingDisabled"` | no |
| cloudfront\_cached\_methods | Whether CloudFront caches the response to requests using the specified HTTP methods. | `list(string)` | <pre>[ "*" ]</pre> | no |
| cloutfront\_http\_version | Maximum HTTP version to support on the distribution. Must be one of http1.1, http2, http2and3 and http3. Default: http2. | `string` | `"http2"` | no |
| cloutfront\_price\_class | Maximum HTTP version to support on the distribution. Allowed values are PriceClass\_All, PriceClass\_200, PriceClass\_100. Default: PriceClass\_All | `string` | `"PriceClass_All"` | no |
| cloutfront\_viewer\_protocol\_policy | Maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3. Default: redirect-to-https | `string` | `"redirect-to-https"` | no |
| common\_tags | Map of tags applied to all applicable resources. | `map(string)` | `{}` | no |
