# Introduction 
Boilerplate project for build and deploy of application hosted on Amazon in an s3 bucket backed by Cloudfront distribution.
Cloudfront enable content from s3 bucket through a secure HTTPS connection and provides CDN functionalities.

# Prerequisites
- Access to a capability account on Amazon
- [Terraform](https://www.terraform.io/) v0.12.x
- [Terragrunt](https://github.com/gruntwork-io/terragrunt) minimum version 0.19.x

# How to
- Update bucket name for terraform state in /infrastructure/terragrunt.hcl. Terragrunt can also read from environment variable terraform_state_s3bucket. See [Amazon S3 Bucket Naming Requirements](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-s3-bucket-naming-requirements.html). 
- Update .tfvars in every environment. This file is under /infrastructure/environments/{environment name}/terraform.tfvars
- Navigate to modules/app/dependencies.tf and update relevant shared variables in locals section, then 
- Navigate to modules/app/main.tf and update the following parameters to reflect the expected behavior of the application
  custom_error_response_page_path = "/router/${local.app_path}/app/index.html"
  custom_error_response_code      = 200
- Update modules/app/redirect-rules.js which holds the source code for lambda@edge function so it can handle the routing inside the application.
- You can build infrastructure using docker with the image that is provided [here](https://gitlab.com/dfds-platform/docker-terraform-terragrunt). Then you can run following terragrunt commands:
Dry-run: 
```
terragrunt plan --terragrunt-source-update
```

Apply changes: 
```
terragrunt apply --terragrunt-source-update 
```

**Note**: Lambda function should be modified to handle the request paths and the actual files inside s3 bucket

# Important notes on destroying AWS resources
First you need to make sure that lambda association is removed from Cloudfront. This will delete function replicas

1. Disable request_lambda_edge_function_arn and request_lambda_edge_function_include_body properties in aws_cloudfront_app module
2. Update resources using pipeline and wait until it's done updating
3. Wait until Lambda function replicates to be deleted from edge nodes. This could take several hours! So an attempt to destroy lambda resource could fail in the meanwhile.
4. Run the command locally inside the target environment folder (fx: /dev): terragrunt destroy --terragrunt-source-update
