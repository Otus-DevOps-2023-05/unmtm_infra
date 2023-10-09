variable "service_account_key_file" {
  description = "account key"
}
variable "count_instance" {
  description = "count instance yandex"
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}
variable "stage" {
  description = "Name Stage"
  default = "prod"
}
