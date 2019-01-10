output "sample_function_arn" {
  description = "Sample function ARN"
  value = "${aws_lambda_function.sample_function.arn}"
}