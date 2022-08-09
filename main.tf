resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}

resource "google_sql_database_instance" "main" {
  name                = "${var.instance_name}-${random_string.db_name.result}"
  database_version    = var.database_version
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.machine_type
    disk_size         = var.disk_size
    availability_type = var.availability_type

    ip_configuration {
      dynamic "authorized_networks" {
        for_each = var.authorized_networks

        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
      ipv4_enabled    = var.ip_configuration_ipv4_enabled
      private_network = var.private_network
    }

    backup_configuration {
      enabled            = var.backup_configuration_enabled
      binary_log_enabled = var.backup_configuration_binary_log_enabled
      start_time         = "02:39"
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    dynamic "insights_config" {
      for_each = var.query_insights_enabled ? [1] : []
      content {
        query_insights_enabled  = var.query_insights_enabled
        query_string_length     = var.query_string_length
        record_application_tags = var.record_application_tags
        record_client_address   = var.record_client_address
      }
    }
  }

  lifecycle {
    ignore_changes = [
      project,
      region,
      settings.0.disk_size
    ]
  }

  timeouts {
    create = "20m"
  }

  depends_on = [google_project_service.sqladmin]
}


resource "google_sql_user" "root_user" {
  instance = google_sql_database_instance.main.name

  name     = "root"
  password = random_password.root_user_pass.result

  depends_on = [google_sql_database_instance.main]
}
