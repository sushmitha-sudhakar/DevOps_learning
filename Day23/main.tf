resource "aws_ebs_volume" "kms-ebs" {
  availability_zone = var.availability_zone
  size              = 10
  type              = "gp2"
  encrypted         = true
  kms_key_id        = var.kms_key
}