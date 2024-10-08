/*
All the Configuration for Lambda goes here, the Lambda function is created in the lambda_src_chrome folder
*/

data "archive_file" "lambda_source_code" {
  type        = "zip"
  source_dir  = "${path.root}/aws_lambda_functions/lambda_src_chrome/"
  output_path = "${path.root}/aws_lambda_functions/lambda_src_chrome.zip"
}

data "archive_file" "lambda_source_code_firefox" {
  type        = "zip"
  source_dir  = "${path.root}/aws_lambda_functions/lambda_src_firefox/"
  output_path = "${path.root}/aws_lambda_functions/lambda_src_firefox.zip"
}

data "archive_file" "source_code_update_testcount" {
  type        = "zip"
  source_dir  = "${path.root}/aws_lambda_functions/src_update_testcount/"
  output_path = "${path.root}/aws_lambda_functions/src_update_testcount.zip"
}

data "archive_file" "source_code_get_testcount" {
  type        = "zip"
  source_dir  = "${path.root}/aws_lambda_functions/src_get_testcount/"
  output_path = "${path.root}/aws_lambda_functions/src_get_testcount.zip"
}

resource "aws_lambda_function" "jchung_lambda_function_chrome" {
  filename      = "${path.root}/aws_lambda_functions/lambda_src_chrome.zip"
  function_name = "jchung_test_uts_website_chrome"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "index.lambda_handler"
  runtime       = "python3.10"
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "jchung_lambda_function_firefox" {
  filename      = "${path.root}/aws_lambda_functions/lambda_src_firefox.zip"
  function_name = "jchung_test_uts_website_firefox"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "index.lambda_handler"
  runtime       = "python3.10"
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "jchung_lambda_function_update_view_chrome" {
  filename      = "${path.root}/aws_lambda_functions/src_update_testcount.zip"
  function_name = "jchung_test_update_testcount_chrome"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "update_testcount_chrome.lambda_handler"
  runtime       = "python3.10"
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "jchung_lambda_function_update_view_firefox" {
  filename      = "${path.root}/aws_lambda_functions/src_update_testcount.zip"
  function_name = "jchung_test_update_testcount_firefox"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "update_testcount_firefox.lambda_handler"
  runtime       = "python3.10"
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "jchung_lambda_function_get_view_chrome" {
  filename      = "${path.root}/aws_lambda_functions/src_get_testcount.zip"
  function_name = "jchung_test_get_testcount_chrome"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "get_testcount_chrome.lambda_handler"
  runtime       = "python3.10"
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "jchung_lambda_function_get_view_firefox" {
  filename      = "${path.root}/aws_lambda_functions/src_get_testcount.zip"
  function_name = "jchung_test_get_testcount_firefox"
  role          = "arn:aws:iam::663790350014:role/jchung_lambda_role"
  handler       = "get_testcount_firefox.lambda_handler"
  runtime       = "python3.10"
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

resource "aws_lambda_function_url" "lambda_function_url_firefox" {
  function_name      = aws_lambda_function.jchung_lambda_function_firefox.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
  }
}

resource "aws_lambda_function_url" "lambda_function_url_update_testcount_firefox" {
  function_name      = aws_lambda_function.jchung_lambda_function_update_view_firefox.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
  }
}

resource "aws_lambda_function_url" "lambda_function_url_update_testcount_chrome" {
  function_name      = aws_lambda_function.jchung_lambda_function_update_view_chrome.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
  }
}

resource "aws_lambda_function_url" "lambda_function_url_get_testcount_firefox" {
  function_name      = aws_lambda_function.jchung_lambda_function_get_view_firefox.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
  }
}

resource "aws_lambda_function_url" "lambda_function_url_get_testcount_chrome" {
  function_name      = aws_lambda_function.jchung_lambda_function_get_view_chrome.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
  }
}
