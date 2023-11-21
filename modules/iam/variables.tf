variable "eks_cluster_role_name" {
  description = "Name of the IAM role for the EKS cluster"
  type        = string
}

variable "cluster_policy_arn" {
  type        = string
  description = "Policy ARN to attach to the EKS Cluster IAM role"
}

variable "eks_nodegroup_role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
}

variable "node_group_policy_arn" {
  type        = string
  description = "Policy ARN to attach to the EKS Node Group IAM role"
}

variable "node_group_cni_policy_arn" {
  type        = string
  description = "Policy ARN to attach to the EKS Node Group IAM role for CNI"
}