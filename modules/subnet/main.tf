# subnet/main.tf

resource "aws_subnet" "this" {
  for_each                          = var.subnet_config

  vpc_id                            = var.vpc_id
  cidr_block                        = each.value.cidr_block
  availability_zone                 = each.value.availability_zone
  assign_ipv6_address_on_creation   = var.enable_ipv6

  # Dynamically calculate the IPv6 CIDR block for each subnet
  ipv6_cidr_block   = var.enable_ipv6 ? cidrsubnet(var.vpc_ipv6_cidr_block, 8, index(keys(var.subnet_config), each.key)) : null

  tags = merge(
    var.common_tags,
    { Name = each.value.name }
  )
}
