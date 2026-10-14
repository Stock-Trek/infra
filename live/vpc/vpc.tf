resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags

  lifecycle {
    precondition {
      condition     = var.availability_zone_count <= length(data.aws_availability_zones.available.names)
      error_message = "availability_zone_count=${var.availability_zone_count} exceeds available AZs=${length(data.aws_availability_zones.available.names)} in ${data.aws_region.current.region}."
    }
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_subnet" "private" {
  count = var.availability_zone_count

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = var.tags
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr, 8, 128)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags                    = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  domain = "vpc"
  tags   = var.tags
}

resource "aws_nat_gateway" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public.id
  tags          = var.tags

  depends_on = [aws_internet_gateway.internet]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route" "private" {
  count = var.enable_nat_gateway ? 1 : 0

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[0].id
}

resource "aws_route_table_association" "private" {
  count = var.availability_zone_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
