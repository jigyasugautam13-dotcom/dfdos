
import boto3
import os
import json
import random

ddb = boto3.resource("dynamodb")
table_name = os.environ["ORDERS_TABLE"]
table = ddb.Table(table_name)

def handler(event, context):
    print("Processing SQS event:", event)
    for record in event["Records"]:
        order = json.loads(record["body"])
        success = random.random() < 0.7
        status = "FULFILLED" if success else "FAILED"

        table.update_item(
            Key={"order_id": order["order_id"]},
            UpdateExpression="SET #s = :val",
            ExpressionAttributeNames={"#s": "status"},
            ExpressionAttributeValues={":val": status}
        )
        print(f"Order {order['order_id']} {status}")
    return {"statusCode": 200}
