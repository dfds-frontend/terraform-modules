terraform {
  required_version = "~> 0.12.2"
}

locals {
  # Determine the certificate type
  is_acm_cert = var.acm_certificate_arn != null
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  wait_for_deployment = "${var.wait_for_deployment}"
  price_class = "${var.price_class}"  
  aliases = "${var.aliases}"
  viewer_certificate {
    cloudfront_default_certificate = local.is_acm_cert ? false : true
    acm_certificate_arn = local.is_acm_cert ? var.acm_certificate_arn : null
    ssl_support_method = local.is_acm_cert ? "sni-only" : null
    minimum_protocol_version = local.is_acm_cert ? var.custom_ssl_security_policy: null
  }

  http_version        = "http2"      # Supported HTTP Versions
  default_root_object = "index.html" # Default Root Object

  dynamic "logging_config" {
    for_each = "${var.logging_enable ? [1] : [] }"
    content {
      include_cookies = "${var.logging_include_cookies}"
      bucket          = "${var.logging_bucket}"
      prefix          = "${var.logging_prefix}"      
    }
  }

  is_ipv6_enabled = false
  comment         = "${var.comment}"
  enabled         = true

  dynamic "origin" {
    for_each = var.origins
    iterator = it
      content {
        domain_name = it.value.domain_name
        origin_id = it.value.origin_id
        origin_path = lookup(it.value, "origin_path", null)
              
        dynamic "s3_origin_config" {
          for_each = lookup(it.value, "is_s3_origin", false) ? [1] : [] # apply s3 origin settings
          iterator = s3_origin_config
          content {
            origin_access_identity = "${var.origin_access_identity}"
          }          
        }

        dynamic "custom_origin_config" {
          for_each = lookup(it.value, "is_s3_origin", false) ? [] : [1] # apply custom origin settings
          iterator = custom_origin_config
          content {
            http_port              = lookup(it.value, "http_port", 80)
            https_port             = lookup(it.value, "https_port", 443)
            origin_protocol_policy = lookup(it.value, "protocol_policy", "match-viewer")
            origin_ssl_protocols   = lookup(it.value, "ssl_protocols", ["TLSv1.2"]) 
          }
      } 
    }
  }

  default_cache_behavior { 
    allowed_methods  = lookup(var.default_cache_behavior, "allowed_methods", ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]) # This to allow redirect 
    cached_methods   = lookup(var.default_cache_behavior, "cached_methods", ["GET", "HEAD"])
    target_origin_id = var.default_cache_behavior.origin_id
    # Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false). 
    # Enabling this feature will speed up download time but it can increase TTFB which can impact user experience
    compress         = lookup(var.default_cache_behavior, "compress", false)  

    forwarded_values {
      query_string = lookup(var.default_cache_behavior, "forwarded_values_query_string", true)

      cookies {
        forward = lookup(var.default_cache_behavior, "forwarded_values_cookies_forward", "all")
      }
    }

    viewer_protocol_policy = lookup(var.default_cache_behavior, "viewer_protocol_policy", "redirect-to-https")

    # Minimum TTL: The default minimum amount of time (seconds) to cache objects in Cloudfront. Default is 0 seconds
    min_ttl                = lookup(var.default_cache_behavior, "min_ttl", 0)

    # Default TTL: "If the origin does not add a Cache-Control max-age directive to objects, then CloudFront caches objects for the value of the CloudFront default TTL (1 week)"
    default_ttl            = lookup(var.default_cache_behavior, "default_ttl", 604800)

    # Maximum TTL: The maximum amount of time (seconds) to cache objects in Cloudfront. If header value is default as follows; Expires > maximum TTL then CloudFront caches objects for the value of the CloudFront maximum TTL
    max_ttl                = lookup(var.default_cache_behavior, "max_ttl", 31536000)

    dynamic "lambda_function_association"{
      for_each = lookup(var.default_cache_behavior, "lambda_function_association_lambda_arn", null) == null ? [] : [1]
      iterator = it

      content {
        event_type   = "origin-request"
        lambda_arn   = var.default_cache_behavior.lambda_function_association_lambda_arn
        include_body = lookup(var.default_cache_behavior, "lambda_function_association_include_body", false)
      }
    }    
  }

  dynamic "ordered_cache_behavior" {
      for_each = var.cache_behaviors
      iterator = it

      content {
        target_origin_id = it.value.origin_id # origin
        path_pattern = it.value.path_pattern # path
        allowed_methods  = lookup(it.value, "allowed_methods", ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"])
        cached_methods   = lookup(it.value, "cached_methods", ["GET", "HEAD"])

        # Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false). 
        # Enabling this feature will speed up download time but it can increase TTFB which can impact user experience
        compress         = lookup(it.value, "compress", false)  

        forwarded_values {
          query_string = lookup(it.value, "forwarded_values_query_string", true) 

          cookies {
            forward = lookup(it.value, "forwarded_values_cookies_forward", "all")
          }
        }

        viewer_protocol_policy = lookup(it.value, "viewer_protocol_policy", "redirect-to-https")

        # Minimum TTL: The default minimum amount of time (seconds) to cache objects in Cloudfront. Default is 0 seconds
        min_ttl                = lookup(it.value, "min_ttl", 0) 

        # Default TTL: "If the origin does not add a Cache-Control max-age directive to objects, then CloudFront caches objects for the value of the CloudFront default TTL (1 week)"
        default_ttl            = lookup(it.value, "default_ttl", 604800) 

        # Maximum TTL: The maximum amount of time (seconds) to cache objects in Cloudfront. If header value is default as follows; Expires > maximum TTL then CloudFront caches objects for the value of the CloudFront maximum TTL
        max_ttl                = lookup(it.value, "max_ttl", 31536000) 

        dynamic "lambda_function_association"{
          for_each = lookup(it.value, "lambda_function_association_lambda_arn", null) != null ? [1] : []
          iterator = it_sub

          content {
            event_type   = "origin-request"
            lambda_arn   = it.value.lambda_function_association_lambda_arn
            include_body = lookup(it.value, "lambda_function_association_include_body", false)
          }
        }
      } 
    }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  dynamic "custom_error_response" {
    for_each = [for i in "${var.custom_error_responses}" : {
      error_caching_min_ttl = i.error_caching_min_ttl
      error_code            = i.error_code
      response_code         = i.response_code
      response_page_path    = i.response_page_path
    }]

    content {
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
    }
  }  

}