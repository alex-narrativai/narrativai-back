variable "name" {
  description = "The name of the cloud function"
  type        = string
}

variable "runtime" {
  description = "The runtime for the cloud function"
  type        = string
}

variable "entry_point" {
  description = "The entry point for the cloud function"
  type        = string
}

variable source_directory {
  description = "The source directory for the cloud function"
  type        = string
}
