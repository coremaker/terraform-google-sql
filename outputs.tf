output "instance_name" {
     value = google_sql_database_instance.main.name
}

output "connection_name" {
    value = google_sql_database_instance.main.connection_name
    sensitive = true
}

output "private_ip_address" {
    value = google_sql_database_instance.main.private_ip_address
    sensitive   = true
}

output "public_ip_address" {
    value = google_sql_database_instance.main.public_ip_address
    sensitive   = true
}

output "root_password" {
    value = google_sql_user.root_user.password
    sensitive = true
}