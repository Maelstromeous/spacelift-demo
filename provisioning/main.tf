# Local file resource to create the zip file
resource "null_resource" "zip_files" {
  provisioner "local-exec" {
    command = "zip -r ${var.zip_file} ${var.source_directory}*"
  }

  triggers = {
    files_hash = md5(join(",", data.external.list_files.result["files"]))
  }
}

# S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  region = var.region
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

# S3 bucket object
resource "aws_s3_object" "upload_zip" {
  depends_on = [null_resource.zip_files]

  bucket = aws_s3_bucket.bucket
  key    = var.zip_file
  source = "${path.module}/${var.zip_file}"
  server_side_encryption = "AES256"
}
