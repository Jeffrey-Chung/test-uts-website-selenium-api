/*
All the Configuration for Lambda goes here, the Lambda function is created in the lambda_src_chrome folder
*/

data "archive_file" "lambda_source_code" {
  type        = "zip"
  source_dir  = "${path.root}/lambda_src_chrome/"
  output_path = "${path.root}/lambda_src_chrome/lambda_src_chrome.zip"
}

resource "aws_lambda_function" "jchung_lambda_function_chrome" {
  filename      = "${path.root}/lambda_src_chrome/lambda_src_chrome.zip"
  function_name = "jchung_test_uts_website_chrome"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function_url" "lambda_function_url" {
  function_name      = aws_lambda_function.jchung_lambda_function_chrome.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
  }
}
