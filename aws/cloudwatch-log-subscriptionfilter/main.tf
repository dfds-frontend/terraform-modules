terraform {
  required_version = "~> 0.12.2"
}

resource "aws_cloudwatch_log_subscription_filter" "logfilter" {
  name            = "${var.name}"            # "test_lambdafunction_logfilter"
  role_arn        = "${var.role_arn}"        #"${aws_iam_role.iam_for_lambda.arn}"
  log_group_name  = "${var.log_group_name}"  # "/aws/lambda/example_lambda_name"
  filter_pattern  = "${var.filter_pattern}"  # "logtype test"
  destination_arn = "${var.destination_arn}" # "${aws_kinesis_stream.test_logstream.arn}"
  distribution    = "${var.distribution}"    # "Random"
}
