moved {
  from = aws_vpc_security_group_egress_rule.tasks-dns-udp
  to   = aws_vpc_security_group_egress_rule.tasks_dns_udp
}

moved {
  from = aws_vpc_security_group_egress_rule.tasks-dns-tcp
  to   = aws_vpc_security_group_egress_rule.tasks_dns_tcp
}

moved {
  from = aws_vpc_security_group_egress_rule.tasks-s3
  to   = aws_vpc_security_group_egress_rule.tasks_s3
}
