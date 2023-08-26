# Provider Configuration
provider "google" {
  credentials = file("gcloud-narrativai.json")
  project     = var.project_id
  region      = var.region
}

# Terraform Backend for State Management
terraform {
  backend "gcs" {
    bucket  = "narrativai-terraform-state"
    prefix  = "terraform/state"
  }
}

resource "google_storage_bucket" "bucket" {
  name = var.source_bucket
  location = var.region
}

# Google Cloud Function for Transcript Processing
module "annotate_transcript" {
  source            = "./modules/annotate_transcript"

  project_id      = var.project_id
  region          = var.region
  runtime         = var.runtime
  source_bucket   = var.source_bucket
}


# # Google Cloud Function for GPT-4 Interaction
# module "gpt4_interaction" {
#   source      = "./modules/gpt4_interaction"
#   name        = "narrativai-gpt4-interaction"
#   runtime     = "python311"
#   source_directory =  "${path.module}/function_code"
#   entry_point = "summ"
# }

# # Google Cloud Function for Neo4j CRUD API
# module "neo4j_crud_api" {
#   source      = "./modules/neo4j_crud_api"
#   name        = "narrativai-neo4j-crud-api"
#   runtime     = "python311"
#   entry_point = "db"
# }

# # Auth0 Configuration (Assuming you have a separate module for Auth0)
# module "auth0" {
#   source = "./modules/auth0"
# }

# # Google Cloud Monitoring Configuration
# module "monitoring" {
#   source = "./modules/monitoring"
#   project_id = "narrativai"
# }

# # Google Cloud Memorystore (Redis) Configuration
# module "memorystore" {
#   source     = "./modules/memorystore"
#   name       = "narrativai-memorystore"
#   region     = "europe-west1"
#   tier       = "STANDARD_HA" # High Availability
#   capacity   = 1 # 1 GB
# }

# # GitHub Actions Configuration
# module "github_actions" {
#   source      = "./modules/github_actions"
#   project_id  = "narrativai"
#   repo_name   = "narrativai/narrativai-backend"
#   repo_owner  = "alex-narrativai"
#}