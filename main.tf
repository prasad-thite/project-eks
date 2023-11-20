provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  }

module "eks" {
  source               = "./modules/eks"
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_role_arn = var.eks_cluster_role_arn
  private_subnet_id    = module.vpc.private_subnet_id
}

module "nodegroup" {
  source                  = "./modules/nodegroup"
  eks_cluster_name        = var.eks_cluster_name
  node_group_name         = var.node_group_name
  private_subnet_id       = module.vpc.private_subnet_id
  node_group_min_size     = var.node_group_min_size
  node_group_max_size     = var.node_group_max_size
  node_group_desired_size = var.node_group_desired_size
  node_role_arn = var.eks_nodegroup_role_name
  ec2_ssh_key             = var.ec2_ssh_key
}

module "iam" {
  source                   = "./modules/iam"
  eks_cluster_role_name = var.eks_cluster_role_name
  eks_nodegroup_role_name  = var.eks_nodegroup_role_name
}

# Add other configurations as needed
