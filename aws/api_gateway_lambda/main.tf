# ==================================================================#
# API

resource "aws_api_gateway_rest_api" "api" {
  # name = "dfds-cf-api"
  name = "${var.api_gateway_rest_api_name}"

  description = "This is my API for demonstration purposes"
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


# ==================================================================#
# Resource
resource "aws_api_gateway_resource" "parent_resource" {
  # path_part   = "resource"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  
  path_part   = "root-redirect"
}

# ==================================================================#
# Resource child 1 # Move into its own?

# resource "aws_api_gateway_resource" "child_resource" { 
#   # path_part   = "resource"
#   parent_id   = "${aws_api_gateway_resource.parent_resource.id}"
#   rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  
#   path_part   = "{proxy+}"
# }

# resource "aws_api_gateway_method" "method" {
#   rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
#   resource_id   = "${aws_api_gateway_resource.child_resource.id}"
#   http_method   = "ANY"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_method_settings" "s" {
#   rest_api_id = "${aws_api_gateway_rest_api.api.id}"
#   stage_name  = "${aws_api_gateway_stage.latest.stage_name}"
#   method_path = "*/*"  # "${aws_api_gateway_resource.child_resource.path_part}/${aws_api_gateway_method.test.http_method}"

#   settings {
#     metrics_enabled = true
#     logging_level   = "INFO"
#   }
# }

# resource "aws_api_gateway_integration" "integration" {
#   rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
#   resource_id             = "${aws_api_gateway_resource.child_resource.id}"
#   http_method             = "${aws_api_gateway_method.method.http_method}"
#   passthrough_behavior    = "WHEN_NO_MATCH"
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   # uri                     = "arn:aws:apigateway:${var.myregion}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda.arn}/invocations"
#   # uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
#                             # "arn:aws:apigateway:${AWS::Region}: lambda:path/2015-03-31/functions/ ${EntryPointLambdaArn}          /invocations"
#   uri                     = "${var.lambda_function_invoke_arn}"  
# }

# resource "aws_api_gateway_deployment" "deployment" {
#   depends_on = ["aws_api_gateway_integration.integration"]

#   rest_api_id = "${aws_api_gateway_rest_api.api.id}"
#   # stage_name  = "dummy" Default For testing ?
# }


# # Lambda
# resource "aws_lambda_permission" "apigw_lambda" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = "${var.lambda_function_name}"
#   principal     = "apigateway.amazonaws.com"

#   # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
#   # source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}/${aws_api_gateway_resource.resource.path}"
#   # source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*"
#   source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*"
#   # SourceArn: !Sub 'arn:aws:execute-api:${AWS::Region}:${AWS::AccountId}:${UnifiedApiGatewayApi}/*
# }

# ==================================================================#




# ==================================================================#
# Account & IAM
# CloudWatch Logs role ARN must be set in account settings to enable logging
# ==================================================================#
resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = "${aws_iam_role.cloudwatch.arn}"
}

resource "aws_iam_role" "cloudwatch" {
  name = "${var.api_gateway_rest_api_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "${var.api_gateway_rest_api_name}"
  role = "${aws_iam_role.cloudwatch.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}