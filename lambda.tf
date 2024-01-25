resource "aws_lambda_function" "lambda" {
  filename         = "lambda_function.zip"
  function_name    = "CreateSnapshot"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64("lambda_function.zip")
}
