output "arn" {
  value = aws_sqs_queue.queue.arn
}

output "url" {
  value = aws_sqs_queue.queue.url
}

output "name" {
  value = aws_sqs_queue.queue.name
}

output "dead-letter-arn" {
  value = try(aws_sqs_queue.dead-letter[0].arn, null)
}

output "dead-letter-url" {
  value = try(aws_sqs_queue.dead-letter[0].url, null)
}
