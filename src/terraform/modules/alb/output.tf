output "alb_target_group_arn" {
  value = aws_alb_target_group.app.arn
}

output "alb_hostname" {
  value = aws_alb.main.dns_name
}