output "stop_ec2_lambda_arn" {
  description = "ARN of the Stop EC2 Lambda function"
  value       = aws_lambda_function.stop_ec2.arn
}

output "start_ec2_lambda_arn" {
  description = "ARN of the Start EC2 Lambda function"
  value       = aws_lambda_function.start_ec2.arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS Topic for EC2 notifications"
  value       = aws_sns_topic.ec2_notifications.arn
}
