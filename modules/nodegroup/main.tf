resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.node_group_name
  node_role_arn = var.node_role_arn 
  subnet_ids = var.private_subnet_k8s_ids
  scaling_config {
    min_size = var.node_group_min_size
    max_size = var.node_group_max_size
    desired_size = var.node_group_desired_size
  }
#   remote_access {
#     ec2_ssh_key = var.ec2_ssh_key
#   }
}