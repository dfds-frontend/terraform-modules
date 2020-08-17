
resource "kubernetes_deployment" "logshipper" {
  metadata {
    generate_name = "logshipper-${var.env}-"
    labels = {
      name = "logshipper-${var.env}"
    }
    namespace = "${var.namespace}"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "logshipper-${var.env}"
      }
    }

    template {
      metadata {
        labels = {
          name = "logshipper-${var.env}"
        }
        annotations = {
          "iam.amazonaws.com/role" = "${var.s3_access_iam_role_arn}"
        }        
      }

      spec {
        container {
          image = "grafana/logstash-output-loki:1.0.1"
          name  = "logstash"
          
          # TODO: resources as parameters
          resources {
            # requests {
            #   cpu    = "100m"
            #   memory = "50Mi"
            # }
            limits {
              cpu    = "500m"
              memory = "512Mi"
            }
          }

          volume_mount {
            mount_path = "/usr/share/logstash/data"
            name = "logstash-data"
          }
          volume_mount {
            mount_path = "/usr/share/logstash/config"
            name = "config"
          }
          volume_mount {
            mount_path = "/usr/share/logstash/pipeline"
            name = "pipeline"
          }

          env {
            name = "LOG_SOURCE_BUCKET"
            value = "${var.s3_log_source}"
          }
          env {
            name = "LOG_SOURCE_BUCKET_REGION"
            value = "${var.s3_log_source_region}"
          }
          env {
            name = "LAMBDA_LOG_PREFIX"
            value = "${var.lambda_log_prefix}"
          }
          env {
            name = "CLOUDFRONT_LOG_PREFIX"
            value = "${var.cloudfront_log_prefix}"
          }          
          env {
            name = "ENVIRONMENT"
            value = "${var.env}"
          }
          env {
            name = "LOG_SERVER_URL"
            value = "${var.log_server_url}"
          }
          env {
            name = "LOG_SERVER_USERNAME"
            value = "${var.log_server_username}"
          }
          env {
            name = "LOG_SERVER_PASSWORD"
            value = "${var.log_server_password}"
          }
          env {
            name = "DELETE_LAMBDA_LOG_SOURCE_FILES"
            value = false
          }
          env {
            name = "DELETE_CLOUDFRONT_LOG_SOURCE_FILES"
            value = false
          }
        }

        volume {
          name = "config"
          config_map {
            name = "${kubernetes_config_map.logshipper.metadata[0].name}"
            items {
              key = "logstash.yml"
              path = "logstash.yml"
            }
          }
        }
        volume {
          name = "pipeline"
          config_map {
            name =  "${kubernetes_config_map.logshipper.metadata[0].name}"
            items {
              key = "pipeline.conf"
              path = "pipeline.conf"
            }
          }
        }
        volume {
          name = "logstash-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_config_map" "logshipper" {
  metadata {
    generate_name = "logshipper-config-${var.env}-"
    namespace = "${var.namespace}"
  }

  data = {
    "logstash.yml" = templatefile("${path.module}/logstash.yml", { 
          log_level = "${var.enable_debug? "debug" : "info"}"
        })    
    "pipeline.conf" = "${file("${path.module}/pipeline.conf")}"
  }
}

resource "null_resource" "restart-logshipper-pods" {
    triggers = {
        logstash_config_changed = "${sha512(kubernetes_config_map.logshipper.data["logstash.yml"])}"
        pipeline_changed = "${sha512(kubernetes_config_map.logshipper.data["pipeline.conf"])}"
    }
  provisioner "local-exec" {
        command = "kubectl -n ${var.namespace} delete po -l name=logshipper-${var.env}"
        #environment {
         #   KUBECONFIG =  "${pathexpand("~/.kube/config_${var.cluster_name}")}"
        #}
  }
  depends_on = ["kubernetes_config_map.logshipper", "kubernetes_deployment.logshipper"]
}