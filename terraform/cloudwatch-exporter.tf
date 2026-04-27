resource "aws_ecs_task_definition" "cloudwatch_exporter" {
  family                   = "cloudwatch-exporter-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "cloudwatch-exporter"
    image     = "prom/cloudwatch-exporter:latest"
    essential = true
    portMappings = [{ containerPort = 9106, hostPort = 9106 }]
  }])
}

resource "aws_ecs_service" "cloudwatch_exporter" {
  name            = "cloudwatch-exporter-service"
  cluster         = "assaabloy-app-cluster"
  task_definition = aws_ecs_task_definition.cloudwatch_exporter.arn
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
