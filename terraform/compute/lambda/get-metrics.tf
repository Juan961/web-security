data "aws_s3_object" "get_metrics" {
  bucket = var.lambda_bucket
  key    = "get-metrics.zip"
}

resource "aws_lambda_function" "get_metrics" {
  function_name    = "get-metrics"
  handler          = "bootstrap"
  runtime          = "provided.al2"
  s3_bucket        = var.lambda_bucket
  timeout          = 300
  s3_key           = "get-metrics.zip"
  role             = var.repo_collector_role_arn
  source_code_hash = data.aws_s3_object.get_metrics.version_id

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

output "get_metrics_invoke_arn" {
  value = aws_lambda_function.get_metrics.invoke_arn
}

output "get_metrics_lambda_name" {
  value = aws_lambda_function.get_metrics.function_name
}
