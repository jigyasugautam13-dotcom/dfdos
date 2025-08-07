resource "aws_lambda_function" "api_handler" {
  function_name = "api_handler"
  filename      = "lambdas/api_handler/main.zip"
  handler       = "main.handler"
  runtime       = "python3.11"
  role          = var.lambda_exec_role_arn
}

resource "aws_lambda_function" "validator" {
  function_name = "validator"
  filename      = "lambdas/validator/main.zip"
  handler       = "main.handler"
  runtime       = "python3.11"
  role          = var.lambda_exec_role_arn
}

resource "aws_lambda_function" "order_storage" {
  function_name = "order_storage"
  filename      = "lambdas/order_storage/main.zip"
  handler       = "main.handler"
  runtime       = "python3.11"
  role          = var.lambda_exec_role_arn
}

resource "aws_lambda_function" "fulfill_order" {
  function_name = "fulfill_order"
  filename      = "lambdas/fulfill_order/main.zip"
  handler       = "main.handler"
  runtime       = "python3.11"
  role          = var.lambda_exec_role_arn
}

output "validator_arn" {
  value = aws_lambda_function.validator.arn
}

output "order_storage_arn" {
  value = aws_lambda_function.order_storage.arn
}