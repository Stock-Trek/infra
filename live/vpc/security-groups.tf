resource "aws_security_group" "tasks" {
  name        = "${var.name}-tasks"
  description = "Build agent task network access"
  vpc_id      = aws_vpc.vpc.id

  tags = var.tags
}

resource "aws_security_group" "endpoints" {
  name        = "${var.name}-endpoints"
  description = "Build agent VPC endpoint network access"
  vpc_id      = aws_vpc.vpc.id

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "endpoints" {
  security_group_id            = aws_security_group.endpoints.id
  description                  = "HTTPS from build agent tasks"
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.tasks.id
}

resource "aws_vpc_security_group_egress_rule" "endpoints" {
  security_group_id = aws_security_group.endpoints.id
  description       = "HTTPS to AWS services"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "tasks" {
  security_group_id            = aws_security_group.tasks.id
  description                  = "HTTPS to VPC endpoints"
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.endpoints.id
}

resource "aws_vpc_security_group_egress_rule" "tasks_internet" {
  security_group_id = aws_security_group.tasks.id
  description       = "Outbound internet access via NAT gateway"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "tasks_dns_udp" {
  security_group_id = aws_security_group.tasks.id
  description       = "DNS to VPC resolver"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
  cidr_ipv4         = "${cidrhost(var.cidr, 2)}/32"
}

resource "aws_vpc_security_group_egress_rule" "tasks_dns_tcp" {
  security_group_id = aws_security_group.tasks.id
  description       = "DNS to VPC resolver"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "tcp"
  cidr_ipv4         = "${cidrhost(var.cidr, 2)}/32"
}

resource "aws_vpc_security_group_egress_rule" "tasks_s3" {
  security_group_id = aws_security_group.tasks.id
  description       = "HTTPS to S3 gateway endpoint"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  prefix_list_id    = aws_vpc_endpoint.s3.prefix_list_id
}
