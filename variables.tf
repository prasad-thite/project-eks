variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_role_name" {
    description = "Name of the IAM role for EKS Cluster"
    type        = string
}

variable "eks_cluster_role_arn" {
  type = string
  description = "Cluster Role arn"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "eks_nodegroup_role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
}

variable "eks_nodegroup_role_arn" {
  description = "nodegroup role arn"
  type = string
}

# variable "cluster_policy_arn" {
#   type = string
#   description = "Cluster policy arn"  
# }

# variable "node_group_policy_arn" {
#   type = string
#   description = "Nodegroup policy arn"
# }

# variable "node_group_cni_policy_arn" {
#   type = string
#   description = "Nodegroup CNI policy arn"
# }
variable "vpc_name" {
    type = string
    description = "Name tag for the VPC"
  
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = list(string)
}

variable "private_subnet_k8s_cidr" {
    type = list(string)
    description = "CIDR block for the private subnet k8s"
  
}

# variable "private_subnet_k8s_ids" {
#     type = list(string)
#     description = "Private subnet k8s id"
# }

variable "private_subnet_db_cidr" {
  description = "CIDR block for the private subnet db"
  type        = list(string)
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for subnets"
}

variable "instance_types" {
  type = list(string)
  description = "Instance type fot Nodegroup"
  
}
variable "node_group_min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
}

variable "node_group_desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
}

variable "ec2_ssh_key" {
  description = "Name of the SSH key pair for EC2 instances"
  type        = string
}

