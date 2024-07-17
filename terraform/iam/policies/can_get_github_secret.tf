resource "aws_iam_policy" "can_get_github_secret" {
  name        = "can-get-github-secret"
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
        Resource : "arn:aws:secretsmanager:us-east-1:675542093704:secret:github/secret-NtSBSK"
      }
    ]
  })
}

output "can_get_github_secret_arn" {
  value = aws_iam_policy.can_get_github_secret.arn
}
