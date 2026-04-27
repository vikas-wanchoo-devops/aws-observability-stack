resource "aws_ecs_task_definition" "prometheus" {
  family                   = "prometheus-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "prometheus"
      image     = "prom/prometheus:latest"
      essential = true
      portMappings = [
        { containerPort = 9090, hostPort = 9090 }
      ]
      mountPoints = [
        {
          sourceVolume  = "prometheus-config"
          containerPath = "/etc/prometheus"
        }
      ]
    }
  ])

  volume {
    name = "prometheus-config"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.prometheus.id
    }
  }
}

resource "aws_ecs_service" "prometheus" {
  name            = "prometheus-service"
  cluster         = "assaabloy-app-cluster"
  task_definition = aws_ecs_task_definition.prometheus.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-xxxx"]   # replace with your VPC subnets
    security_groups = ["sg-xxxx"]       # replace with your SG
    assign_public_ip = true
  }
}
