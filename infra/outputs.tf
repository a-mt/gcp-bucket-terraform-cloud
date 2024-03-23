# https://cloud.google.com/storage/docs/collaboration#browser
output "gcp_index_url" {
  value       = "http://storage.googleapis.com/${google_storage_bucket.website.name}/${google_storage_bucket_object.static_site_index.name}"
  description = "Public URL to view index.html"
}
output "gcp_index_download_link" {
  value       = google_storage_bucket_object.static_site_index.media_link
  description = "Public URL to download index.html"
}