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

resource "aws_ecs_service" "prometheus" {
  name            = "prometheus-service"
  cluster         = "assaabloy-app-cluster"
  task_definition = aws_ecs_task_definition.prometheus.arn
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
}
