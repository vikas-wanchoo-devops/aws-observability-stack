# terraform/app-target-group.tf
# Target Group for Assa Abloy Application

resource "aws_lb_target_group" "app_tg" {
  name     = "assaabloy-app-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}
