# terraform/app-network.tf
# Networking resources for Assa Abloy Application

# Use existing subnets in your VPC
data "aws_subnet" "private1" {
  id = "subnet-0d16d36a33d1c1f22" # eu-north-1b
}

data "aws_subnet" "private2" {
  id = "subnet-013e51f5fbc1318cb" # eu-north-1c
}

data "aws_subnet" "private3" {
  id = "subnet-0a4e24f116d3364f9" # eu-north-1a
}

# Security Group for App / Observability ECS tasks
resource "aws_security_group" "app_sg" {
  name        = "assaabloy-app-sg"
  description = "Security group for Assa Abloy App"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prevent Terraform from trying to revoke the default egress rule,
  # which requires ec2:RevokeSecurityGroupEgress permission not granted
  lifecycle {
    ignore_changes = [egress]
  }
}
