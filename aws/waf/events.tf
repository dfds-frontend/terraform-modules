resource "aws_cloudwatch_event_rule" "reputation_lists_parser" {
  name                = "${var.name_prefix}_reputation_lists_parser"
  description         = "Security Automations - WAF Reputation Lists"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "reputation_lists_parser" {
  rule = aws_cloudwatch_event_rule.reputation_lists_parser.name
  arn  = aws_lambda_function.reputation_lists_parser.arn

  input = <<INPUT
{
  "lists": [
    {
      "url": "https://www.spamhaus.org/drop/drop.txt"
    },
    {
      "url": "https://check.torproject.org/exit-addresses",
      "prefix": "ExitAddress"
    },
    {
      "url": "https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt"
    },
    {
      "url": "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/cybercrime.ipset"
    }
  ],
  "apiType": "waf",
  "region": "${data.aws_region.current.name}",
  "ipSetIds": [
    "${aws_waf_ipset.waf_reputation_set.id}" 
  ]
}
INPUT
}