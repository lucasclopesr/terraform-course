#!/bin/bash

# Make sure that docker is running - sudo service start docker
# Make sure that localstack is running - localstack start

# These are the resources that must be created outside of terraform.
# They must exist before terraform apply is called.
# Note: this is supposed to be used in a localstack testing environment.
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

# Create a bucket for remote state and copy current state into it
aws s3api --endpoint-url=http://localhost:4566 --region=us-east-1 create-bucket --bucket remote-state-file
aws s3 --endpoint-url=http://localhost:4566 --region=us-east-1 cp terraform.tfstate s3://remote-state-file/terraform.tfstate
# aws --endpoint-url=http://localhost:4566 --region=us-east-1 s3 ls

# Create DynamoDB for remote state lock
aws --endpoint-url=http://localhost:4566 --region=us-east-1 dynamodb create-table --table-name my-lock-db --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
# aws --endpoint-url=http://localhost:4566 --region=us-east-1 dynamodb scan --table-name my-lock-db
