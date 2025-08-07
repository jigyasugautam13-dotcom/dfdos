resource "aws_sqs_queue" "order_dlq" {
  name = var.dlq_name
}

resource "aws_sqs_queue" "order_queue" {
  name = var.order_queue_name
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_dlq.arn,
    maxReceiveCount     = 3
  })
}

output "order_queue_url" {
  value = aws_sqs_queue.order_queue.id
}