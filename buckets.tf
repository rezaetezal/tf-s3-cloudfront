#####################################################################
# S3 Bucket and ACL
#####################################################################

resource "aws_s3_bucket" "s3hosting" {
  bucket = local.site_name
}

resource "aws_s3_bucket_acl" "s3hosting" {
  bucket = aws_s3_bucket.s3hosting.id
  acl    = "private"
}


#####################################################################
# Create and assign S3 bucket policy
#####################################################################

data "aws_iam_policy_document" "s3hosting" {
  statement {
    sid = "AllowCloudfrontDistributionReadOnlyAccess"
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.s3hosting.arn}/*",
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3hosting.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3hosting" {
  bucket = aws_s3_bucket.s3hosting.id
  policy = data.aws_iam_policy_document.s3hosting.json
}
