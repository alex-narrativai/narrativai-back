resource "google_monitoring_alert_policy" "example" {
  project = var.project_id
  # Alert policy configurations
}

resource "google_monitoring_notification_channel" "example" {
  project = var.project_id
  # Notification channel configurations
}
