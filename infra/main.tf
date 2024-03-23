# Create a bucket
# see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "website" {
  name     = "${var.gcp_project}-static-website" # has to be globally unique
  location = var.gcp_bucket_location
}

# Upload index.html to the bucket
resource "google_storage_bucket_object" "static_site_index" {
  name   = "index.html"        # name in the bucket
  source = "assets/index.html" # local path
  bucket = google_storage_bucket.website.name
}

# Make index.html publicly accessible
resource "google_storage_object_access_control" "public_index_rule" {
  object = google_storage_bucket_object.static_site_index.name
  bucket = google_storage_bucket.website.name
  role   = "READER"
  entity = "allUsers"
}
