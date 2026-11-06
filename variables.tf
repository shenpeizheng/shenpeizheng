variable "aws_account_id" {
  description = "AWS account ID this sandbox is allowed to deploy into."
  type        = string
  default     = "164113803211"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "aws_account_id must be a 12-digit AWS account ID."
  }
}

variable "aws_region" {
  description = "AWS region for the sandbox resources."
  type        = string
  default     = "ap-southeast-2"
}

variable "resource_prefix" {
  description = "Prefix used to keep sandbox resource names separate."
  type        = string
  default     = "patrick-sandbox"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.resource_prefix))
    error_message = "resource_prefix may contain lowercase letters, numbers, and hyphens only."
  }
}

variable "enable_public_access" {
  description = "Set true only if the landing page should be publicly accessible without AWS authentication."
  type        = bool
  default     = true
}
