resource "aws_lb_target_group" "grafana" {
  name        = "grafana-tg-ecs"   # renamed to avoid conflict
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = "vpc-0b5d7248bdde16ef7"
  target_type = "ip"

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    matcher             = "200-302"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "grafana" {
  listener_arn = aws_lb_listener.app.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana.arn
  }
  condition {
    host_header {
      values = ["grafana.assaabloy-app-alb-373654538.eu-north-1.elb.amazonaws.com"]
    }
  }
}

resource "aws_ecs_task_definition" "grafana" {
  family                   = "grafana-task-ecs"   # renamed
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([{
    name      = "grafana"
    image     = "grafana/grafana:latest"
    essential = true
    portMappings = [{ containerPort = 3000, hostPort = 3000 }]
    environment = [
      { name = "GF_SECURITY_ADMIN_USER", value = "admin" },
      { name = "GF_SECURITY_ADMIN_PASSWORD", value = "admin" }
    ]
  }])
}

resource "aws_ecs_service" "grafana" {
  name            = "grafana-service-ecs"   # renamed
  cluster         = "assaabloy-app-cluster"
  task_definition = aws_ecs_task_definition.grafana.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      "subnet-0d16d36a33d1c1f22",
      "subnet-013e51f5fbc1318cb",
      "subnet-0a4e24f116d3364f9"
    ]
    security_groups = ["sg-04df50a141a12d19a"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.grafana.arn
    container_name   = "grafana"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener_rule.grafana]
}
