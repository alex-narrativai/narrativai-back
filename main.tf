# Provider Configuration
provider "google" {
  credentials = file("/workspaces/auth-sec-service/narrativai-d06f1939f299.json")
  project     = "narrativai"
  region      = "europe-west1"
}

# Terraform Backend for State Management
terraform {
  backend "gcs" {
    bucket  = "narrativai-terraform-state"
    prefix  = "terraform/state"
  }
}

# Google Cloud Function for Transcript Processing
module "transcript_processing" {
  source      = "./modules/transcript_processing"
  name        = "narrativai-transcript-processing"
  runtime     = "python311"
  entry_point = "process_transcript"
}

# Google Cloud Function for GPT-4 Interaction
module "gpt4_interaction" {
  source      = "./modules/gpt4_interaction"
  name        = "narrativai-gpt4-interaction"
  runtime     = "python311"
  entry_point = "interact_with_gpt4"
}

# Google Cloud Function for Neo4j CRUD API
module "neo4j_crud_api" {
  source      = "./modules/neo4j_crud_api"
  name        = "narrativai-neo4j-crud-api"
  runtime     = "python311"
  entry_point = "crud_api"
}

# Auth0 Configuration (Assuming you have a separate module for Auth0)
module "auth0" {
  source = "./modules/auth0"
}

# Google Cloud Monitoring Configuration
module "monitoring" {
  source = "./modules/monitoring"
  project_id = "narrativai"
}

# Google Cloud Memorystore (Redis) Configuration
module "memorystore" {
  source     = "./modules/memorystore"
  name       = "narrativai-memorystore"
  region     = "europe-west1"
  tier       = "STANDARD_HA" # High Availability
  capacity   = 1 # 1 GB
}

# GitHub Actions Configuration
module "github_actions" {
  source      = "./modules/github_actions"
  project_id  = "narrativai"
  repo_name   = "narrativai/narrativai-backend"
  repo_owner  = "alex-narrativai"
}