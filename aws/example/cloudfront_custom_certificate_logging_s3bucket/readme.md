# The example folder, explained
This example illustrates a way to use multiple modules in this repo to gain an complex structure setup.

## Introduction
This example joins together a cloudfront resource with the use of a custom imported certificate and with a dedicated s3 Bucket for logging requests into.

## Getting Started

Remember to add the custom certificate content to the 3 files; 'certificate-body.pem', 'certificate-chain.pem' & 'certificate-private-key.pem'.
- also be aware that the certificate, content is persisted into the terraform state file and  / or s3 bucket used to store the state file.
  Anyone in control of all 3 can claim to be issueing security tokens and serve content on behalf of the domain in the certificate.