resource "aws_sns_topic" "sns_topic" {
  name = "my-sns-topic"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "test@xyz.com"
}
