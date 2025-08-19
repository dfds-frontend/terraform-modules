#
# WAF ACL with each rule defined and prioritized accordingly.
#
resource "aws_waf_web_acl" "waf_acl" {
  name        = var.name_prefix
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

  rules {
    action {
      type = var.rule_blacklist_action
    }

    priority = 40
    rule_id  = aws_waf_rule.waf_blacklist.id
    type     = "REGULAR"
  }

  rules {
    action {
      type = var.rule_whitelist_action
    }

    priority = 50
    rule_id  = aws_waf_rule.waf_whitelist.id
    type     = "REGULAR"
  }

  rules {
    action {
      type = var.rule_reputation_lists_protection_action
    }

    priority = 60
    rule_id  = aws_waf_rule.waf_reputation.id
    type     = "REGULAR"
  }

  tags = var.tags
}


## 1.
## OWASP Top 10 A1
## Mitigate SQL Injection Attacks
## Matches attempted SQL Injection patterns in the URI, QUERY_STRING, BODY, COOKIES

resource "aws_waf_rule" "mitigate_sqli" {
  name        = "${var.name_prefix}-SQL-Injection-Rule"
  metric_name = replace("${var.name_prefix}sqlinjectionrule", "/[^0-9A-Za-z]/", "")

  predicates {
    data_id = aws_waf_sql_injection_match_set.sql_injection_match_set.id
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource "aws_waf_sql_injection_match_set" "sql_injection_match_set" {
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

  rate_key   = "IP"
  rate_limit = var.waf_http_flood_rate_limit # AWS TF Provider BUG: will not change at updates: https://github.com/terraform-providers/terraform-provider-aws/issues/9659
  predicates {
    data_id = aws_waf_ipset.waf_whitelist_set.id
    negated = true
    type    = "IPMatch"
  }
}

###############################################################################
# IP Reputation List
###############################################################################

resource "aws_waf_rule" "waf_reputation" {
  depends_on  = [aws_waf_ipset.waf_reputation_set]
  name        = "${var.name_prefix}-IP-Reputation-Rule"
  metric_name = "${replace(var.name_prefix, "-", "")}IPReputationRule"
  predicates {
    data_id = aws_waf_ipset.waf_reputation_set.id
    negated = false
    type    = "IPMatch"
  }
}


resource "aws_waf_ipset" "waf_reputation_set" {
  name = "reputation-set"

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because they are updated by lambda function
      ip_set_descriptors,
    ]
  }
}

resource "aws_lambda_function" "reputation_lists_parser" {
  function_name = "${var.name_prefix}_reputation_lists_parser"
  description   = "This lambda function checks third-party IP reputation lists hourly for new IP ranges to block. These lists include the Spamhaus Dont Route Or Peer (DROP) and Extended Drop (EDROP) lists, the Proofpoint Emerging Threats IP list, and the Tor exit node list."
  role          = aws_iam_role.lambda_role_reputation_list_parser.arn
  handler       = "reputation-lists-parser.handler"
  filename      = var.reputation_lists_protection_lambda_source
  runtime       = "nodejs12.x"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      SEND_ANONYMOUS_USAGE_DATA = "test"
      UUID                      = random_uuid.uuid.result
      METRIC_NAME_PREFIX        = "test"
      LOG_LEVEL                 = var.log_level
    }
  }
}

resource "random_uuid" "uuid" {
  # keepers = {  #   change = "${timestamp()}"  # }
}


resource "aws_iam_role" "lambda_role_reputation_list_parser" {
  name               = "${var.name_prefix}LambdaRoleReputationListParser"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "reputation_list_parser" {
  name   = "${var.name_prefix}ReputationListParser"
  role   = aws_iam_role.lambda_role_reputation_list_parser.id
  policy = data.aws_iam_policy_document.reputation_list_parser.json
}

data "aws_iam_policy_document" "reputation_list_parser" {
  statement {
    actions = [
      "waf:GetChangeToken",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "waf:GetIPSet",
      "waf:UpdateIPSet",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf::${data.aws_caller_identity.current.account_id}:ipset/${aws_waf_ipset.waf_reputation_set.id}",
    ]
  }

  statement {
    actions = [
      "cloudwatch:GetMetricStatistics",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    # "logs:CreateLogGroup",
    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_cloudwatch_log_group" "loggroup" {
  name              = "/aws/lambda/${var.name_prefix}_reputation_lists_parser"
  retention_in_days = 30
}

resource "aws_lambda_permission" "reputation_lists_parser" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.reputation_lists_parser.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.reputation_lists_parser.arn
}


###################################################################
# Black list
###################################################################

resource "aws_waf_rule" "waf_blacklist" {
  depends_on  = [aws_waf_ipset.waf_blacklist_set]
  name        = "${var.name_prefix} BlackList Rule"
  metric_name = "${replace(var.name_prefix, "-", "")}BlacklistRule"

  predicates {
    data_id = aws_waf_ipset.waf_blacklist_set.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_ipset" "waf_blacklist_set" {
  name = "blacklist-set"
  dynamic "ip_set_descriptors" {
    iterator = ip
    for_each = var.waf_blacklist_ipset

    content {
      type  = ip.value.type
      value = ip.value.value
    }
  }
}

###################################################################
# White list
###################################################################

resource "aws_waf_rule" "waf_whitelist" {
  depends_on  = [aws_waf_ipset.waf_whitelist_set]
  name        = "${var.name_prefix} WhiteList Rule"
  metric_name = "${replace(var.name_prefix, "-", "")}WhiteListRule"

  predicates {
    data_id = aws_waf_ipset.waf_whitelist_set.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_ipset" "waf_whitelist_set" {
  name = "whitelist-set"
  dynamic "ip_set_descriptors" {
    iterator = ip
    for_each = var.waf_whitelist_ipset

    content {
      type  = ip.value.type
      value = ip.value.value
    }
  }
}





###################################################################
# prerequistes
###################################################################

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "STSAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    effect = "Allow"
  }
}
