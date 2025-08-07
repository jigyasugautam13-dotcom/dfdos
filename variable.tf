variable "region" {
  default = "us-east-1"
}

variable "github_token" {
  type        = string
  description = "GitHub OAuth Token for CodePipeline"
}

variable "github_user" {
  type        = string
  description = "GitHub username"
}

variable "github_repo" {
  type        = string
  description = "GitHub repo name"
}

variable "lambda_s3_bucket" {
  description = "S3 bucket containing the zipped Lambda code"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key (path) to the Lambda zip file"
  type        = string
}