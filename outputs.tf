output "lambda_function_name" {
  description = "Name of the sandbox Lambda function."
  value       = aws_lambda_function.landing_page.function_name
}

output "lambda_function_arn" {
  description = "ARN of the sandbox Lambda function."
  value       = aws_lambda_function.landing_page.arn
}

output "lambda_function_url" {
  description = "Function URL. With the default AWS_IAM setting, requests must be signed."
  value       = aws_lambda_function_url.landing_page.function_url
}

output "public_access_enabled" {
  description = "Whether unauthenticated public access has been enabled."
  value       = var.enable_public_access
}
