terraform {
  required_version = "~> 0.12.2"
}


resource "aws_ecr_repository" "repo" {
  name                 = "${var.repo_name}"
  image_tag_mutability = "${var.is_tags_mutable ? "MUTABLE" : "IMMUTABLE"}" #"MUTABLE"

  image_scanning_configuration {
    scan_on_push = "${var.scan_on_push}" # true
  }

  tags = "${var.tags}"
}
