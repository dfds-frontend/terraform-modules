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

    priority = 40
    rule_id  = aws_waf_rule.mitigate_sqli.id
    type     = "REGULAR"
  }
}

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