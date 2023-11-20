output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.my_nat_gateway[*].id
}

output "lb_dns_name" {
  value = aws_lb.my_lb.dns_name
}
