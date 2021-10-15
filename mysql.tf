resource "google_sql_user" "mysql_root_user" {
  count      = var.mysql_enabled ? 1 : 0

  instance = google_sql_database_instance.mysql.0.name

  name     = "root"
  password = random_password.mysql_root_user_pass.0.result

  depends_on = [google_sql_database_instance.mysql]
}

resource "google_sql_database_instance" "mysql" {
  count      = var.mysql_enabled ? 1 : 0

  name             = "${var.mysql_instance_name}-mysql-${random_string.mysql_db_name.0.result}"
  database_version = var.mysql_database_version
  deletion_protection = var.mysql_deletion_protection

  settings {
    tier = var.mysql_machine_type
    disk_size = var.mysql_disk_size
    availability_type = var.mysql_availability_type

    ip_configuration {
      ipv4_enabled = var.mysql_ip_configuration_ipv4_enabled
      private_network = var.mysql_private_network
    }

    backup_configuration  {
      enabled = var.mysql_backup_configuration_enabled
      binary_log_enabled = var.mysql_backup_configuration_binary_log_enabled
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
