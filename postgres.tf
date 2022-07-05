resource "google_sql_user" "postgres_root_user" {
  count      = var.postgres_enabled ? 1 : 0

  instance = google_sql_database_instance.postgres.0.name

  name     = "root"
  password = random_password.postgres_root_user_pass.0.result

  depends_on = [google_sql_database_instance.postgres]
}

resource "google_sql_database_instance" "postgres" {
  count      = var.postgres_enabled ? 1 : 0

  name             = "${var.postgres_instance_name}-postgres-${random_string.postgres_db_name.0.result}"
  database_version = var.postgres_database_version
  deletion_protection = var.postgres_deletion_protection

  settings {
    tier = var.postgres_machine_type
    disk_size = var.postgres_disk_size
    availability_type = var.postgres_availability_type

    ip_configuration {
      dynamic "authorized_networks" {
        for_each = var.postgres_authorized_networks

        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
      ipv4_enabled = var.postgres_ip_configuration_ipv4_enabled
      private_network = var.postgres_private_network
    }

    backup_configuration  {
      enabled = true
      start_time = "02:39"
    }

    dynamic "database_flags" {
      for_each = var.postgres_database_flags
      content {
        name = database_flags.value.name
        value = database_flags.value.value
      }
    }

    insights_config {
      query_insights_enabled = var.postgres_query_insights_enabled
      query_string_length = var.postgres_query_string_length
      record_application_tags = var.postgres_record_application_tags
      record_client_address = var.postgres_record_client_address
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