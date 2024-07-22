provider "aws" {
  region = var.region
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_ec2_control_role"

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

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_ec2_control_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "sns:Publish"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_sns_topic" "ec2_notifications" {
  name = "ec2_notifications"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.ec2_notifications.arn
  protocol  = "email"
  endpoint  = "t2scloud@gmail.com"
}

resource "aws_lambda_function" "stop_ec2" {
  function_name = "StopEC2Instances"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename = data.archive_file.stop_ec2_lambda.output_path

  source_code_hash = data.archive_file.stop_ec2_lambda.output_base64sha256

  environment {
    variables = {
      INSTANCE_IDS  = join(",", var.instance_ids)
      SNS_TOPIC_ARN = aws_sns_topic.ec2_notifications.arn
    }
  }
}

resource "aws_lambda_function" "start_ec2" {
  function_name = "StartEC2Instances"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename = data.archive_file.start_ec2_lambda.output_path

  source_code_hash = data.archive_file.start_ec2_lambda.output_base64sha256

  environment {
    variables = {
      INSTANCE_IDS  = join(",", var.instance_ids)
      SNS_TOPIC_ARN = aws_sns_topic.ec2_notifications.arn
    }
  }
}

resource "aws_cloudwatch_event_rule" "start_rule" {
  name                = "StartEC2InstancesRule"
  schedule_expression = var.start_schedule
}

resource "aws_cloudwatch_event_rule" "stop_rule" {
  name                = "StopEC2InstancesRule"
  schedule_expression = var.stop_schedule
}

resource "aws_cloudwatch_event_target" "start_target" {
  rule = aws_cloudwatch_event_rule.start_rule.name
  arn  = aws_lambda_function.start_ec2.arn
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule = aws_cloudwatch_event_rule.stop_rule.name
  arn  = aws_lambda_function.stop_ec2.arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_invoke_start" {
  statement_id  = "AllowEventBridgeToInvokeLambdaStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_ec2.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_rule.arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_invoke_stop" {
  statement_id  = "AllowEventBridgeToInvokeLambdaStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_ec2.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_rule.arn
}

data "archive_file" "stop_ec2_lambda" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/stop_ec2"
  output_path = "${path.module}/lambda/stop_ec2.zip"
}

data "archive_file" "start_ec2_lambda" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/start_ec2"
  output_path = "${path.module}/lambda/start_ec2.zip"
}
