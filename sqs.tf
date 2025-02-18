resource "aws_sqs_queue" "sqs_queue" {
  name                      = "my-sqs-queue"
  visibility_timeout_seconds = 30
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0
  redrive_policy            = jsonencode({
    maxReceiveCount      = 100
    deadLetterTargetArn  = aws_sqs_queue.dlq.arn
  })
}

resource "aws_sqs_queue" "dlq" {
  name = "my-dlq"
}

resource "aws_sqs_queue_policy" "sns_sqs_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id
  policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${aws_sns_topic.sns_topic.arn}" }
      }
    }
  ]
}
POLICY
}

resource "aws_sns_topic_subscription" "sqs_sub" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_queue.arn
}
