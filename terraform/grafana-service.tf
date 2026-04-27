# Reference existing target group
data "aws_lb_target_group" "grafana" {
  arn = "arn:aws:elasticloadbalancing:eu-north-1:879696522469:targetgroup/grafana-tg-ecs/78413275af16e77b"
}

# Manage task definition
resource "aws_ecs_task_definition" "grafana" {
  family                   = "grafana-task"
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

# Reference existing ECS service
data "aws_ecs_service" "grafana" {
  cluster      = "assaabloy-app-cluster"
  service_name = "grafana-service"
}
