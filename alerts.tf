resource "google_monitoring_alert_policy" "sql_events" {
  count = var.enable_sql_alerts ? 1 : 0

  display_name = "SQL Alert"

  combiner              = "OR"
  notification_channels = var.sql_alerts_type == "slack" ? [google_monitoring_notification_channel.sql_slack_channel[0].name] : google_monitoring_notification_channel.sql_email_channel[*].id

  conditions {
    display_name = "SQL, instance reached ${var.sql_disk_events_threshold_value} DISK usage"
    condition_threshold {
      filter          = <<EOT
metric.type="cloudsql.googleapis.com/database/disk/utilization" AND
resource.type="cloudsql_database"
EOT
      duration        = var.sql_disk_events_alert_policy_threshold_duration
      threshold_value = var.sql_disk_events_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_MAX"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["project", "resource.label.database_id"]
      }
    }
  }
  conditions {
    display_name = "SQL, instance reached ${var.sql_cpu_events_threshold_value} CPU usage"
    condition_threshold {
      filter          = <<EOT
metric.type="cloudsql.googleapis.com/database/cpu/utilization" AND
resource.type="cloudsql_database"
EOT
      duration        = var.sql_cpu_events_alert_policy_threshold_duration
      threshold_value = var.sql_cpu_events_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_MAX"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["project", "resource.label.database_id"]
      }
    }
  }
  conditions {
    display_name = "SQL, instance reached ${var.sql_memory_events_threshold_value} MEMORY usage"
    condition_threshold {
      filter          = <<EOT
metric.type="cloudsql.googleapis.com/database/memory/utilization" AND
resource.type="cloudsql_database"
EOT
      duration        = var.sql_memory_events_alert_policy_threshold_duration
      threshold_value = var.sql_memory_events_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_MAX"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["project", "resource.label.database_id"]
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_monitoring_notification_channel" "sql_slack_channel" {
  count = var.enable_sql_alerts && var.sql_alerts_type == "slack" ? 1 : 0

  display_name = "SQL Slack Alert"
  type         = "slack"
  labels = {
    channel_name = var.sql_alerts_slack_channel_name
  }

  sensitive_labels {
    auth_token = var.slack_auth_token
  }
}

resource "google_monitoring_notification_channel" "sql_email_channel" {
  count = var.enable_sql_alerts && var.sql_alerts_type == "email" ? length(var.sql_alerts_email_address) : 0

  display_name = "SQL Email Alert for ${element(var.sql_alerts_email_address, count.index)}"
  type         = "email"

  labels = {
    email_address = element(var.sql_alerts_email_address, count.index)
  }
}
