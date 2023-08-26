output "url" {
  value = google_cloudfunctions_function.neo4j_crud_api.https_trigger_url
}
