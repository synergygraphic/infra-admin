# modules/route_table/main.tf

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    { Name = var.route_table_name }
  )
}

resource "aws_route_table_association" "this" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.this.id
}

# Load routes dynamically from the JSON file
data "local_file" "route_config" {
  filename = var.route_config_file
}

locals {
  # Decode JSON or default to an empty map if content is empty or invalid
  route_entries = try(jsondecode(data.local_file.route_config.content), {})
}

# Create routes based on JSON file content
resource "aws_route" "routes" {
  for_each       = local.route_entries
  route_table_id = aws_route_table.this.id
  
  destination_cidr_block = each.value.destination_cidr_block
  gateway_id            = lookup(each.value, "gateway_id", null)
  nat_gateway_id        = lookup(each.value, "nat_gateway_id", null)
  transit_gateway_id    = lookup(each.value, "transit_gateway_id", null)
}