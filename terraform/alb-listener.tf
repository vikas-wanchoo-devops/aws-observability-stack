variable "create_listener" {
  type    = bool
  default = false
}

# Read existing listener if already created
data "aws_lb_listener" "app" {
  count = var.create_listener ? 0 : 1
  arn   = "arn:aws:elasticloadbalancing:eu-north-1:879696522469:listener/app/assaabloy-app-alb/6f2878a5c4470aa5/1bba9a3cfb100633"
}

# Create listener only if flag is true
resource "aws_lb_listener" "app" {
  count             = var.create_listener ? 1 : 0
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
