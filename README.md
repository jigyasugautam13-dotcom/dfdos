📌 Prerequisites

AWS account with admin access

Terraform v1.5+

S3 bucket for Lambda ZIP uploads

AWS CLI configured with credentials

Git installed and configured

⚙️ Setup Instructions

Upload ZIPs to S3

aws s3 cp ./lambdas/api_handler.zip s3://your-lambda-code-bucket/lambdas/api_handler.zip
aws s3 cp ./lambdas/validator.zip s3://your-lambda-code-bucket/lambdas/validator.zip
aws s3 cp ./lambdas/order_storage.zip s3://your-lambda-code-bucket/lambdas/order_storage.zip
aws s3 cp ./lambdas/fulfill_order.zip s3://your-lambda-code-bucket/lambdas/fulfill_order.zip

Deploy Infrastructure

terraform init
terraform apply -auto-approve

✅ Testing Guide

✅ Success Scenario

API Gateway triggers Lambda → Order validated

Valid orders stored in DynamoDB

Fulfillment Lambda consumes SQS message

Status updated to FULFILLED

❌ Failure + DLQ Scenario

Validator Lambda raises exception → Step Function fails

Failed input routed to failed_orders DynamoDB table

SQS processing fails randomly (30%) → Message sent to DLQ

You can view DLQ messages in SQS console and failed records in DynamoDB.

🔁 CI/CD Pipeline Overview (Optional)

AWS CodePipeline to run terraform plan + terraform apply

Source: GitHub push to main

Build: CodeBuild executes Terraform commands

Artifacts: Terraform state stored in S3 backend

🛠️ Troubleshooting

Lambda fails to invoke: Check IAM role permissions for lambda.amazonaws.com

Step Function error: Check Catch blocks or input formats

SQS not triggering Lambda: Ensure event source mapping is active

DLQ filling up: Indicates retry failures; investigate and fix root cause
