variable "shard_count" {
  description = "Shard count for kinesis streams. Maximum 500"
  default = 20
}

variable "retention_period" {
  description = "Retention period for the kinesis stream. Minimum 24, Maximum 168"
  default = 24
}
variable "encryption_type" {
  description = "Encryption type for the stream. Acceptable values are NONE or KMS"
  default = "NONE"
}

variable "Environment" {
  description = "Environment to which the resource is pushed into"
}