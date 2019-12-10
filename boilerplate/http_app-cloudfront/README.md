# web_app-cloudfront
This is a boilerplate project for terraform setup of Cloudfront in front of web app. This app could be hosted any platform such as Zeit Now.

# Prerequistes
- Access to a capability account on Amazon
- Terraform v0.12.x and Terragrunt minimum version 0.19.x

# How to
- Update bucket name for terraform state in /infrastructure/terragrunt.hcl. Terragrunt can also read from environment variable terraform_state_s3bucket
- Update .tfvars in every environment. This file is under /infrastructure/environments/{environment name}/terraform.tfvars
- Use the terraform-terragrunt image provided on (?) and run following commands:
Dry-run: 
```
terragrunt plan 
```

Apply changes: 
```
terragrunt apply 
```

**Note**: Lambda function should be modified to handle the request pathes on the hosted app

# Important notes on destroying AWS resources
First you need to make sure that lambda association is removed from Cloudfront. This will delete function replicas

1. set request_lambda_edge_function_arn to "" in aws_cloudfront-portal resource
2. Update resources using pipeline and wait until it's done updating
3. Run the command locally inside the target environment folder (fx: /dev): terragrunt destroy --terragrunt-source-update