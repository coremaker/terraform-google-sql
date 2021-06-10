# MySQL

utput "mysql_instance_name" {
     value = var.mysql_enabled ? google_sql_database_instance.mysql.0.name : ""
}

output "mysql_connection_name" {
    value = var.mysql_enabled ? google_sql_database_instance.mysql.0.connection_name : ""
    sensitive = true
}

output "mysql_private_ip_address" {
    value = var.mysql_enabled ? google_sql_database_instance.mysql.0.private_ip_address : ""
    sensitive   = true
}

output "mysql_public_ip_address" {
    value = var.mysql_enabled ? google_sql_database_instance.mysql.0.public_ip_address : ""
    sensitive   = true
}

output "mysql_root_password" {
    value = var.mysql_enabled ? google_sql_user.mysql_root_user.0.password : ""
    sensitive = true
}

# Postgres

output "postgres_instance_name" {
     value = var.postgres_enabled ? google_sql_database_instance.postgres.0.name : ""
}

output "postgres_connection_name" {
    value = var.postgres_enabled ? google_sql_database_instance.postgres.0.connection_name : ""
    sensitive = true
}

output "postgres_private_ip_address" {
    value = var.postgres_enabled ? google_sql_database_instance.postgres.0.private_ip_address : ""
    sensitive   = true
}

output "postgres_public_ip_address" {
    value = var.postgres_enabled ? google_sql_database_instance.postgres.0.public_ip_address : ""
    sensitive   = true
}

output "postgres_root_password" {
    value = var.postgres_enabled ? google_sql_user.postgres_root_user.0.password : ""
    sensitive = true
}