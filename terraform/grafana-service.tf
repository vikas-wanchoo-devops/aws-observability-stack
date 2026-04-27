resource "aws_ecs_task_definition" "grafana" {
  family                   = "grafana-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "grafana"
      image     = "grafana/grafana:latest"
      essential = true
      portMappings = [
        { containerPort = 3000, hostPort = 3000 }
      ]
      environment = [
        { name = "GF_SECURITY_ADMIN_USER", value = "admin" },
        { name = "GF_SECURITY_ADMIN_PASSWORD", value = "admin" }
      ]
      mountPoints = [
        {
          sourceVolume  = "grafana-provisioning"
          containerPath = "/etc/grafana/provisioning"
        }
      ]
    }
  ])

  volume {
    name = "grafana-provisioning"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.grafana.id
    }
  }
}

resource "aws_ecs_service" "grafana" {
  name            = "grafana-service"
  cluster         = "assaabloy-app-cluster"
  task_definition = aws_ecs_task_definition.grafana.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-xxxx"]
    security_groups = ["sg-xxxx"]
    assign_public_ip = true
  }
}
