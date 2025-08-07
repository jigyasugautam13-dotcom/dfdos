
# 📝 DOFS Terraform Project – Final Documentation

---

## ✅ README CONTENT

### 📌 Prerequisites
- AWS account with administrative privileges
- Terraform v1.5 or newer
- S3 bucket for Lambda ZIP uploads
- AWS CLI configured (`aws configure`)
- Git installed and SSH keys added (if using GitHub)
- ZIP files of Lambda code already uploaded to S3

---

### ⚙️ Setup Instructions

#### 1. **Upload Lambda ZIPs to S3**
```bash
aws s3 cp ./lambdas/api_handler.zip s3://your-lambda-code-bucket/lambdas/api_handler.zip
aws s3 cp ./lambdas/validator.zip s3://your-lambda-code-bucket/lambdas/validator.zip
aws s3 cp ./lambdas/order_storage.zip s3://your-lambda-code-bucket/lambdas/order_storage.zip
aws s3 cp ./lambdas/fulfill_order.zip s3://your-lambda-code-bucket/lambdas/fulfill_order.zip
```

#### 2. **Deploy Infrastructure**
```bash
terraform init
terraform apply -auto-approve
```

---

### 🧪 Testing Guide

#### ✅ Success Scenario
- API Gateway receives a `POST /order`
- Triggers Lambda (API Handler) → Step Function
- Validator Lambda validates order
- Order is saved in DynamoDB
- Pushed to SQS
- Fulfillment Lambda processes it and updates status to `FULFILLED`

#### ❌ Failure + DLQ Scenario
- Validation fails → Step Function captures error → writes to `failed_orders` table
- Fulfillment Lambda randomly fails with 30% probability
- After max retries, message goes to SQS DLQ
- DLQ message is captured in `failed_orders` DynamoDB table

---

### 🔁 CI/CD System Overview (Terraform + CodePipeline)

- **Source Stage**: GitHub repository push to `main` branch
- **Build Stage**: AWS CodeBuild runs `terraform plan` and `terraform apply`
- **Approval Stage** (optional): Manual approval before apply
- **State Management**: Terraform remote backend via S3 bucket

> Note: You may skip GitHub setup if deploying manually or using S3 for Lambda code.

---

### 🛠️ Troubleshooting Tips

| Issue | Resolution |
|------|------------|
| Lambda fails to invoke | Check IAM role permissions (`lambda.amazonaws.com`) |
| Step Function fails | Inspect execution logs, validate input schema |
| SQS not triggering Lambda | Check event source mapping and permissions |
| DLQ messages increasing | Likely due to code logic errors or timeouts in fulfillment Lambda |

---

### 📷 AWS Console Screenshot Checklist
You can take AWS Console screenshots from:
- [x] Lambda Console (4 functions)
- [x] API Gateway Console (POST /order)
- [x] Step Functions → Execution Graph
- [x] SQS Queues (main + DLQ)
- [x] DynamoDB Tables (orders, failed_orders)
- [x] IAM Role for Lambda
- [x] CodePipeline if implemented

> ✅ **Sample Screenshot**: Refer to screenshot section in submission

---

### 🗺️ Architecture Diagram

```
         +--------------+
         | API Gateway  |
         +------+-------+
                |
                v
         +------+-------+
         | Lambda: API  |
         +------+-------+
                |
                v
        +-------+--------+
        | Step Function  |
        +--+----------+--+
           |          |
           v          v
+----------------+  +--------------------+
| Validator      |  | Order Storage      |
| Lambda         |  | Lambda (DynamoDB)  |
+----------------+  +--------+-----------+
                             |
                             v
                         +---+---+
                         |  SQS  |
                         +---+---+
                             |
                             v
                  +-------------------+
                  | Fulfillment Lambda|
                  +-------------------+
                             |
                             v
                   +------------------+
                   | DynamoDB Update  |
                   +------------------+
                             |
                         (if fails)
                             v
                       +----------+
                       | DLQ +    |
                       | failed_  |
                       | orders   |
                       +----------+
```

---

### 📤 Submission Instructions

- 🧪 Make sure `terraform apply` works from scratch and creates the full infrastructure.
- 💾 Include `terraform.auto.tfvars` (example provided) and `lambda/` ZIPs if needed.


