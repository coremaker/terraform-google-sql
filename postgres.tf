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

    ip_configuration {
      ipv4_enabled = "true"
      private_network = var.postgres_private_network
    }

    backup_configuration  {
      enabled = true
      start_time = "02:39"
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