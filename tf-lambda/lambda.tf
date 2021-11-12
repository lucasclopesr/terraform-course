locals {
  lambda_zip_location = "outputs/welcome.zip"
}

resource "aws_lambda_function" "welcome_lambda" {
  filename      = local.lambda_zip_location
  function_name = "welcome"
  role          = aws_iam_role.lambda_role.arn
  handler       = "welcome.hello" # filename.functionname

  # Make sure function is redeployed if source code changes
  source_code_hash = filebase64sha256(local.lambda_zip_location)

  runtime = "python3.7"
}

# Create the zip file to be used by aws_lambda_function
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "welcome.py"
  output_path = local.lambda_zip_location
}
