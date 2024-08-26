/*
All the Configuration for all ECR repos for Lambda functions
*/

resource "aws_kms_key" "ecr_kms" {
  enable_key_rotation = true
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = "tf-aws-jchung-lambda-function-chrome-ecr-repo"
  force_delete         = true
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr_kms.key_id
  }
}
