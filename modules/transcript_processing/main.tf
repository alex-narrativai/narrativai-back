resource "google_cloudfunctions_function" "transcript_processing" {
  name        = var.name
  description = "Processes raw text transcripts."
  runtime     = var.runtime

  available_memory_mb   = 128
  source_archive_bucket = "narrativai-transcript-processing-bucket"
  source_archive_object = "source-code.zip"
  trigger_http          = true
  entry_point           = var.entry_point
}
