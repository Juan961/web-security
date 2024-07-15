data "aws_s3_object" "hanle_github_webhook" {
  bucket = var.lambda_bucket
  key    = "handle-github-webhook.zip"
}

resource "aws_lambda_function" "hanle_github_webhook" {
  function_name    = "handle-github-webhook"
  handler          = "bootstrap"
  runtime          = "provided.al2"
  s3_bucket        = var.lambda_bucket
  timeout          = 300
  s3_key           = "handle-github-webhook.zip"
  role             = var.repo_collector_role_arn
  source_code_hash = data.aws_s3_object.hanle_github_webhook.version_id # Para que sepa cuando cambia de versión la lambda

  vpc_config {
    subnet_ids          = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = {
      DB_HOST     = "platzi-course.cfbmmy7rkrlp.us-east-1.rds.amazonaws.com"
      DB_PORT     = "5432"
      DB_USER     = "postgres"
      DB_PASSWORD = "rds!db-78bea4ba-35c2-4697-9fab-4b80d4589ea5" 
      DB_NAME     = "postgres"
    }
  }
}

output "hanle_github_webhook_invoke_arn" {
  value = aws_lambda_function.hanle_github_webhook.invoke_arn
}

output "hanle_github_webhook_lambda_name" {
  value = aws_lambda_function.hanle_github_webhook.function_name
}
