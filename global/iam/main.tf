terraform {
  required_version = ">= 0.8"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "sample_role" {
  name = "${var.Environment}_sample_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "sample_role_policy" {
  name = "${var.Environment}_sample_role_policy"
  role = "${aws_iam_role.sample_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:*",
        "kinesis:*",
        "s3:*",
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
