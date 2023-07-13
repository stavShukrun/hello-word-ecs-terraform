resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/app"
  retention_in_days = 30

  tags = {
    Name = "log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}