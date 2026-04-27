resource "aws_subnet" "private1" {
  # define your first private subnet here
}

resource "aws_subnet" "private2" {
  # define your second private subnet here
}

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
}
