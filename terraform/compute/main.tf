# lambda_bucket son variables que se pasan al var.tf de la carpeta lambda
# repo_collector_role_arn son variables que se pasan al var.tf de la carpeta lambda

module "lambda" {
  source                  = "./lambda"
  lambda_bucket           = var.lambda_bucket
  repo_collector_role_arn = var.repo_collector_role_arn

  security_group_ids = ["sg-0ae5b24d4b5c85a05"]
  subnet_ids         = var.subnet_ids
}
