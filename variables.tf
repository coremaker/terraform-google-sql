# MYSQL
variable "mysql_enabled" {
    type = bool
    default = false # Enable and disable mysql
}

variable "mysql_private_network" {
    default = ""
}

variable "mysql_ip_configuration_ipv4_enabled" {
    type = bool
    default = true
}

variable "mysql_deletion_protection" {
    type = bool
    default = true
}

variable "mysql_instance_name" {
    type = string
    default = "dev"
}

variable "mysql_machine_type" {
    type = string
    default = "db-f1-micro"
}

variable "mysql_availability_type" {
    type = string
    default = "ZONAL"
}

variable "mysql_backup_configuration_enabled" {
    type = bool
    default = true
}

variable "mysql_backup_configuration_binary_log_enabled" {
    type = bool
    default = true
}

variable "mysql_disk_size" {
    type = number
    default = 10
}

variable "mysql_database_version" {
    type = string
    default = "MYSQL_5_7" # Mysql database version
}

variable "mysql_database_flags" {
    type    = list(object({
        name = string
        value = string
    }))
    default = []
}

variable "mysql_random_password_special_chars" {
    type = bool
    default = true
}

# POSTGRES
variable "postgres_enabled" {
    type = bool
    default = false # Enable and disable postgres
}

variable "postgres_ip_configuration_ipv4_enabled" {
    type = bool
    default = true
}

variable "postgres_private_network" {
    default = ""
}

variable "postgres_deletion_protection" {
    type = bool
    default = true
}

variable "postgres_instance_name" {
    type = string
    default = "dev"
}

variable "postgres_machine_type" {
    default = "db-f1-micro"
}

variable "postgres_availability_type" {
    type = string
    default = "ZONAL"
}

variable "postgres_disk_size" {
    default = "10"
}

variable "postgres_database_version" {
    default = "POSTGRES_11" # Postgres version
}

variable "postgres_database_flags" {
    type    = list(object({
        name = string
        value = string
    }))
    default = []
}

variable "postgres_random_password_password_special_chars" {
    type = bool
    default = true
}

# GCP SQL alerts
variable "enable_sql_alerts" {
    type = bool
    default = true
}

variable "slack_auth_token" {
    default = "token" # Needs to be replaced with a working token
}

# slack or email supported only
variable "sql_alerts_type" {
    type = string
    default = "slack"
}

variable "sql_alerts_email_address" {
    type = list(string)
    default = ["address@example.com"]
}

variable "sql_alerts_slack_channel_name" {
    type = string
    default = "sql-alerts"
}

variable "sql_disk_events_threshold_value" {
    type = number
    default = 0.75
}

variable "sql_disk_events_alert_policy_threshold_duration" {
    type = string
    default = "900s"
}

variable "sql_cpu_events_threshold_value" {
    type = number
    default = 0.75
}

variable "sql_cpu_events_alert_policy_threshold_duration" {
    type = string
    default = "900s"
}

variable "sql_memory_events_threshold_value" {
    type = number
    default = 0.75
}

variable "sql_memory_events_alert_policy_threshold_duration" {
    type = string
    default = "900s"
}