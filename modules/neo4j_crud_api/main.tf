resource "google_cloudfunctions_function" "neo4j_crud_api" {
  name        = var.name
  description = "Serverless CRUD API for Neo4j."
  runtime     = var.runtime

  available_memory_mb   = 128
  source_archive_bucket = "narrativai-neo4j-crud-api-bucket"
  source_archive_object = "source-code.zip"
  trigger_http          = true
  entry_point           = var.entry_point
}
