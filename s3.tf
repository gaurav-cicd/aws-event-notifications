resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-unique-bucket-name"  # Change to a globally unique name
}

resource "aws_s3_bucket_notification" "s3_event_notification" {
  bucket = aws_s3_bucket.s3_bucket.id

  topic {
    topic_arn = aws_sns_topic.sns_topic.arn
    events    = ["s3:ObjectCreated:*"]
  }
}




