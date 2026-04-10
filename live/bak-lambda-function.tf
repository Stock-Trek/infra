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
