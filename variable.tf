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