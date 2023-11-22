# # resource "aws_iam_role" "eks_cluster_role" {
# #   name = var.eks_cluster_role_name

# #   assume_role_policy = jsonencode(
# #     {
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Effect": "Allow",
# #       "Principal": {
# #         "Service": "eks.amazonaws.com"
# #       },
# #       "Action": "sts:AssumeRole"
# #     }
# #   ]
# # }
# #   )
# # }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
#   policy_arn = var.cluster_policy_arn
#   role       = aws_iam_role.eks_cluster_role.name
#   depends_on = [ aws_iam_role.eks_cluster_role ]
# }

# # resource "aws_iam_role" "eks_nodegroup_role" {
# #   name = var.eks_nodegroup_role_name

# #   assume_role_policy = jsonencode({
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Effect": "Allow",
# #       "Principal": {
# #         "Service": "eks.amazonaws.com"
# #       },
# #       "Action": "sts:AssumeRole"
# #     }
# #   ]
# # })
# # }

# # Attach policies to the EKS Node Group role (adjust policies based on your needs)
# # resource "aws_iam_role_policy_attachment" "eks_node_group_attachment" {
# #   policy_arn = var.node_group_policy_arn
# #   role = aws_iam_role.eks_nodegroup_role.name
# #   depends_on = [ aws_iam_role.eks_nodegroup_role ]
# # }

# # resource "aws_iam_role_policy_attachment" "eks_node_group_cni_attachment" {
# #   policy_arn = var.node_group_cni_policy_arn
# #   role       = aws_iam_role.eks_nodegroup_role.name
# #   depends_on = [ aws_iam_role.eks_nodegroup_role ]
# # }
