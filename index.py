def handler(event, context):
    html = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Patrick Sandbox Landing Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f6f9;
                text-align: center;
                padding: 80px 20px;
            }
            .container {
                background: white;
                padding: 40px;
                border-radius: 12px;
                max-width: 650px;
                margin: auto;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            h1 { color: #17365D; }
            p { color: #555; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to Patrick's AWS Sandbox</h1>
            <p>Your independent AWS Lambda landing page is running successfully.</p>
            <p>Environment: Sandbox</p>
        </div>
    </body>
    </html>
    """

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/html; charset=utf-8"
        },
        "body": html
    }
