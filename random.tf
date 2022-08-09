resource "random_string" "db_name" {
  length  = 4
  special = false
  upper   = false

  lifecycle {
    ignore_changes = all
  }
}

resource "random_password" "root_user_pass" {
  length  = 24
  special = var.random_password_special_chars

  lifecycle {
    ignore_changes = all
  }
}
