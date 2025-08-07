
import boto3
import os
from datetime import datetime

ddb = boto3.resource("dynamodb")
table_name = os.environ["ORDERS_TABLE"]
table = ddb.Table(table_name)

def handler(event, context):
    item = {
        "order_id": event["order_id"],
        "item": event["item"],
        "status": "PENDING",
        "created_at": datetime.utcnow().isoformat()
    }
    table.put_item(Item=item)
    return event
