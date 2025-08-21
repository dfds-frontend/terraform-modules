output "role_arn" {
  value = aws_iam_role.s3_role.arn
}

output "role_id" {
  value = aws_iam_role.s3_role.id
}
