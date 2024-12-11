# modules/s3_interface_endpoint/main.tf

resource "aws_vpc_endpoint" "s3_interface" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [var.security_group_id]
  private_dns_enabled = true

  tags = merge(
    var.common_tags,
    { Name = var.endpoint_name }
  )
  
}

