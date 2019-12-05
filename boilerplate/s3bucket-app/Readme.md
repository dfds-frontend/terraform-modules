# Introduction 
Boilerplate project for build and deploy of application hosted on Amazon in an s3 bucket backed by Cloudfront distribution.
Cloudfront enable content from s3 bucket through a secure HTTPS connection and provides CDN functionalities.

# Prerequisites
- Access to a capability account on Amazon
- Terraform v0.12.x and Terragrunt minimum version 0.19.x

# How to
- Update bucket name for terraform state in /infrastructure/terragrunt.hcl. Terragrunt can also read from environment variable terraform_state_s3bucket. **Note**: Underscore character can not be used in naming the s3 bucket. 
- Update .tfvars in every environment. This file is under /infrastructure/environments/{environment name}/terraform.tfvars
- Use the docker-terraform-terragrunt image provided [here](https://gitlab.com/dfds-platform/docker-terraform-terragrunt) and run following commands:
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
