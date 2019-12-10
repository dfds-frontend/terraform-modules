output "api_gateway_account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}


output "api_gateway_rest_api_id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}
# output "api_gateway_resource_id" {
#   value = "${aws_api_gateway_resource.resource.id}"
# }

output "api_gateway_http_method" {
  value = "${aws_api_gateway_method.method.http_method}"
}

# output "api_gateway_resource_path" {
#   value = "${aws_api_gateway_resource.resource.path}"
# }

output "invoke_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}