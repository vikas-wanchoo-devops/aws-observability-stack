resource "aws_ecs_task_definition" "kafka" {
  family                   = "kafka-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"

  container_definitions = jsonencode([
    {
      name      = "zookeeper"
      image     = "bitnami/zookeeper:latest"
      essential = true
      portMappings = [{ containerPort = 2181, hostPort = 2181 }]
    },
    {
      name      = "kafka"
      image     = "bitnami/kafka:latest"
      essential = true
      portMappings = [{ containerPort = 9092, hostPort = 9092 }]
      environment = [
        { name = "KAFKA_CFG_ZOOKEEPER_CONNECT", value = "localhost:2181" },
        { name = "ALLOW_PLAINTEXT_LISTENER", value = "yes" }
      ]
    }
  ])
}

resource "aws_ecs_service" "kafka" {
  name            = "kafka-service"
  cluster         = "assaabloy-app-cluster"
  task_definition = aws_ecs_task_definition.kafka.arn
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
