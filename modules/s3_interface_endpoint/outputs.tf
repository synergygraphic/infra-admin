# modules/s3_interface_endpoint/outputs.tf

output "s3_interface_endpoint_id" {
  description = "The ID of the S3 interface endpoint"
  value       = aws_vpc_endpoint.s3_interface.id
}
