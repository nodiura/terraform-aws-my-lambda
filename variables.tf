# aws_lambda_module/variables.tf
variable "aws_region" {
  description = "AWS region to deploy the Lambda function"
  type        = string
}
variable "create" {
  description = "Flag to create the Lambda function and resources"
  type        = bool
}
variable "create_function" {
  description = "Flag to create the Lambda function"
  type        = bool
}
variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}
variable "description" {
  description = "Description of the Lambda function"
  type        = string
}
variable "lambda_role" {
  description = "IAM role for the Lambda function with necessary permissions"
  type        = string
}
variable "handler" {
  description = "The function entry point in your code"
  type        = string
}
variable "memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
}
variable "runtime" {
  description = "Runtime for the Lambda function (e.g., nodejs14.x)"
  type        = string
}
variable "timeout" {
  description = "Timeout for the Lambda function execution (in seconds)"
  type        = number
}
variable "environment_variables" {
  description = "Map of environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}
variable "s3_bucket" {
  description = "S3 bucket to store the Lambda package"
  type        = string
}
variable "s3_prefix" {
  description = "S3 key prefix for the package"
  type        = string
  default     = ""
}
variable "local_existing_package" {
  description = "Local existing package path to use instead of creating a new one"
  type        = string
  default     = null
}
variable "s3_existing_package" {
  description = "Existing S3 package details"
  type        = object({
    bucket     = string
    key        = string
    version_id = string
  })
  default     = null
}
variable "store_on_s3" {
  description = "Flag indicating if the package should be stored in S3"
  type        = bool
}
variable "create_package" {
  description = "Flag to create package in S3"
  type        = bool
}
variable "tags" {
  description = "Tags to attach to the Lambda function"
  type        = map(string)
  default     = {}
}
variable "publish" {
  description = "Indicates whether to publish a new version of the Lambda function"
  type        = bool
  default     = false  # Default value can be set to false; adjust as needed
}