[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)

# Terraform Google SQL Module

This is a terraform module for GCP SQL which helps you build a sql instance with postgres or mysql and creates a root user.

# Examples

```terraform
module "sql" {
    source = "github.com/coremaker/terraform-google-sql.git?ref=first-commit"

    private_network = google_compute_network.vpc.self_link
    instance_name = "dev"

    slack_auth_token = << token >>
}

resource "google_compute_network" "vpc" {

  name = "vpc"
  auto_create_subnetworks = false
}

resource "kubernetes_secret" "root_user_secret" {
    metadata {
        name = "root"
        namespace = "coremaker"
    }

    data = {
        username = "root"
        password = module.sql.root_password
    }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.31.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.sql_events](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.sql_email_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_monitoring_notification_channel.sql_slack_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project_service.sqladmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.root_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.root_user_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.db_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | n/a | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | n/a | `string` | `"ZONAL"` | no |
| <a name="input_backup_configuration_binary_log_enabled"></a> [backup\_configuration\_binary\_log\_enabled](#input\_backup\_configuration\_binary\_log\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_backup_configuration_enabled"></a> [backup\_configuration\_enabled](#input\_backup\_configuration\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | n/a | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | n/a | `string` | `"POSTGRES_11"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | n/a | `number` | `10` | no |
| <a name="input_enable_sql_alerts"></a> [enable\_sql\_alerts](#input\_enable\_sql\_alerts) | GCP SQL alerts | `bool` | `true` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"dev"` | no |
| <a name="input_ip_configuration_ipv4_enabled"></a> [ip\_configuration\_ipv4\_enabled](#input\_ip\_configuration\_ipv4\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | `"db-f1-micro"` | no |
| <a name="input_master_instance_name"></a> [master\_instance\_name](#input\_master\_instance\_name) | read replica | `string` | `""` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | `string` | `""` | no |
| <a name="input_query_insights_enabled"></a> [query\_insights\_enabled](#input\_query\_insights\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_query_string_length"></a> [query\_string\_length](#input\_query\_string\_length) | n/a | `number` | `1024` | no |
| <a name="input_random_password_special_chars"></a> [random\_password\_special\_chars](#input\_random\_password\_special\_chars) | n/a | `bool` | `true` | no |
| <a name="input_record_application_tags"></a> [record\_application\_tags](#input\_record\_application\_tags) | n/a | `bool` | `false` | no |
| <a name="input_record_client_address"></a> [record\_client\_address](#input\_record\_client\_address) | n/a | `bool` | `false` | no |
| <a name="input_replica_failover_target"></a> [replica\_failover\_target](#input\_replica\_failover\_target) | n/a | `bool` | `false` | no |
| <a name="input_slack_auth_token"></a> [slack\_auth\_token](#input\_slack\_auth\_token) | n/a | `string` | `"token"` | no |
| <a name="input_sql_alerts_email_address"></a> [sql\_alerts\_email\_address](#input\_sql\_alerts\_email\_address) | n/a | `list(string)` | <pre>[<br>  "address@example.com"<br>]</pre> | no |
| <a name="input_sql_alerts_slack_channel_name"></a> [sql\_alerts\_slack\_channel\_name](#input\_sql\_alerts\_slack\_channel\_name) | n/a | `string` | `"sql-alerts"` | no |
| <a name="input_sql_alerts_type"></a> [sql\_alerts\_type](#input\_sql\_alerts\_type) | slack or email supported only | `string` | `"slack"` | no |
| <a name="input_sql_cpu_events_alert_policy_threshold_duration"></a> [sql\_cpu\_events\_alert\_policy\_threshold\_duration](#input\_sql\_cpu\_events\_alert\_policy\_threshold\_duration) | n/a | `string` | `"900s"` | no |
| <a name="input_sql_cpu_events_threshold_value"></a> [sql\_cpu\_events\_threshold\_value](#input\_sql\_cpu\_events\_threshold\_value) | n/a | `number` | `0.75` | no |
| <a name="input_sql_disk_events_alert_policy_threshold_duration"></a> [sql\_disk\_events\_alert\_policy\_threshold\_duration](#input\_sql\_disk\_events\_alert\_policy\_threshold\_duration) | n/a | `string` | `"900s"` | no |
| <a name="input_sql_disk_events_threshold_value"></a> [sql\_disk\_events\_threshold\_value](#input\_sql\_disk\_events\_threshold\_value) | n/a | `number` | `0.75` | no |
| <a name="input_sql_memory_events_alert_policy_threshold_duration"></a> [sql\_memory\_events\_alert\_policy\_threshold\_duration](#input\_sql\_memory\_events\_alert\_policy\_threshold\_duration) | n/a | `string` | `"900s"` | no |
| <a name="input_sql_memory_events_threshold_value"></a> [sql\_memory\_events\_threshold\_value](#input\_sql\_memory\_events\_threshold\_value) | n/a | `number` | `0.75` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | n/a |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | n/a |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | n/a |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | n/a |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
