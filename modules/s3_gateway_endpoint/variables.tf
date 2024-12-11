# modules/s3_gateway_endpoint/variables.tf

variable "vpc_id" {
  description = "VPC ID to create the S3 Gateway Endpoint in"
  type        = string
}

variable "region" {
  description = "Region for the S3 Gateway Endpoint"
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for the S3 Gateway endpoint"
  type        = list(string)
}

variable "endpoint_name" {
  description = "Name tag for the S3 Gateway endpoint"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}
