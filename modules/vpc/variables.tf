variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
#   default     = "10.0.0.0/16"
}

variable "subnet_id" {
    type = list(string)
    description = "Subnet id for NAT gateway"
  
}

variable "vpc_name" {
    type = string
    description = "Name tag for the VPC"
}

variable "public_subnet_cidr" {
  type    = list(string)
#   default     = "10.0.1.0/24"
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnet_k8s_cidr" {
  description = "CIDR block for the private subnet k8s"
  type        = list(string)
#   default     = "10.0.2.0/24"
}

variable "private_subnet_db_cidr" {
    type = list(string)
    description = "CIDR blocks for private subnets database"
}

variable "availability_zones" {
    type = list(string)
    description = "List of availability zones for subnets"
  
}