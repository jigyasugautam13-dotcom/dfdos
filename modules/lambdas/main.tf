resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = var.lambda_exec_role_arn
  handler       = "main.handler"
  runtime       = "python3.12"

  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  environment {
    variables = var.environment_variables
  }

  depends_on = [aws_iam_role.lambda_exec_role]
}