# resource "aws_lambda_function" "lambda" {
#   function_name = "stock-trek-check-compile-rust"
#   package_type  = "Image"
#   image_uri     = "${aws_ecr_repository.stock_trek['algorithm-runner'].repository_url}:v0.3.0"
#   role          = aws_iam_role.run_lambda.arn
#   memory_size   = 512
#   timeout       = 30
#   depends_on    = [
#     aws_iam_role_policy_attachment.logs,
#     aws_iam_role_policy_attachment.pull_image
#   ]
# }
# 
# resource "aws_lambda_function_url" "lambda" {
#   function_name      = aws_lambda_function.lambda.function_name
#   authorization_type = "NONE"
# 
#   cors {
#     allow_origins     = [
#       "https://${local.bare_domain}",
#       "https://www.${local.bare_domain}"
#     ]
#     allow_methods     = [
#       "GET",
#       "POST"
#     ]
#     allow_headers     = [
#       "content-type"
#     ]
#     expose_headers    = []
#     max_age           = 86400
#   }
# }
# 
# resource "aws_lambda_permission" "invoke_function" {
#   statement_id           = "InvokeFunction"
#   action                 = "lambda:InvokeFunction"
#   function_name          = aws_lambda_function.lambda.function_name
#   principal              = "*"
# }
# 
# resource "aws_lambda_permission" "invoke_function_url" {
#   statement_id           = "InvokeFunctionUrl"
#   action                 = "lambda:InvokeFunctionUrl"
#   function_name          = aws_lambda_function.lambda.function_name
#   principal              = "*"
#   function_url_auth_type = "NONE"
# }
