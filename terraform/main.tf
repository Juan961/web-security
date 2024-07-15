terraform {
  backend "s3" {
    bucket = "terraform-bucket-sec"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "iam" {
  source = "./iam"
}

module "s3" {
  source = "./s3"
}

module "compute" {
  source                  = "./compute"
  lambda_bucket           = module.s3.lambda_bucket
  repo_collector_role_arn = module.iam.repo_collector_role_arn
  subnet_ids = [
    "subnet-095b256d437e41b9e",
    "subnet-046d2beb2f84c9932",
    "subnet-004fa90c134adf0d1",
    "subnet-006fa743964330e1c",
    "subnet-03b0551225fc46f81",
    "subnet-04d3dd7bdc5aa02ee",
  ]
}
