variable "yc_iam_token" {
  sensitive = true
}

variable "yc_cloud_id" {
  sensitive = true
}

variable "yc_folder_id" {
  sensitive = true
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "db_user" {
  sensitive = true
}

variable "db_name" {
  sensitive = true
}

variable "db_password" {
  sensitive = true
}

variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}
