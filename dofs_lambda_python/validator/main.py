
def handler(event, context):
    print("Validating order:", event)
    if not event.get("order_id") or not event.get("item"):
        raise Exception("Invalid order: missing order_id or item")
    return event
