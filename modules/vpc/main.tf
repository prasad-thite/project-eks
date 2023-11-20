resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_nat_gateway" "my_nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet.id
#   for_each = aws_subnet.private_subnet
#   allocation_id = aws_eip.nat_eip[each.key].id
#   subnet_id     = each.value.id

  depends_on = [aws_internet_gateway.my_igw]  # Make sure IGW is created before NAT Gateway
}

resource "aws_eip" "nat_eip" {
#   count = length(aws_subnet.private_subnet)
  depends_on = [ aws_internet_gateway.my_igw ]
#  vpc = true
}

resource "aws_security_group" "worker_sg" {
  vpc_id = aws_vpc.my_vpc.id
  # Define your security group rules for worker nodes here
}

resource "aws_lb" "my_lb" {
  name               = "MyLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.worker_sg.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  enable_deletion_protection = false
}
