output "ec2_arn" {
  value = aws_instance.ec2.arn
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "sns_topic" {
  value = aws_sns_topic.topic.arn
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}


