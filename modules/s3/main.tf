terraform {
  required_version = ">= 0.8"
}

resource "aws_s3_bucket" "sample_bucket" {
  bucket = "${var.Environment}-sample-bucket"
  acl    = "private"

  tags {
    Name        = "${var.Environment} Sample bucket"
    Environment = "${var.Environment}"
  }
}