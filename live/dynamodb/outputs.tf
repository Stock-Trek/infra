output "arn" {
  value = aws_dynamodb_table.table.arn
}

output "name" {
  value = aws_dynamodb_table.table.name
}

output "stream-arn" {
  value = aws_dynamodb_table.table.stream_arn
}
