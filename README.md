![Terraform verison ](https://img.shields.io/badge/tf-=%3E0.12.2-blue)
# terraform-modules

## Contribution guide
### Creating a new module:

- Create a new branch from master
- Create a folder with the name of the new module
- The module folder should be consisting of the following files:

```
vars.tf

main.tf

outputs.tf
```
- A module should require minimum version in the following format: 
```
terraform {
  required_version = "~> 0.12.2"
}
```

This should be declared in the top of main.tf file.

### Testing new module
Since development work will be in a separate branch, whether it is about adding new modules or just introducing changes to existing modules, you might need to test in a exiting project.
To do so you change module source reference in your code to point to your branch: 

```
module "mymodule" {
  source = "git::https://github.com/dfds-frontend/terraform-modules.git//path-to-module?ref=your-branch"
  ...
}
``` 

### Release new code
Here are steps to merge code into master:
- Decide on version number for the new release. Version number should follow [Semantic Versioning 2.0.0](https://semver.org/).
Version number should always be prefixed with v. Example: v0.0.1

- Update module references in boilerplate code to point to the new release as follows (assuming that the new version is v0.0.1):
```
module "mymodule" {
  source = "git::https://github.com/dfds-frontend/terraform-modules.git//path-to-module?ref=v0.0.1"
  ...
}
``` 
- When ready, create a pull request into master.
- When checks are green, Merge pull request into master.
- Create new tag/release:

  - Tag version: Version number of the new release.
  - The title should be the should describe the release in concise way.
  - Description: This should contain, at least one of the following elements:
    ```
    ENHANCEMENTS:
    - Describes what features are added, if any.

    BUGFIXES:
    - Describes what bugfixes, the new release features has added, if any.
    ```
## Examples in this project 
The examples in this repo are used as part of the documentation and for running the tests.