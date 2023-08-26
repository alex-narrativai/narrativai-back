variable "region" {
  description = "The GCP region for the Memorystore instance"
  type        = string
  default     = "europe-west2"
}

variable "tier" {
  description = "The tier of the Memorystore instance"
  type        = string
  default     = "STANDARD_HA"
}

variable "capacity" {
  description = "The capacity of the Memorystore instance in GB"
  type        = number
  default     = 1
}

variable "name" {
  description = "The name of the Memorystore instance"
  type        = string
  default     = "narrativai-memorystore"
}