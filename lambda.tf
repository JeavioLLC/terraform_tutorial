data "archive_file" "lambda" {
  type        = "zip"
  source_file  = "index.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "example_lambda_function" {
  filename      = "${path.module}/lambda_function_payload.zip"
  function_name = "Example_Lambda_Function"
  role          = local.aws_lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.10"
}

resource "aws_lambda_function_url" "example_lambda_function_url" {
  function_name = aws_lambda_function.example_lambda_function.function_name
  authorization_type = "NONE"
}



output "name" {
  value = aws_lambda_function_url.example_lambda_function_url
  
}