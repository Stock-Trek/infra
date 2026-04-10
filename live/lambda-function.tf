resource "aws_lambda_function" "lambda" {
  function_name = "stock-trek-check-compile-rust"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.stock_trek["algorithm-runner"].repository_url}:${var.algorithm_runner_image_tag}"
  role          = aws_iam_role.run_lambda.arn
  publish       = true
  memory_size   = 2048
  timeout       = 30
  depends_on    = [
    aws_iam_role_policy_attachment.logs,
    aws_iam_role_policy_attachment.pull_image
  ]
}
