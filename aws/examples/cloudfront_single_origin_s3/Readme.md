# About
This example to demonstrate how use modules in this repo. 

# Run using Terraform commands
1- Make sure that you are in the example module folder
2- You need to create s3 bucket that will hold the terraform state
3- Run script run-terraform-init.sh to prepare remote state and download terraform plugins
4- Run one of the following terraform commands:
```
terraform plan 
terraform apply 
terraform destroy
```

For more info [click here](https://www.terraform.io/docs/index.html)


# Run using Terragrunt
1- Make sure that you are in the example module folder
2- Run one of the following terragrunt commands:
```
terragrunt plan 
terragrunt apply 
terragrunt destroy
```

For more info [click here](https://github.com/gruntwork-io/)