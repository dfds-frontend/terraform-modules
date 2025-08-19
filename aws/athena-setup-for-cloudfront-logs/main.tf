resource "aws_athena_workgroup" "cflogs" {
  name          = var.athena_workgroup_name
  force_destroy = true

  configuration {
    result_configuration {
      output_location = "s3://${var.athena_output_location}"
      # encryption_configuration {
      #   encryption_option = "SSE_KMS"
      #   kms_key_arn       = aws_kms_key.test.arn
      # }
    }
  }
}

resource "aws_athena_database" "cflogs" {
  name          = var.athena_db_name
  bucket        = var.bucket_query_results
  force_destroy = true
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.athena_table_name
  database_name = aws_athena_database.cflogs.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL                 = "TRUE"
    "skip.header.line.count" = "2"
  }

  storage_descriptor {
    location      = "s3://${var.source_bucket_path}"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "my-serde"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "field.delim" = "\t"
      }
    }

    columns {
      name = "date"
      type = "date"
    }
    columns {
      name = "time"
      type = string
    }
    columns {
      name = "location"
      type = string
    }
    columns {
      name = "bytes"
      type = "bigint"
    }
    columns {
      name = "request_ip"
      type = string
    }
    columns {
      name = "method"
      type = string
    }
    columns {
      name = "host"
      type = string
    }
    columns {
      name = "uri"
      type = string
    }
    columns {
      name = "status"
      type = "int"
    }
    columns {
      name = "referrer"
      type = string
    }
    columns {
      name = "user_agent"
      type = string
    }
    columns {
      name = "query_string"
      type = string
    }
    columns {
      name = "cookie"
      type = string
    }
    columns {
      name = "result_type"
      type = string
    }
    columns {
      name = "request_id"
      type = string
    }
    columns {
      name = "host_header"
      type = string
    }
    columns {
      name = "request_protocol"
      type = string
    }
    columns {
      name = "request_bytes"
      type = "bigint"
    }
    columns {
      name = "time_taken"
      type = "float"
    }
    columns {
      name = "xforwarded_for"
      type = string
    }
    columns {
      name = "ssl_protocol"
      type = string
    }
    columns {
      name = "ssl_cipher"
      type = string
    }
    columns {
      name = "response_result_type"
      type = string
    }
    columns {
      name = "http_version"
      type = string
    }
    columns {
      name = "fle_status"
      type = string
    }
    columns {
      name = "fle_encrypted_fields"
      type = "int"
    }
    columns {
      name = "c_port"
      type = "int"
    }
    columns {
      name = "time_to_first_byte"
      type = "float"
    }
    columns {
      name = "x_edge_detailed_result_type"
      type = string
    }
    columns {
      name = "sc_content_type"
      type = string
    }
    columns {
      name = "sc_content_len"
      type = "bigint"
    }
    columns {
      name = "sc_range_start"
      type = "bigint"
    }
    columns {
      name = "sc_range_end"
      type = "bigint"
    }
  }
}
