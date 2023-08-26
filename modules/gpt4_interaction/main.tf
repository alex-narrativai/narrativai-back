resource "google_cloudfunctions_function" "gpt4_interaction" {
  name        = var.name
  description = "Interacts with GPT-4 for text processing."
  runtime     = var.runtime

  available_memory_mb   = 128
  source_archive_bucket = "narrativai-gpt4-interaction-bucket"
  source_archive_object = "source-code.zip"
  trigger_http          = true
  entry_point           = var.entry_point
}
