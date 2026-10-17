resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.interface_endpoints)

  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.endpoints.id, aws_security_group.tasks.id]
  private_dns_enabled = true
  tags                = var.tags
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.private[*].id
  tags              = var.tags
}
