resource "random_string" "mysql_db_name" {
  count      = var.mysql_enabled ? 1 : 0

  length = 4
  special = false
  upper = false

  lifecycle {
    ignore_changes = all
  }
}

resource "random_password" "mysql_root_user_pass" {
  count      = var.mysql_enabled ? 1 : 0

  length = 24
  special = var.mysql_random_password_special_chars

  lifecycle {
    ignore_changes = all
  }
}

resource "random_string" "postgres_db_name" {
  count      = var.postgres_enabled ? 1 : 0

  length = 4
  special = false
  upper = false

  lifecycle {
    ignore_changes = all
  }
}

resource "random_password" "postgres_root_user_pass" {
  count      = var.postgres_enabled ? 1 : 0

  length = 24
  special = var.postgres_random_password_special_chars

  lifecycle {
    ignore_changes = all
  }
}
