variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet for EKS worker nodes"
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

variable "node_role_arn" {
  description = "eks-nodegroup-role"
}
variable "ec2_ssh_key" {
  description = "Name of the SSH key pair for EC2 instances"
  type        = string
}
