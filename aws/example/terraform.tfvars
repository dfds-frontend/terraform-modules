region                   = "us-east-1" //sets region in provider section

cloudfront_ssl_certificate          = "sslcert"
cloudfront_ssl_support_method       = "sni-only"
cloudfront_tag_name                 = "AWS Cloudfront Module"
//webacl                   = "" // not used in the example... utilizing the default value 

cloudfront_dynamic_custom_origin_config = [
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
  ,
  {
    domain_name              = "api.dfds.cloud"
    origin_path              = "" // Set to blank, as it is required by our module folder definition behavior, but path will always be sent by caller (and used to identify calls should go to this origin), so we don't need to add it.  
    origin_id                = "api-dfds-cloud"
    http_port                = 80
    https_port               = 443
    origin_keepalive_timeout = 5
    origin_read_timeout      = 30
    origin_protocol_policy   = "https-only"
    origin_ssl_protocols     = ["TLSv1.2", "TLSv1.1"]
  }  
]

cloudfront_dynamic_default_cache_behavior = [
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

cloudfront_dynamic_ordered_cache_behavior = [
  { // Behavior for email validation service, example of sending trafic to a different origin, is automatically ranked higher than "default_cache_behavior"
    path_pattern           = "/services-email-validation-api/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "api-dfds-cloud"
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
    path_pattern           = "/services-email-validation-api"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "api-dfds-cloud"
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

s3bucket_enable_destroy = false
s3bucket_enable_retention_policy = true

s3bucket_retention_days = 180
s3bucket_bucket_canned_acl = "log-delivery-write"
