def handler(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/html"
        },
        "body": "<h1>Thinktank Landing Page</h1>"
    }
