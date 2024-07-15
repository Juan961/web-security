# Estas variables se pasan cuando se está definiendo el módulo en otra parte
# En este caso en el main principal de terraform

variable "lambda_bucket" {
  type = string
}

variable "repo_collector_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
