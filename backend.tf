terraform {
  backend "s3" {
    bucket         = "dofs-terraform-state"
    key            = "dofs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
