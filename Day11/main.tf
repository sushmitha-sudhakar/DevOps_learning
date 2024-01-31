resource "aws_s3_bucket_policy" "policy" {
  bucket = var.bucket_name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::myawstestbucketfortestingp/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "192.168.225.110"}
      }
    }
  ]
}
POLICY
}