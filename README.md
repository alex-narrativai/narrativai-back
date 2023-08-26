# Narrativai Backend

Welcome to the Narrativai Backend repository! This README serves as a comprehensive guide to help you understand the architecture, components, and services that make up the backend of the Narrativai application.

## Table of Contents

- [Overview](#overview)
- [Serverless Components](#serverless-components)
  - [Transcript Processing Service](#transcript-processing-service)
  - [GPT-4 Interaction Service](#gpt-4-interaction-service)
  - [Database Interaction Service](#database-interaction-service)
  - [Authentication and Security Service](#authentication-and-security-service)
- [Tooling and Infrastructure](#tooling-and-infrastructure)
- [Terraform Structure](#terraform-structure)
- [Directory Structure](#directory-structure)
- [Sample Terraform Code](#sample-terraform-code)
- [Best Practices](#best-practices)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [Contact](#contact)

---

# Overview

The Narrativai backend is designed to be a cloud-native, serverless application. It's built using Python 3.11 and is orchestrated via Terraform on Google Cloud Platform (GCP).

---

# Serverless Components

## Transcript Processing Service

### Description

Receives and processes raw text transcripts using Python and FastAPI. Performs tasks like text normalization, entity recognition, and data transformation.

### Type

HTTP-triggered Google Cloud Function

#### Runtime

Python 3.11

### Additional Information

- **Trigger**: Upon receiving raw text transcripts
- **Endpoint**: `/process`
- **HTTP Method**: POST

---

### GPT-4 Interaction Service

### Description

Interacts with the GPT-4 model for further text processing. Takes processed text from the Transcript Processing Service, sends it to GPT-4, and receives the response.

### Type

HTTP-triggered Google Cloud Function

### Runtime

Python 3.11

### Additional Information

- **Trigger**: After the transcript has been processed
- **Endpoint**: `/summ`
- **HTTP Method**: POST

---

### Database Interaction Service

### Description

Manages interactions with the Neo4j AuraDB. Stores processed data from the GPT-4 Interaction Service and serves it to the frontend.

### Type

HTTP-triggered Google Cloud Function

### Runtime

Python 3.11

### Additional Information

- **Database**: Neo4j AuraDB
- **Endpoint**: `/db`
- **HTTP Methods**: GET, POST, PUT, DELETE

---

## Authentication and Security Service

### Description

Handles all authentication and security aspects of the application. Provided by Auth0 Free Tier.

### Vendor Service (Auth0)

### Additional Information

- **Auth0 Domain**: `narrativai.auth0.com`
- **Supported Methods**: OAuth2, JWT

---

## Tooling and Infrastructure

- **Containerization**: Not needed for serverless components
- **Orchestration**: Managed by GCP
- **CI/CD**: GitHub Actions
- **Monitoring**: Google Cloud Monitoring
- **Caching**: Google Cloud Memorystore (Redis)
- **Load Balancing**: Managed by GCP

---

## Terraform Structure

- **Backend Services**: Separate Terraform modules for each serverless function and other services
- **Tooling and Infrastructure**: Terraform modules for GitHub Actions setup, Monitoring, and Memorystore
- **Variables and Outputs**: Terraform variables for configurable settings and outputs for service endpoints

---

## Directory Structure

```plaintext
.
├── main.tf
├── variables.tf
├── outputs.tf
├── .gitignore
├── LICENSE
├── README.md
├── .devcontainer
└── modules
    ├── transcript_processing
    ├── gpt4_interaction
    ├── database_interaction
    ├── auth0
    ├── github_actions
    ├── monitoring
    └── memorystore
    └── neo4j_crud_api
```
---

## Best Practices

1. **Infrastructure as Code**: Use Terraform for all cloud resources
2. **State Management**: Use Google Cloud Storage as a backend for Terraform state
3. **Modularization**: Keep Terraform code modular for each service
4. **Continuous Deployment**: Use GitHub Actions for CI/CD
5. **Monitoring and Logging**: Integrate Google Cloud Monitoring for real-time metrics

---

## Getting Started

Please refer to the `GettingStarted.md` guide for instructions on setting up your development environment and deploying the services.

---

## Contributing

For contributing guidelines, please see the `CONTRIBUTING.md` file.

---

## Contact

For any questions or clarifications, feel free to reach out to the team.

---

We hope this README provides you with all the information you need to get started with the Narrativai backend. Welcome to the team, and happy coding!

---