#to_create_resources_in_aws
provider "aws" {
  region = "ap-south-1"
}

#to_create_iam_role
resource "aws_iam_role" "lambda_role" {
  name = "tmdb_api_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

#to_create_lambda_function
resource "aws_lambda_function" "tmdb_lambda_function" {
  filename      = "${path.module}/../python/hello-python.zip"
  function_name = "hello-tmdb_api_lambda_function"
  description   = "Lambda function for ingestion of tmdb api"
  role          = aws_iam_role.lambda_role.arn         #attaching_lambda_role_and_calling_it
  handler       = "hello-python.lambda_handler"
  runtime       = "python3.9"
}

