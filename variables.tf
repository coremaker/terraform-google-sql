variable "private_network" {
  type    = string
  default = ""
}

variable "ip_configuration_ipv4_enabled" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "instance_name" {
  type    = string
  default = "dev"
}

variable "machine_type" {
  type    = string
  default = "db-f1-micro"
}

variable "availability_type" {
  type    = string
  default = "ZONAL"
}

variable "backup_configuration_enabled" {
  type    = bool
  default = true
}

variable "backup_configuration_binary_log_enabled" {
  type    = bool
  default = false # Only for MYSQL
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "database_version" {
  type    = string
  default = "POSTGRES_11" # database version ex: MYSQL_5_7
}

variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "authorized_networks" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "query_insights_enabled" {
  type    = bool
  default = false
}

variable "query_string_length" {
  type    = number
  default = 1024
}

variable "record_application_tags" {
  type    = bool
  default = false
}

variable "record_client_address" {
  type    = bool
  default = false
}

variable "random_password_special_chars" {
  type    = bool
  default = true
}

# GCP SQL alerts
variable "enable_sql_alerts" {
  type    = bool
  default = true
}

variable "slack_auth_token" {
  type    = string
  default = "token" # Needs to be replaced with a working token
}

# slack or email supported only
variable "sql_alerts_type" {
  type    = string
  default = "slack"
}

variable "sql_alerts_email_address" {
  type    = list(string)
  default = ["address@example.com"]
}

variable "sql_alerts_slack_channel_name" {
  type    = string
  default = "sql-alerts"
}

variable "sql_disk_events_threshold_value" {
  type    = number
  default = 0.75
}

variable "sql_disk_events_alert_policy_threshold_duration" {
  type    = string
  default = "900s"
}

variable "sql_cpu_events_threshold_value" {
  type    = number
  default = 0.75
}

variable "sql_cpu_events_alert_policy_threshold_duration" {
  type    = string
  default = "900s"
}

variable "sql_memory_events_threshold_value" {
  type    = number
  default = 0.75
}

variable "sql_memory_events_alert_policy_threshold_duration" {
  type    = string
  default = "900s"
}

# read replica
variable "create_read_replica" {
  type  = bool
  default = false
}

variable "master_instance_name" {
  type = string
  default = ""
}

variable "replica_failover_target" {
  type = bool
  default = false
}