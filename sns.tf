resource "aws_sns_topic" "topic" {
  name                                = "my-topic"
  lambda_failure_feedback_role_arn    = aws_iam_role.sns_role.arn
  lambda_success_feedback_role_arn    = aws_iam_role.sns_role.arn
  lambda_success_feedback_sample_rate = "100"
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda.arn
}
