# The example folder, explained

## Introduction
This example folder contains an example of how one can use the module folder definition of the s3 bucket in two ways.
The folder "terraform" contains an example of how it can be done with pure terraform, no additional tools. But ignoring usage of remote state (eg. stored in a s3 bucket).
The folder "terragrunt" contains an example of how it can be done utilizing terragrunt for doing some of the heavy lifting. Some of the benefits of using terragrunt is the removal of rewriteing variable definitions because terragrunt copies the module into it's working folder. This helps keep variable assignments away from the module variable definitions. Also with terragrunt one gets easier remote state storage (eg. stored in a s3 bucket). 

## Getting Started
Open the example folder you wan't to test, and run it using either the terragrunt or terraform apply command (the terragrunt command will work with either example).

The terraform example could have been simplified , by assigning the variable values directly in the module instantiation like:
```
module "create_s3bucket_using_module" {
  source = "./../../"
  s3_bucket = "unique-name-here"
  enable_versioning = true
  ... = ...
  ...
}
```  