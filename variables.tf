# Global variables.tf

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default     = "narrativai"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "europe-west1"
}

variable "runtime" {
  description = "The runtime for the Cloud Functions"
  type        = string
  default     = "python311"
}

variable "repo_name" {
  description = "The name of the GitHub repository"
  type        = string
  default     = "narrativai/narrativai-backend"
}

variable "repo_owner" {
  description = "The owner of the GitHub repository"
  type        = string
  default     = "alex-narrativai"
}
