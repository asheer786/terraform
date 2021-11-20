provider "aws" {
access_key = "AKIAYKAEDH6NXKPSTIPI"
secret_key = "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"
region = "us-east-2"
}
resource "aws_s3_bucket" "bucket1" {
  bucket = "siri-s3-bucket"
  acl    = "private"

  tags = {
    Name        = "siri-bucket"
    Environment = "Dev"
  }
}