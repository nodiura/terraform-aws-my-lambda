
# AWS Provider
provider "aws" {
  region = var.aws_region
}

# Local variables to handle archive and package configurations
locals {
  archive_filename        = try(data.external.archive_prepare[0].result.filename, null)
  archive_was_missing     = try(data.external.archive_prepare[0].result.was_missing, false)
  # Determine if a local package is used or if it will be stored in S3
  filename = var.local_existing_package != null ? var.local_existing_package : local.archive_filename
  s3_bucket = var.s3_existing_package != null ? var.s3_existing_package.bucket : (var.store_on_s3 ? var.s3_bucket : null)
  s3_key    = var.s3_existing_package != null ? var.s3_existing_package.key : (var.store_on_s3 ? format("%s%s", var.s3_prefix, local.archive_filename) : null)
}
# AWS Lambda Function resource
resource "aws_lambda_function" "this" {
  count = var.create && var.create_function ? 1 : 0
  function_name                      = var.function_name
  description                        = var.description
  role                               = var.lambda_role
  handler                            = var.handler
  memory_size                        = var.memory_size
  runtime                            = var.runtime
  timeout                            = var.timeout
  publish                            = var.publish
  filename         = local.filename
  source_code_hash = fileexists(local.filename) ? filebase64sha256(local.filename) : null
  s3_bucket         = local.s3_bucket
  s3_key            = local.s3_key
  environment {
    variables = var.environment_variables
  }
  tags = merge(
    { terraform-aws-modules = "lambda" },
    var.tags
  )
  depends_on = [aws_iam_role_policy_attachment.lambda_policy]
}
# AWS S3 Object resource for Lambda package
resource "aws_s3_object" "lambda_package" {
  count = var.store_on_s3 && var.create_package ? 1 : 0
  bucket = var.s3_bucket
  key    = local.s3_key
  source = local.filename
}