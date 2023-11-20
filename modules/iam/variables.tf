variable "eks_cluster_role_name" {
  description = "Name of the IAM role for the EKS cluster"
  type        = string
}

variable "eks_nodegroup_role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
}
