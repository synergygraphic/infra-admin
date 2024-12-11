# modules/vpc/main.tf

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.vpc_ipv6_cidr_block == null ? true : false

  tags = merge(
    var.common_tags,
    { Name = var.vpc_name }
  )
}

resource "aws_vpc_ipv6_cidr_block_association" "ipv6" {
  count           = var.vpc_ipv6_cidr_block != null ? 1 : 0
  vpc_id          = aws_vpc.this.id
  ipv6_cidr_block = var.vpc_ipv6_cidr_block
}

# Tag the default route table associated with this VPC
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-default_rt-02" }  # Distinct name for route table
  )
}

# Tag the default Network ACL associated with this VPC
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  # Ingress: Allow all traffic
  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "-1"   # -1 means all protocols
    from_port  = 0
    to_port    = 0
  }

  # Egress: Allow all traffic
  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-default_nacl-02" }  # Distinct name for network ACL
  )
}



# Tag the default Security Group associated with this VPC
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-default_sg-02" }  # Distinct name for security group
  )
}

# END OF MODULE/VPC/main.tf
