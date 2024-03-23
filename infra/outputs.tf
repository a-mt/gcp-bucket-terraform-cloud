output "gcp_index_url" {
  value       = google_storage_bucket_object.static_site_index.media_link
  description = "Public URL to download index.html"
}