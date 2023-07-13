resource "aws_alb" "main" {
  name            = var.alb_name
  subnets         = var.subnets_public_ids
  security_groups = [var.load_balancer_sg_id]
}

resource "aws_alb_target_group" "app" {
  name        = var.alb_target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = "5"
    timeout             = "2"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.arn
    type             = "forward"
  }
}