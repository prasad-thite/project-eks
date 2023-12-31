resource "aws_eks_cluster" "my_eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_role_arn
  version = "1.25"

  vpc_config {
    subnet_ids = var.private_subnet_k8s_ids
  }
}
