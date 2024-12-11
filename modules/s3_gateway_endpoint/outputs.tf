output "s3_gateway_endpoint_id" {
  description = "The ID of the S3 Gateway Endpoint"
  value       = aws_vpc_endpoint.s3_gateway.id
}

output "s3_gateway_endpoint_arn" {
  description = "The ARN of the S3 Gateway Endpoint"
  value       = aws_vpc_endpoint.s3_gateway.arn
}
