# Google Cloud Platform
variable "gcp_credentials" {
  type          = string
  description = "GCP: Credentials (JSON key content without newlines)"
}
variable "gcp_project" {
  type        = string
  description = "GCP: Project name"
}
variable "gcp_region" {
  type        = string
  description = "GCP: Default region to manage resources"
}
variable "gcp_bucket_location" {
  type        = string
  description = "GCP: Location of the bucket"
}
