# Configuring AWS IAM for Terraform
- Go to IAM
- Add User
  - Name: terraform
  - Access type: Programmatic access
  - Permissions: Attach existing policies > Administrator Access
- run aws configure
  - Add access key and secret access key
  - Configure region
