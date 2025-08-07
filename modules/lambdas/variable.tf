variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_exec_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "lambda_s3_bucket" {
  description = "S3 bucket containing the zipped Lambda code"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key (path) to the Lambda zip file"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables to pass to the Lambda"
  type        = map(string)
  default     = {}
}
