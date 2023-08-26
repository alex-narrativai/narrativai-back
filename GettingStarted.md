# Getting Started with Narrativai Backend

Welcome to the Narrativai team! This guide will walk you through setting up your development environment and deploying the services for the Narrativai backend.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setting Up Development Environment](#setting-up-development-environment)
- [Google Service Account](#google-service-account)
- [VSCode Dev Container](#vscode-dev-container)
- [Terraform Setup](#terraform-setup)
- [Deploying Services](#deploying-services)
- [Testing](#testing)
- [Monitoring](#monitoring)

---

## Prerequisites

- Install [Visual Studio Code](https://code.visualstudio.com/)
- Install [Docker](https://www.docker.com/products/docker-desktop)

---

## Setting Up Development Environment

1. **Clone the Repository**

    ```bash
    git clone https://github.com/narrativai/narrativai-backend.git
    cd narrativai-backend
    ```

2. **Install Required Extensions in VSCode**

Open the folder in a development container - all configuration is done and extensions and tooling is installed.

---

## Google Service Account

Place the Google Service Account JSON file at the root level of the project. This file is crucial for authenticating your Terraform scripts with Google Cloud Platform.

- **File Location**: `/path/to/narrativai-backend/your-service-account.json`

---

## VSCode Dev Container

We have a `.devcontainer` folder with a `devcontainer.json` file to make it easier to set up a consistent development environment using VSCode Dev Containers.

1. Open the project in VSCode.
2. When prompted to "Reopen in Container," click "Reopen."
3. Wait for the container to build and start.

This will set up a development environment with all the necessary dependencies and configurations.

---

## Terraform Setup

1. **Initialize Terraform**

    ```bash
    terraform init
    ```

2. **Validate Terraform Files**

    ```bash
    terraform validate
    ```

3. **Plan Deployment**

    ```bash
    terraform plan
    ```

4. **Apply Changes**

    ```bash
    terraform apply
    ```

---

## Deploying Services

After running `terraform apply`, your services should be deployed to Google Cloud Platform. You can verify this by checking the outputs for the service endpoints.

---

## Testing

Refer to the `TESTING.md` guide for instructions on how to test the services.

---

## Monitoring

We use Google Cloud Monitoring for real-time metrics. You can access the monitoring dashboard via the Google Cloud Console.

---

Congratulations, you should now have a fully functional development environment and have deployed the Narrativai backend services. If you encounter any issues, feel free to reach out to the team.

Happy coding!