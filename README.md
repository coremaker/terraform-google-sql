[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)

# Terraform Google SQL Module

This is a terraform module for GCP SQL which helps you build a sql instance with postgres or mysql and creates a root user.

# Outputs
All outputs are marked as sensitive and will not be shown on terraform plans.

* instance_name
* connection_name
* private_ip_address
* public_ip_address
* root_password

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