resource "aws_s3_bucket_policy" "b" {
  count = "${var.deploy && length(var.allowed_iam_arns) > 0 ? 1:0 }"
  bucket = "${aws_s3_bucket.bucket[0].id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
             "AWS": ${jsonencode(var.allowed_iam_arns)} 
           },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket[0].id}/*"
    }
  ]
}
POLICY
}