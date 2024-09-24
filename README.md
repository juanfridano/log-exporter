# Log Exporter

Log Exporter is a Terraform-based tool designed to automate the creation of infrastructure for exporting logs to Google Cloud services and setting up alerting mechanisms.

## Features

- **Google Cloud Integration**: Uses Google Cloud Logging, BigQuery, Storage, and more.
- **Automated Infrastructure Setup**: Configures Pub/Sub, Cloud Functions, and other services.
- **Alerting**: Alerts based on specific log conditions.
  
## Files

- `main.tf`: Defines core infrastructure resources, including Pub/Sub, Cloud Functions, and IAM roles.
- `alerting.tf`: Configures logging and monitoring alert policies.
- `variables.tf`: Variables for setting up the infrastructure.
- `log-exporter-436111.tfvars`: Example file for setting up the variables.
- `run.sh`: Script to manage Terraform operations and Google Cloud authentication.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Google Cloud SDK](https://cloud.google.com/sdk)

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/juanfridano/log-exporter.git
   ```
2. Get terraform provider:
   ```bash
   ./run.sh init
   ```
3. Authenticate and set up Google Cloud:
   ```bash
   ./run.sh auth
   ```
4. Plan infrastructure changes:
   ```bash
   ./run.sh plan
   ```
5. Apply the changes:
   ```bash
   ./run.sh apply
   ```
6. Destroy the infrastructure (when no longer needed):
   ```bash
   ./run.sh destroy
   ```

## Script Overview (`run.sh`)

- **`init`**: Installs necessary terraform dependencies.
- **`auth`**: Authenticates the service account and enables required APIs on Google Cloud.
- **`plan`**: Generates a Terraform plan using the variable file.
- **`show-plan`**: Shows the generated plan file.
- **`apply`**: Deploys the infrastructure as per the plan.
- **`destroy`**: Tears down the infrastructure.

## License

This project is licensed under the MIT License.
