resource "aws_cloudfront_distribution" "cloudfront_distribution" {
    price_class = "PriceClass_100"
    viewer_certificate {
        cloudfront_default_certificate = true
        acm_certificate_arn = null
        ssl_support_method = null
        minimum_protocol_version = null
    }
    http_version        = "http2"      # Supported HTTP Versions
    default_root_object = "index.html" # Default Root Object

    logging_config {
        include_cookies = "${var.logging_include_cookies}"
        bucket          = "${var.logging_bucket}"
        prefix          = "${var.logging_prefix}" 
    }

    is_ipv6_enabled = false         
    comment         = "${var.comment}"
    enabled         = true

    origin {
        domain_name = "${var.default_origin_domain_name}"
        origin_id = "${var.default_origin_id}"
        origin_path = null

        s3_origin_config {
            origin_access_identity = "${var.origin_access_identity}"
        }
    }
  
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["HEAD", "GET"]
        target_origin_id = "${var.default_origin_id}"

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = null
        default_ttl            = null
        max_ttl                = null

        dynamic "lambda_function_association" {
            for_each = length(var.request_lambda_edge_function_arn) == 0 ? [] : [1]
            iterator = it # alias for iterator. Otherwise the name would be of the dynamic blog "lambda_function_association"
            content {
                event_type   = "origin-request"
                lambda_arn   = "${var.request_lambda_edge_function_arn}"
                include_body = "${var.request_lambda_edge_function_include_body}"
            }
        }  
    }
}