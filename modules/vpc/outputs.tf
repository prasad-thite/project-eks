output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.public_subnet[*].id  # Adjust this based on your actual setup
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_k8s_ids" {
  value = aws_subnet.private_subnet_k8s[*].id
}

output "private_subnet_db_ids" {
    value = aws_subnet.private_subnet_db[*].id
  }
output "nat_gateway_ids" {
  value = aws_nat_gateway.my_nat_gateway[*].id
}

output "lb_dns_name" {
  value = aws_lb.k8s_load_balancer.dns_name
}
