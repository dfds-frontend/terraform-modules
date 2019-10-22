region                   = "us-east-1" //sets region in provider section

aliases                  = []
comment                  = "AWS Cloudfront Module"
enable                   = true
enable_ipv6              = true
http_version             = "http1.1"
minimum_protocol_version = "TLSv1.1_2016"
price                    = "PriceClass_100"

restriction_type         = "none"
ssl_certificate          = "sslcert"
ssl_support_method       = "sni-only"
tag_name                 = "AWS Cloudfront Module"
//webacl                   = "" // not used in the example... utilizing the default value 

dynamic_s3_origin_config = [
  /*
  // Example of multiple s3 origin configurations, remember to replace values into your specific S3 bucket Origin domain name, path and OAI
  {
    domain_name            = "dfds-platform-portal-dev.s3.amazonaws.com"
    origin_path            = ""
    origin_id              = "Accounts S3 Bucket - Development"
    origin_access_identity = ""
  },
  {
    domain_name            = "domain2.s3.amazonaws.com"
    origin_path            = ""
    origin_id              = "S3-domain2-cert"
    origin_access_identity = "origin-access-identity/cloudfront/1234"
  }
  */
]

dynamic_custom_origin_config = [
  {
    domain_name              = "app.hellman.oxygen.dfds.cloud"
    origin_path              = "/dev/customeriam-reverseproxy"
    origin_id                = "customeriam-reverseproxy"
    http_port                = 80
    https_port               = 443
    origin_keepalive_timeout = 5
    origin_read_timeout      = 30
    origin_protocol_policy   = "https-only"
    origin_ssl_protocols     = ["TLSv1.2", "TLSv1.1"]
  }
  /* Example of how to define more than one cutom origin*/ /* https://api.dfds.cloud/services-email-validation-api/ */
  ,
  {
    domain_name              = "api.dfds.cloud"
    origin_path              = "" // Set to blank, as it is required, but path will always be sent by caller (and used to identify calls should go to this origin), so we don't need to add it.  
    origin_id                = "api-dfds-cloud"
    http_port                = 80
    https_port               = 443
    origin_keepalive_timeout = 5
    origin_read_timeout      = 30
    origin_protocol_policy   = "https-only"
    origin_ssl_protocols     = ["TLSv1.2", "TLSv1.1"]
  }  
]

dynamic_default_cache_behavior = [
  {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "customeriam-reverseproxy"
    compress               = false
    query_string           = true
    cookies_forward        = "all"
    headers                = ["*"]
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }
]

dynamic_ordered_cache_behavior = [
  {
    path_pattern           = "/??-??/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "customeriam-reverseproxy"
    compress               = false
    query_string           = true
    cookies_forward        = "all"
    headers                = []
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  },
  { // Behavior for email validation service, example of sending trafic to a different origin, ranked higher than path pattern "/*.*", to ensure sending swagger def. calls for the service to the correct swagger views
    path_pattern           = "/services-email-validation-api/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "api-dfds-cloud" // The one going somewhere else, too prove the point
    compress               = false
    query_string           = true
    cookies_forward        = "all"
    headers                = []
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  },
  {
    path_pattern           = "/*.*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "customeriam-reverseproxy"
    compress               = false
    query_string           = true
    cookies_forward        = "all"
    headers                = []
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  },
  {
    path_pattern           = "*/.well-known/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "customeriam-reverseproxy"
    compress               = false
    query_string           = true
    cookies_forward        = "all"
    headers                = []
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  },
  {
    path_pattern           = "/.well-known/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "customeriam-reverseproxy"
    compress               = false
    query_string           = true
    cookies_forward        = "all"
    headers                = []
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }
]

// This section needs reworking...
dynamic_custom_error_response = [
  {
    error_caching_min_ttl = 1
    error_code            = 400
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 403
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 404
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 405
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 414
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 416
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 500
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 501
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 502
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 503
    response_code         = null
    response_page_path    = ""
  },
  {
    error_caching_min_ttl = 1
    error_code            = 504
    response_code         = null
    response_page_path    = ""
  }
]