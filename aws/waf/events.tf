resource "aws_cloudwatch_event_rule" "reputation_lists_parser" {
  # count = "${var.reputation_lists_protection_activated ? 1 : 0}"
  name                = "${var.name_prefix}_reputation_lists_parser"
  description         = "Security Automations - WAF Reputation Lists"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "reputation_lists_parser" {
  # count = "${var.reputation_lists_protection_activated ? 1 : 0}"
  rule = aws_cloudwatch_event_rule.reputation_lists_parser.name # aws_cloudwatch_event_rule.reputation_lists_parser[count.index].name
  arn  = "${aws_lambda_function.reputation_lists_parser.arn}" // "${element(concat(aws_lambda_function.reputation_lists_parser.*.arn, [""]), 0)}" 

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