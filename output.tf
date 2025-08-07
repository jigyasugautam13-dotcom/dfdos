output "api_url" {
  value = module.api_gateway.invoke_url
}

output "lambda_exec_role_arn" {
  value = module.iam.lambda_exec_role_arn
}

output "step_function_role_arn" {
  value = module.iam.step_function_role_arn
}

output "order_queue_url" {
  value = module.sqs.order_queue_url
}

output "validator_lambda_arn" {
  value = module.lambdas.validator_arn
}

output "order_storage_lambda_arn" {
  value = module.lambdas.order_storage_arn
}
