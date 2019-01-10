output "sample_bucket_name" {
  value = "${module.s3.sample_bucket_name}"
}

output "sample_stream_arn" {
  value = "${module.streams.sample_stream_arn}"
}

output "sample_function_arn" {
  value = "${module.lambdas.sample_function_arn}"
}