variable "name" {
  description = "The name of the GPT-4 Interaction Cloud Function"
  type        = string
}

variable "runtime" {
  description = "The runtime for the Cloud Function"
  type        = string
  default     = "python311"
}
