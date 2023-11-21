resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
        }
    }

resource "aws_subnet" "public_subnet" {
    count                   = length(var.public_subnet_cidr)  # Set count to the number of AZs you want to cover
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.public_subnet_cidr[count.index]  # Adjust the CIDR block accordingly
    map_public_ip_on_launch = true
    availability_zone       = element(var.availability_zones, count.index)
    tags = {
        Name = "public-subnet-${count.index + 1}"
        }
    }

resource "aws_subnet" "private_subnet_k8s" {
    count = length(var.private_subnet_k8s_cidr)
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_k8s_cidr[count.index]
    map_public_ip_on_launch = false
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name    = "private-subnet-k8s-${count.index + 1}"
         }
    }

resource "aws_subnet" "private_subnet_db" {
  count                   = length(var.private_subnet_db_cidr)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_db_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone       = element(var.availability_zones, count.index)

  tags = {
    Name = "private-subnet-db-${count.index + 1}"
  }
}
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my-igw"
    }
}

resource "aws_nat_gateway" "my_nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = element(aws_subnet.public_subnet[*].id, 0)
    # Make sure IGW is created before NAT Gateway
    depends_on = [aws_internet_gateway.my_igw] 
    tags = {
      Name = "my-nat-gateway"
    }
  }

resource "aws_eip" "nat_eip" {
    # Make sure IGW is created before NAT Gateway
    depends_on = [ aws_internet_gateway.my_igw ]
    }

resource "aws_security_group" "worker_sg" {
    vpc_id = aws_vpc.my_vpc.id
  # Define your security group rules for worker nodes here
    }
# Public Subnet Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


# Private Subnet Route Table for K8s worker nodes
resource "aws_route_table" "private_route_table_k8s" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }

  tags = {
    Name = "private-route-table-k8s"
  }
}

resource "aws_lb" "k8s_load_balancer" {
  name               = "k8s-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.k8s_lb_sg.id]
  subnets            = aws_subnet.private_subnet_k8s[*].id
}

# Create a security group for the K8s load balancer
resource "aws_security_group" "k8s_lb_sg" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private Subnet Route Table for Database
resource "aws_route_table" "private_route_table_db" {
  vpc_id = aws_vpc.my_vpc.id

  # You might want to define different routes for your database subnet, e.g., connecting to a VPN, Direct Connect, or another private network.
  # Example:
  # route {
  #   cidr_block = "10.0.9.0/24"  # Assuming another private network CIDR
  #   gateway_id = "some_gateway_id"
  # }

  tags = {
    Name = "private-route-table-db"
  }
}

# Associate subnets with their respective route tables
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_k8s_association" {
  count          = length(aws_subnet.private_subnet_k8s[*].id)
  subnet_id      = aws_subnet.private_subnet_k8s[count.index].id
  route_table_id = aws_route_table.private_route_table_k8s.id
}

resource "aws_route_table_association" "private_subnet_db_association" {
  count          = length(aws_subnet.private_subnet_db[*].id)
  subnet_id      = aws_subnet.private_subnet_db[count.index].id
  route_table_id = aws_route_table.private_route_table_db.id
}