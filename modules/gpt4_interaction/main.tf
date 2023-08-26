variable "project_id" {}
variable "region" {}
variable "runtime" {}
variable "source_bucket" {}


data "archive_file" "source_code" {
  type        = "zip"
  source_file = "${path.module}/function_code/main.py"
  output_path = "${path.module}/function_code/main.zip"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function_code/main.zip"
  bucket = var.source_bucket
  source = data.archive_file.source_code.output_path
}

resource "google_cloudfunctions_function" "gpt4_interaction" {
  name                  = "gpt4-interact-function"
  description = "A function to process transcripts"
  runtime               = var.runtime
  source_archive_bucket = var.source_bucket
  source_archive_object = "function_code/main.zip"
  entry_point           = "gpt4_summary"
  trigger_http          = true
  available_memory_mb   = 128
}

resource "google_cloudfunctions_function_iam_member" "public_access" {
  project        = google_cloudfunctions_function.gpt4_interaction.project
  region         = google_cloudfunctions_function.gpt4_interaction.region
  cloud_function = google_cloudfunctions_function.gpt4_interaction.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

output "url" {
  value = google_cloudfunctions_function.gpt4_interaction.https_trigger_url
}


