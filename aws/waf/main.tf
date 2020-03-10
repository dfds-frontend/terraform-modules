terraform {
  required_version = "~> 0.12.2"
}

#
# WAF ACL with each rule defined and prioritized accordingly.
#
resource aws_waf_web_acl waf_acl {
  name        = "${var.name_prefix}"
  metric_name = replace("${var.name_prefix}acl", "/[^0-9A-Za-z]/", "")

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = var.rule_sqli_action
    }

    priority = 10
    rule_id  = aws_waf_rule.mitigate_sqli.id
    type     = "REGULAR"
  }
  rules {
    action {
      type = var.rule_xss_action
    }

    priority = 20
    rule_id  = aws_waf_rule.mitigate_xss.id
    type     = "REGULAR"
  }
  rules {
    action {
      type = var.rule_http_flood_action
    }

    priority = 30
    rule_id  = aws_waf_rate_based_rule.mitigate_http_flood.id
    type     = "RATE_BASED"
  } 
}

# TODO: 
## Enable logging
## Add Disable to rule_sqli_action or Default value to null => disabled


## 1.
## OWASP Top 10 A1
## Mitigate SQL Injection Attacks
## Matches attempted SQL Injection patterns in the URI, QUERY_STRING, BODY, COOKIES

resource aws_waf_rule mitigate_sqli {
  name        = "${var.name_prefix}-SQL-Injection-Rule"
  metric_name = replace("${var.name_prefix}sqlinjectionrule", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_sql_injection_match_set.sql_injection_match_set.id
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource aws_waf_sql_injection_match_set sql_injection_match_set {
  name = "${var.name_prefix}-SQL-injection-Detection"

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }
  }
}




## 3.
## OWASP Top 10 A3
## Mitigate Cross Site Scripting Attacks
## Matches attempted XSS patterns in the URI, QUERY_STRING, BODY, COOKIES

resource "aws_waf_rule" "mitigate_xss" {
  name        = "${var.name_prefix}-XSS-Detection-Rule"
  metric_name = replace("${var.name_prefix}xssrule", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_xss_match_set.xss_match_set.id
    negated = false
    type    = "XssMatch"
  }
}

resource "aws_waf_xss_match_set" "xss_match_set" {
  name = "${var.name_prefix}-XSS-Detection"

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "HEADER"
      data = "cookie"
    }
  }
}

// Mitigate DOS, HTTP flood attack
// By default, allow any traffic. Rate limit any given IP that makes more than 100 requests over a 5 minute window
resource "aws_waf_rate_based_rule" "mitigate_http_flood" {
  name        = "${var.name_prefix}-HTTP-Flood-Rule"
  metric_name = replace("${var.name_prefix}httpfloodrulerate", "/[^0-9A-Za-z]/", "")

  rate_key    = "IP"
  rate_limit  = 100
}