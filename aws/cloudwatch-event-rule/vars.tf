variable name_prefix {

}
variable cloudwatch_event_target_id {
    default = null
}
variable cloudwatch_event_target_arn {

}
variable event_input {
    description = "json formatted input"
}

variable event_schedule {
   description = <<TEXT
        Format: rate(<x> <UNIT>)
        Examples:
            rate(5 minutes)
            rate(1 hour)
        For more info: https://docs.aws.amazon.com/lambda/latest/dg/services-cloudwatchevents-expressions.html
   TEXT 
}