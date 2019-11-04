resource "aws_ecr_repository_policy" "policy" {
  repository = "${var.aws_ecr_repository_name}"

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:ListImages"
            ]
        }
    ]
}
EOF
}

                # "ecr:GetDownloadUrlForLayer",
                # "ecr:BatchGetImage",
                # # "ecr:BatchCheckLayerAvailability",
                # # "ecr:PutImage",
                # # "ecr:InitiateLayerUpload",
                # # "ecr:UploadLayerPart",
                # # "ecr:CompleteLayerUpload",
                # # "ecr:DescribeRepositories",
                # # "ecr:GetRepositoryPolicy",
                # "ecr:ListImages",
                # # "ecr:DeleteRepository",
                # # "ecr:BatchDeleteImage",
                # # "ecr:SetRepositoryPolicy",
                # # "ecr:DeleteRepositoryPolicy"