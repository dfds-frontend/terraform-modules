# The example folder, explained

## Introduction
This example folder contains an example of how one can use the module folder definition for importing a certificate.

The folder "terragrunt" contains an example of how it can be done utilizing terragrunt for doing some of the heavy lifting. Some of the benefits of using terragrunt is the removal of rewriteing variable definitions because terragrunt copies the module into it's working folder. This helps keep variable assignments away from the module variable definitions. Also with terragrunt one gets easier remote state storage (eg. stored in a s3 bucket).

The folder also contains a definition for creating a self signed certifitate under the sub folder 'self_signed_example_cert', but only for demonstration purposes of the import certificate functionality.

## Getting Started
Navigate to the example folder 'terragrunt', and run it using the terragrunt apply command.