variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role for EKS cluster"
  type        = string
}

variable "private_subnet_k8s_ids" {
  description = "ID of the private subnet for EKS worker nodes"
  type        = list(string)
}
