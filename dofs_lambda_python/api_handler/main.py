
def handler(event, context):
    import json
    order = json.loads(event["body"])
    print("Received order:", order)
    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Order received", "order": order})
    }
