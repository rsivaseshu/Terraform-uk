output "bucket_name" {
  value = aws_s3_bucket.demo_bucket.id
}

output "bucketwebsite_url" {
  value = aws_s3_bucket_website_configuration.demo_bucket_website_config.website_endpoint
}