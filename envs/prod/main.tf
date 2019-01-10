terraform {
  required_version = ">= 0.8"
}

locals {
  Environment = "prod"
  aws_region ="us-east-1"
}

provider "aws" {
  region = "${local.aws_region}"
}

module "s3" {
  source = "../../modules/s3"

  Environment = "${local.Environment}"
}

module "streams" {
  source = "../../modules/streams"

  shard_count         = 5
  retention_period    = 48
    
  Environment = "${local.Environment}"
}

module "lambdas" {
  source = "../../modules/lambdas"

  Environment = "${local.Environment}"
  aws_region = "${local.aws_region}"
  sample_stream_arn = "${module.streams.sample_stream_arn}" 
}