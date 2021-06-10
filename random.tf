resource "random_string" "mysql_db_name" {
  count      = var.mysql_enabled ? 1 : 0

  length = 4
  special = false
  upper = false
}

resource "random_password" "mysql_root_user_pass" {
  count      = var.mysql_enabled ? 1 : 0

  length = 24
  special = true
}