resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name

  tags = {
    Owner      = var.owner
    CostCenter = 1234
  }

}

resource "aws_s3_bucket_versioning" "demo_bucket_versioning" {
  bucket = aws_s3_bucket.demo_bucket.id
  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_website_configuration" "demo_bucket_website_config" {
  bucket = aws_s3_bucket.demo_bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "demo_bucket_public_access_block" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "demo_bucket_policy" {
  depends_on = [aws_s3_bucket_public_access_block.demo_bucket_public_access_block]
  bucket     = aws_s3_bucket.demo_bucket.id
  policy     = <<EOF
  {
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Principal" : "*",
            "Action" : "s3:GetObject",
            "Effect" : "Allow",
            "Resource" : "${aws_s3_bucket.demo_bucket.arn}/*"
        }
    ]
}
EOF
}
