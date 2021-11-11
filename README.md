# Terraform course

This repository contains an incrementing Terraform configuration following the 
[Mastering Terraform - Integrating with Jenkins and Ansible](https://wex.udemy.com/course/terraform-iac-aws/) 
course. Everything in the course is adapted to run in a [Localstack](https://github.com/localstack/localstack) 
environment, rather than on AWS directly (so don't worry about public access and secret keys!).

## How to use the code in this repository

Assuming that you already have localstack, terraform and awscli installed, start localstack
running `localstack start`.

Then, run the `aws_resources.sh` script to create the resources that are needed for Terraform
but cannot be created through Terraform (s3 remote state backend and DynamoDB remote state lock).

Finally, run `terraform init` and `terraform apply -var-file=config/<some-file>.tfvars` to create
resources in localstack.

# Configuring AWS IAM for Terraform
- Go to IAM
- Add User
  - Name: terraform
  - Access type: Programmatic access
  - Permissions: Attach existing policies > Administrator Access
- run aws configure
  - Add access key and secret access key
  - Configure region
