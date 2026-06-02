resource "datadog_monitor" "Network_check" {
  name                = "Network check"
  type                = "service check"
  query               = <<EOT
"http.can_connect".over("*").by("*").last(2).count_by_status()
EOT
  message             = "Test"
  draft_status        = "published"
  include_tags        = false
  on_missing_data     = "show_and_notify_no_data"
  require_full_window = false
  monitor_thresholds {
    critical = 1
    ok       = 1
    warning  = 1
  }
}