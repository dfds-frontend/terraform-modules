resource "aws_iam_role" "s3_role" {
  name                  = var.name
  force_detach_policies = var.force_detach_policies

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "s3permissions" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      "${var.bucket_arn}",
      "${var.bucket_arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.trusted_role_arn}"]
    }
  }
}

resource "aws_iam_role_policy" "s3_role_policy" {
  name   = "${var.name}-s3permissions"
  role   = aws_iam_role.s3_role.name
  policy = data.aws_iam_policy_document.s3permissions.json
}
