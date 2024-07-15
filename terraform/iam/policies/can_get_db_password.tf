resource "aws_iam_policy" "can_get_db_password" {
  name        = "can-get-db-password"
  path = "/"
  description = "Allows access to retrieve secrets from Secrets Manager"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "secretsmanager:GetSecretValue"
        ],
        Effect : "Allow",
        Resource : "arn:aws:secretsmanager:us-east-1:675542093704:secret:rds!db-78bea4ba-35c2-4697-9fab-4b80d4589ea5-CyKC7E"
      }
    ]
  })
}

output "can_get_db_password_arn" {
  value = aws_iam_policy.can_get_db_password.arn
}
