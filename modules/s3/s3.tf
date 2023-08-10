resource "aws_s3_bucket" "this" {
    count = var.create_bucket ? 1 : 0

    bucket = var.bucket_name
    force_destroy = var.force_destroy
    
    tags = var.required_tags
  
}


resource "aws_s3_bucket_logging" "this" {
  count = var.create_bucket && length(keys(var.logging)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  target_bucket = var.logging["target_bucket"]
  target_prefix = try(var.logging["target_prefix"], null)
}

resource "aws_s3_bucket_acl" "this" {
  count = var.create_bucket && var.acl !="null"  ? 1:0
  depends_on = [ aws_s3_bucket_public_access_block.this ]
  bucket = aws_s3_bucket.this[0].id
  acl = var.acl 
  
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_bucket  ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "this" {
  count = var.create_bucket && var.attach_policy ? 1 : 0
  depends_on = [ aws_s3_bucket_public_access_block.this ]
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.static_website_policy[0].json
}

data "aws_iam_policy_document" "static_website_policy" {
  count = var.create_bucket && var.attach_policy ? 1 : 0
  statement {
    principals {
      type        = "AWS"
      identifiers = ["304051859177"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.this[0].arn,
      "${aws_s3_bucket.this[0].arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = var.create_bucket && length(keys(var.website)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  dynamic "index_document" {
    for_each = try ([var.website["index_document"]], [])
    content {
      suffix = index_document.value
    }
    
  }
  dynamic "error_document" {
    for_each = try([ var.website["error_document"]], [])

    content {
      key = error_document.value
    }
    
  }

  dynamic "routing_rule" {
    for_each = try([var.website["routing_rule"]], [])

    content {
      dynamic "condition" {
        for_each = try([routing_rule.value.condition], [])

        content {
          key_prefix_equals = try (routing_rule.value.condition["key_prefix_equals"], null)
          http_error_code_returned_equals = try(routing_rule.value.condition["http_error_code_returned_equals"], null)
        }
      }
      redirect {
        host_name = try (routing_rule.value.redirect["host_name"], null)
        http_redirect_code = try (routing_rule.value.redirect["http_redirect_code"], null)
        protocol = try (routing_rule.value.redirect["protocol"], "")
        replace_key_prefix_with = try (routing_rule.value.redirect["replace_key_prefix_with"], null)
        replace_key_with = try (routing_rule.value.redirect["replace_key_with"], null)
      }
    }      
  }

  dynamic "redirect_all_requests_to" {
    for_each = try([var.website["redirect_all_requests_to"]], [])
    content {
      host_name = redirect_all_requests_to.value.host_name 
      protocol = try(redirect_all_requests_to.value.protocol, null)
    }
  }

}