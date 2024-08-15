resource "aws_iam_role" "eks_iam" {
  name = "eks-cluster-iamrole"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



resource "aws_eks_cluster" "notion_eks_task" {
  name     = "notion_eks_task1"
  role_arn = aws_iam_role.eks_iam.arn

  vpc_config {
    subnet_ids = values(aws_subnet.private_subnet)[*].id
  }

  depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]
}
