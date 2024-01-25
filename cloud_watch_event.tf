resource "aws_cloudwatch_event_rule" "event" {
  name                = "Event_Rule"
  schedule_expression = "rate(1 hour)"
  event_pattern       = <<EOF
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ],
  "detail": {
    "state": [
      "stopped"
    ],
    "instance-id": [
      "${aws_instance.ec2.id}"
      ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.event.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.topic.arn
}

resource "aws_lambda_function_event_invoke_config" "sns" {
  function_name = aws_lambda_function.lambda.function_name
  destination_config {
    on_failure {
      destination = aws_sns_topic.topic.arn
    }
    on_success {
      destination = aws_sns_topic.topic.arn
    }
  }
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.event.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event.arn
}
