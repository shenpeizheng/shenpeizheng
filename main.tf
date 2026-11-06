locals {
  lambda_function_name = "${var.resource_prefix}-landing-page"
  lambda_role_name     = "${var.resource_prefix}-lambda-role"
  lambda_log_group     = "/aws/lambda/${local.lambda_function_name}"

  common_tags = {
    Environment = "Sandbox"
    ManagedBy   = "Terraform"
    Project     = "Patrick AWS Sandbox"
  }
}

data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/landing-page.zip"
}
resource "aws_lambda_function_url" "landing_page" {
  function_name      = aws_lambda_function.landing_page.function_name
  authorization_type = "NONE"
}

resource "aws_iam_role" "lambda_execution" {
  name = local.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = local.lambda_log_group
  retention_in_days = 14
  tags              = local.common_tags
}

resource "aws_lambda_function" "landing_page" {
  function_name = local.lambda_function_name
  description   = "Independent sandbox landing page"
  role          = aws_iam_role.lambda_execution.arn

  runtime          = "python3.12"
  handler          = "index.handler"
  architectures    = ["x86_64"]
  filename         = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256

  memory_size = 128
  timeout     = 10
  publish     = false

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_cloudwatch_log_group.lambda
  ]
}

resource "aws_lambda_function_url" "landing_page" {
  function_name      = aws_lambda_function.landing_page.function_name
  authorization_type = var.enable_public_access ? "NONE" : "AWS_IAM"
}

# Public Function URLs require both permissions. These are created only
# when enable_public_access is explicitly set to true.
resource "aws_lambda_permission" "public_function_url" {
  count = var.enable_public_access ? 1 : 0

  statement_id           = "AllowPublicFunctionUrl"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.landing_page.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}

resource "aws_lambda_permission" "public_function_url_invoke" {
  count = var.enable_public_access ? 1 : 0

  statement_id            = "AllowPublicFunctionUrlInvoke"
  action                  = "lambda:InvokeFunction"
  function_name           = aws_lambda_function.landing_page.function_name
  principal               = "*"
  invoked_via_function_url = true

  depends_on = [aws_lambda_permission.public_function_url]
}
