module "iam" {
  source = "./modules/iam"
}

module "lambdas" {
  source               = "./modules/lambdas"
  lambda_exec_role_arn = module.iam.lambda_exec_role_arn
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "dynamodb" {
  source                   = "./modules/dynamodb"
  orders_table_name        = "orders"
  failed_orders_table_name = "failed_orders"
}

module "sqs" {
  source           = "./modules/sqs"
  order_queue_name = "order_queue"
  dlq_name         = "order_dlq"
}

module "stepfunctions" {
  source                   = "./modules/stepfunctions"
  validator_lambda_arn     = module.lambdas.validator_arn
  order_storage_lambda_arn = module.lambdas.order_storage_arn
  sqs_queue_url            = module.sqs.order_queue_url
  step_function_role_arn   = module.iam.step_function_role_arn
}

module "monitoring" {
  source = "./modules/monitoring"
}
