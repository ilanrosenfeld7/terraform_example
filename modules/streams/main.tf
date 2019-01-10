terraform {
  required_version = ">= 0.8"
}

resource "aws_kinesis_stream" "sample_stream" {
  name             = "${var.Environment}_sample_stream"
  shard_count      = "${var.shard_count}"
  retention_period = "${var.retention_period}"

  shard_level_metrics = [
    "IteratorAgeMilliseconds",
    "IncomingBytes",
    "OutgoingBytes",
  ]

  encryption_type = "${var.encryption_type}"

  tags {
    Environment = "${var.Environment}"
  }
}