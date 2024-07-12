# S3 bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

# S3 bucket object
resource "aws_s3_object" "upload_zip" {
  bucket = aws_s3_bucket.app_bucket.bucket
  key    = var.zip_file
  source = "../app.zip"
  server_side_encryption = "AES256"
}
