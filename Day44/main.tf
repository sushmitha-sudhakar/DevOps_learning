resource "aws_iam_role" "role" {
  name = var.replication_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "destination" {
  provider = "aws.east"
  bucket   = var.destination_bucket_name
}

resource "aws_s3_bucket_versioning" "destination_versioning" {
  provider = "aws.east"
  bucket   = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "source" {
  provider = "aws.west"
  bucket   = var.source_bucket_name
}

resource "aws_s3_bucket_versioning" "source_versioning" {
  provider = "aws.west"
  bucket   = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  provider = "aws.west"
  bucket   = aws_s3_bucket.source.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  provider   = "aws.west"
  depends_on = [aws_s3_bucket_ownership_controls.ownership]

  bucket = aws_s3_bucket.source.id
  acl    = "private"
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  provider = "aws.west"
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source_versioning]

  role   = aws_iam_role.role.arn
  bucket = aws_s3_bucket.source.id

  rule {
    status = "Enabled"

    filter {
      prefix = ""
    }

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
    delete_marker_replication {
      status = "Enabled"
    }
  }
}

resource "aws_iam_policy" "policy" {
  name = var.policy_name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.destination.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
  name       = var.policy_attachment_name
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}