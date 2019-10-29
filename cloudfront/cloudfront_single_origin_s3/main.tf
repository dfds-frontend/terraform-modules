module "aws_cf_dist_s3" {
    # source = "../../../../../../../../terraform_modules//cf"
    source = "../terraform_modules//cf"
    # TODO: Define wrappers with default that suites s3 bucket
    #       Use lookups!

    # for-each only in resources!?
    

    

    is_s3_bucket_dist = true # default ceche_behavior is allowed                                   
}

