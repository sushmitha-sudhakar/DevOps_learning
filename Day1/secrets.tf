data "aws_ssm_parameter" "access_key" {
  name = "Access_key"
}

data "aws_ssm_parameter" "secret_key" {
  name = "Secret_key"
}