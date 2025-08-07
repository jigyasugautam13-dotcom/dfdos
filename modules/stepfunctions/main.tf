resource "aws_sfn_state_machine" "order_flow" {
  name     = "order_state_machine"
  role_arn = var.step_function_role_arn
  definition = jsonencode({
    StartAt = "ValidateOrder",
    States = {
      ValidateOrder = {
        Type     = "Task",
        Resource = var.validator_lambda_arn,
        Next     = "StoreOrder"
      },
      StoreOrder = {
        Type     = "Task",
        Resource = var.order_storage_lambda_arn,
        Next     = "SendToQueue"
      },
      SendToQueue = {
        Type = "Task",
        Resource = "arn:aws:states:::sqs:sendMessage",
        Parameters = {
          QueueUrl    = var.sqs_queue_url,
          MessageBody = { "order_id.$" = "$.order_id" }
        },
        End = true
      }
    }
  })
}
