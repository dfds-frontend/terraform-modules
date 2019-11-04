output "aws_repo_arn" {
  value = "${aws_ecr_repository.repo.arn}"
}

output "aws_repository_url" {
  value = "${aws_ecr_repository.repo.repository_url}"
}

output "aws_repository_name" {
  value = "${aws_ecr_repository.repo.name}"
}
