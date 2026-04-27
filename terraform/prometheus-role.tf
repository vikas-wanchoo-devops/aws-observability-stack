# Reference the existing PrometheusRole
data "aws_iam_role" "prometheus_role" {
  name = "PrometheusRole"
}

# Attach CloudWatch read-only policy
resource "aws_iam_role_policy_attachment" "prometheus_cloudwatch" {
  role       = data.aws_iam_role.prometheus_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

# Attach EC2 read-only policy
resource "aws_iam_role_policy_attachment" "prometheus_ec2" {
  role       = data.aws_iam_role.prometheus_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Attach ReadOnlyAccess (covers ECS and other services)
resource "aws_iam_role_policy_attachment" "prometheus_readonly" {
  role       = data.aws_iam_role.prometheus_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
