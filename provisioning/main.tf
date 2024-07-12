# Local file resource to create the zip file
resource "null_resource" "zip_files" {
  provisioner "local-exec" {
    command = "cd ${var.source_directory} && zip -r ${path.module}/${var.zip_file} src"
  }

  triggers = {
    always_run = timestamp()
  }
}

# S3 bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.app_bucket.id
  acl    = "private"
}

# S3 bucket object
resource "aws_s3_object" "upload_zip" {
  depends_on = [null_resource.zip_files]

  bucket = aws_s3_bucket.app_bucket.bucket
  key    = var.zip_file
  source = "${path.module}/${var.zip_file}"
  server_side_encryption = "AES256"
}
