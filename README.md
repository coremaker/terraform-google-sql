[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)

# Terraform Google SQL Module

This is a terraform module for GCP SQL which helps you build a sql instance with postgres or mysql and creates a root user.

# Outputs
All outputs are marked as sensitive and will not be shown on terraform plans.

* mysql_instance_name
* mysql_connection_name
* mysql_private_ip_address
* mysql_public_ip_address
* mysql_root_password
* postgres_instance_name
* postgres_connection_name
* postgres_private_ip_address
* postgres_public_ip_address
* postgres_root_password

# Examples

```terraform
module "sql" {
    source = "github.com/coremaker/terraform-google-sql.git?ref=first-commit"

    mysql_private_network = google_compute_network.vpc.self_link
    mysql_instance_name = "dev"
    mysql_enabled = true

    slack_auth_token = << token >>
}

resource "google_compute_network" "vpc" {

  name = "vpc"
  auto_create_subnetworks = false
}

resource "kubernetes_secret" "mysql_root_user_secret" {
    metadata {
        name = "mysql-root"
        namespace = "coremaker"
    }

    data = {
        username = "root"
        password = module.sql.mysql_root_password
    }
}
```