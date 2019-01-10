terraform {
  required_version = ">= 0.8"
}

module "iam" {
  source = "../../global/iam"
  Environment = "${var.Environment}"
}

resource "aws_lambda_function" "sample_function" {
  function_name = "${var.Environment}_sample_function"
  filename         = "/home/ilan.rosenfeld/AI/terraform/tech-talk-terraform/modules/lambdas/sample_function_payload.jar"
  role             = "${module.iam.sample_role_arn}"
  handler          = "exports.test"
  runtime          = "java8"

  environment {
    variables = {
      region = "${var.aws_region}"
      environment = "${var.Environment}"
    }
  }
}

# Connecting above function with corresponding kinesis stream

resource "aws_lambda_event_source_mapping" "sample_source_mapping" {
  batch_size        = 20
  event_source_arn  = "${var.sample_stream_arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.sample_function.arn}"
  starting_position = "TRIM_HORIZON"
}