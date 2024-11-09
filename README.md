# AWS Lambda Terraform Module
This module creates an AWS Lambda function along with optional S3 packaging and IAM role attachment.
## Usage
hcl
module "mylambdafunction" {
  source               = "./awslambdamodule"
  awsregion           = "us-west-2"
  create               = true
  createfunction      = true
  functionname        = "MyLambdaFunction"
  description          = "This is my AWS Lambda function"
  lambdarole          = "arn:aws:iam::account-id:role/my-lambda-role"  
  handler              = "index.handler"
  memorysize          = 256 
  runtime              = "nodejs14.x"
  timeout              = 10 
  environmentvariables = {
    MYENVVAR = "value"
  }
  s3bucket            = "my-lambda-bucket"
  s3prefix            = "my-prefix/" 
  storeons3         = true
  create_package       = true
  tags                 = {
    Environment = "dev"
  }
}