variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
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
  description = "ARN of the IAM role for EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
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

variable "eks_nodegroup_role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
}
