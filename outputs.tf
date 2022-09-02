output "instance_name" {
  value = google_sql_database_instance.main.name
}

output "connection_name" {
  value     = google_sql_database_instance.main.connection_name
  sensitive = true
}

output "service_account_email" {
  value     = google_sql_database_instance.main.service_account_email_address
  sensitive = true
}

output "private_ip_address" {
  value     = google_sql_database_instance.main.private_ip_address
  sensitive = true
}

output "public_ip_address" {
  value     = google_sql_database_instance.main.public_ip_address
  sensitive = true
}

output "root_password" {
  value     = var.create_read_replica ? "" : google_sql_user.root_user.0.password
  sensitive = true
}
