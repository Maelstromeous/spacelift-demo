variable "bucket_name" {
  type = string
  description = "Bucket name to use on the account for the demo"
  default = "maelstrome-spacelift-demo"
}

variable "region" {
  type = string
  description = "Region to deploy the bucket to"
  default = "eu-west-2"
}

variable "source_directory" {
  description = "The directory to be zipped and uploaded to S3"
  type        = string
  default     = "../"  # The directory above the current directory
}

variable "tags" {
  type = map(string)
  description = "Tags to apply to the bucket"
  default = {
    Name = "maelstrome-spacelift-demo"
    Environment = "Development"
  }
}

variable "zip_file" {
    type = string
    description = "Path to the zip file to upload to the bucket"
    default = "app.zip"
}
