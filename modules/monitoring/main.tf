resource "google_monitoring_alert_policy" "narrativai" {
  project = var.project_id
  combiner = "OR"

  display_name = "High CPU Usage Policy"
  documentation {
    content = "High CPU usage policy."
  }

  conditions {
    display_name = "High CPU usage"
    condition_threshold {
      filter      = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
      duration    = "60s"
      comparison  = "COMPARISON_GT"
      threshold_value = 0.8
      trigger {
        count = 1
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]
}

resource "google_monitoring_notification_channel" "email" {
  project = var.project_id

  type = "email"
  display_name = "Email Notification Channel"
  labels = {
    email_address = "alex@narrativai.com"
  }
}
