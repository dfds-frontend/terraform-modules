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

- When ready, Create a pull request into master.
- Update module refrences in boilerplate code
- When checks are green, Merge pull request into master
- Create new tag/release:

  - Tag version: Version number should follow [Semantic Versioning 2.0.0](https://semver.org/).
  - The title should be the should describe the release in concise way.
  - Description: This should contain, at least one of the following elements:
    ```
    ENHANCEMENTS:
    - Describes what features are added, if any.

    BUGFIXES:
    - Describes what bugfixes, the new release features has added, if any.
    ```
## Examples in this project 
The examples in this repo are used as part of documentation and for running the tests.