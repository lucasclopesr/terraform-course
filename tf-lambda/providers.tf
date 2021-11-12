terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider specifically to use in localhost with localstack
provider "aws" {
  region                      = var.region
  s3_force_path_style         = true
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
		ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    route53        = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

terraform {
  backend "s3" {
    bucket = "remote-state-file" # This bucket needs to be created outside of terraform
    key    = "terraform_lambda.tfstate"
    region = "us-east-1"
    endpoint     = "http://localhost:4566"

		access_key                  = "test"
		secret_key                  = "test"
		skip_credentials_validation = true
		skip_metadata_api_check     = true
		force_path_style            = true # Required!

    dynamodb_table    = "my-lock-db"
    dynamodb_endpoint = "http://localhost:4566"

  }
}
