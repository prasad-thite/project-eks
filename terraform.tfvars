#VPC
aws_region              = "us-east-2"
vpc_name                = "TF-VPC"
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidr      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_k8s_cidr = [ "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24" ]
private_subnet_db_cidr  = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
availability_zones      = ["us-east-2a", "us-east-2b"]

#IAM
eks_cluster_role_name   = "TF-cluster-role"
eks_cluster_role_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
cluster_policy_arn      = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# role_arn                =  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
eks_nodegroup_role_name = "TF-nodegroup-role"
node_group_policy_arn         = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
node_group_cni_policy_arn     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"


#EKS and Nodegroup
eks_cluster_name        = "TF-eks-cluster"
node_group_name         = "TF-node-group"
node_group_min_size     = 1
node_group_max_size     = 3
node_group_desired_size = 2
ec2_ssh_key             = "your-ssh-key-name"
instance_types          = ["t3.medium"]