provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  subnet_id = module.vpc.public_subnet_id
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_k8s_cidr = var.private_subnet_k8s_cidr
  private_subnet_db_cidr = var.private_subnet_db_cidr
  availability_zones    = var.availability_zones
  }

module "eks" {
  source               = "./modules/eks"
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_role_arn = var.eks_cluster_role_arn
  private_subnet_k8s_ids = module.vpc.private_subnet_k8s_ids
}

module "nodegroup" {
  source                  = "./modules/nodegroup"
  depends_on = [ module.eks.my_eks_cluster ]
  eks_cluster_name        = var.eks_cluster_name
  node_group_name         = var.node_group_name
  instance_types          = var.instance_types
  private_subnet_k8s_ids  = module.vpc.private_subnet_k8s_ids
  node_group_min_size     = var.node_group_min_size
  node_group_max_size     = var.node_group_max_size
  node_group_desired_size = var.node_group_desired_size
  # node_role_arn           = var.eks_nodegroup_role_name
  ec2_ssh_key             = var.ec2_ssh_key
}

# module "iam" {
#   source                   = "./modules/iam"
#   eks_cluster_role_name    = var.eks_cluster_role_name
#   cluster_policy_arn       = var.cluster_policy_arn
#   eks_nodegroup_role_name  = var.eks_nodegroup_role_name
#   node_group_policy_arn    = var.node_group_policy_arn
#   node_group_cni_policy_arn     = var.node_group_cni_policy_arn
# }

