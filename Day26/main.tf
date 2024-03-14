resource "aws_iam_user" "user" {
  count = length(var.user_name)
  name  = element(var.user_name,count.index)
}

data "aws_iam_policy_document" "document" {
  statement {
    actions = [
      "ec2:Describe*"]
    resources = [
      "*"]
  }
}

resource "aws_iam_policy" "policy" {
 name   = var.policy_name
 policy = data.aws_iam_policy_document.document.json
}

resource "aws_iam_user_policy_attachment" "attach" {
 count      = length(var.user_name)
 user       = element(aws_iam_user.user.*.name,count.index)
 policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role" "role" {
  name               = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
      name = var.role_name
   }
}

resource "aws_iam_instance_profile" "profile" {
  name = var.profile_name
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "policy" {
  name   = var.role_policy_name
  role   = aws_iam_role.role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_instance" "role-test" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.profile.name
  key_name             = var.keyname
}