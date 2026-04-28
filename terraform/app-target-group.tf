# terraform/app-target-group.tf
# Reference existing Target Group for Assa Abloy Application

data "aws_lb_target_group" "app_tg" {
  name = "assaabloy-app-tg"
}
