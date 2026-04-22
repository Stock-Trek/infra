resource "aws_cloudwatch_event_rule" "scheduled_rule" {
  name                = var.name
  description         = "Cron trigger for ${var.lambda-name} @ ${var.cron}"
  schedule_expression = var.cron
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda-name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scheduled_rule.arn
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.scheduled_rule.name
  target_id = "SendToLambda"
  arn       = var.lambda-arn
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda-basic-execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
