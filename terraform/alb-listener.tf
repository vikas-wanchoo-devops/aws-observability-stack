# ALB listener for HTTP traffic on port 80
resource "aws_lb_listener" "app" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:eu-north-1:879696522469:loadbalancer/app/assaabloy-app-alb/6f2878a5c4470aa5"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Default response"
      status_code  = "404"
    }
  }
}
