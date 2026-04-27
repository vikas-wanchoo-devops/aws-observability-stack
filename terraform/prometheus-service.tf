# Reference existing target group
data "aws_lb_target_group" "prometheus" {
  arn = "arn:aws:elasticloadbalancing:eu-north-1:879696522469:targetgroup/prometheus-tg-ecs/43148ae3c7075f70"
}

# Manage task definition
resource "aws_ecs_task_definition" "prometheus" {
  family                   = "prometheus-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([{
    name      = "prometheus"
    image     = "prom/prometheus:latest"
    essential = true
    portMappings = [{ containerPort = 9090, hostPort = 9090 }]
  }])
}

# Reference existing ECS service
data "aws_ecs_service" "prometheus" {
  cluster      = "assaabloy-app-cluster"
  service_name = "prometheus-service"
}
