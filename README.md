# Patrick AWS Sandbox — Lambda landing page

This Terraform project creates a separate Lambda landing page in the configured AWS account and region. It does not import, modify, or manage the existing `thinktank-landing-page` function.

## Resources created

- A dedicated Lambda execution IAM role
- The AWS-managed `AWSLambdaBasicExecutionRole` policy attachment
- A CloudWatch log group with 14-day retention
- A new Python 3.12 Lambda function
- A new Lambda Function URL

Resource names use the `patrick-sandbox` prefix by default.

## Security default

`enable_public_access` defaults to `false`. The Function URL therefore uses `AWS_IAM` authentication and anonymous browser access will not work by default.

Only set `enable_public_access = true` if you deliberately want anyone on the internet to invoke this landing page. That setting changes the Function URL to `NONE` authentication and adds public invoke permissions.

## Before running

1. Confirm that you are authorised to create resources in the target AWS account.
2. Configure the HCP Terraform workspace with AWS credentials or an approved AWS dynamic credentials/OIDC connection.
3. Set the workspace Terraform variables:
   - `aws_account_id` — target 12-digit account ID
   - `aws_region` — defaults to `ap-southeast-2`
   - `resource_prefix` — defaults to `patrick-sandbox`
   - `enable_public_access` — defaults to `false`
4. Connect the workspace to this Git repository and set its working directory to the repository root.

The AWS provider includes `allowed_account_ids` as a safety check. Terraform will stop if the credentials point to a different account than `aws_account_id`.

## Plan and apply

Run a Terraform plan first. Review the plan and verify that it only proposes creating the sandbox resources with the `patrick-sandbox` prefix. Do not apply if it proposes changing or destroying any existing vendor-managed resources.

After reviewing and approving the plan, apply it.

## Important notes

- The Lambda source is `lambda/index.py`.
- The archive provider packages that file during the Terraform run.
- The generated `landing-page.zip` is a build artifact and is excluded from Git.
- This is a minimal landing-page example, not a full copy of the vendor environment.
- AWS charges may apply. Check the account's budgets and service quotas before deployment.
