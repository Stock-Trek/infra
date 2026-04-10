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
