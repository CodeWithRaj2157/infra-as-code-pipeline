terraform {
  backend "s3" {
    bucket         = "infra-as-code-pipeline-tfstate"
    key            = "terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
