# aws_lambda_module/outputs.tf
output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.this[0].arn
}
output "lambda_s3_object_key" {
  description = "The S3 key of the Lambda package object"
  value       = aws_s3_object.lambda_package[0].key
}