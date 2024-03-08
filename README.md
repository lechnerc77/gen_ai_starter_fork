# Setting up a subaccount with the SAP AI Core service deployed

## Overview

This script configures the setup of  the `SAP AI Core` service in a subaccount

## Content of setup

The setup comprises the following resources:

- Creation of a SAP BTP subaccount (optional - if variable `create_subaccount` is set to `true`)
- Entitlement of the SAP AI Core service (optional - if variable `create_subaccount` is set to `true`)
- Creation of a service instance of the SAP AI Core service
- Creation of a service key for the SAP AI Core service instance
- Subscription to the SAP AI Core Launchpad
- Role collection assignments to users for the SAP AI Core Launchpad

## Deploying the resources

To deploy the resources you must:

1. Change the directory into the folder `gen_ai_setup`:

   ```bash
   cd gen_ai_setup
   ```

1. Change the variables in the `terraform.tfvars` file to meet your requirements.

1. Export the variables for user name and password:

   ```bash
   export BTP_USERNAME='<Email address of your BTP user>'
   export BTP_PASSWORD='<Password of your BTP user>'
   ```

   As an alternative, you can also use the devcontainer and store the values of `BTP_USERNAME` and `BTP_PASSWORD` in a `devcontainer.env` file.

1. Initialize your Terraform workspace:

   ```bash
   terraform init
   ```

1. You can check what Terraform plans to apply based on your configuration:

   ```bash
   terraform plan
   ```

1. Apply your configuration to provision the resources:

   ```bash
   terraform apply
   ```

1. The script will create a `.env`, containing the environment variables that you can use later in applications to use the GenAI service.

## CleanUp

To remove the assets e.g., to avoid unnecessary costs, destroy the setup by running the following command in the `gen_ai_setup` directory:

```bash
terraform destroy
```
