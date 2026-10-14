locals {
  image_count  = (var.package_type == "Image" ? 1 : 0)
  zip_count    = (var.package_type == "Zip" ? 1 : 0)
  public_count = (var.public_access_cors_bare_domain == null ? 0 : 1)
  role_run     = "${var.name}-run"
  vpc_count    = (length(var.subnet_ids) > 0 ? 1 : 0)
  package_config = var.package_type == "Image" ? {
    image_uri        = "${var.image.repository_url}:${var.image.image_tag}"
    filename         = null
    handler          = null
    runtime          = null
    source_code_hash = null
    } : {
    image_uri        = null
    filename         = data.archive_file.dummy[0].output_path
    handler          = var.zip.handler
    runtime          = var.zip.runtime
    source_code_hash = data.archive_file.dummy[0].output_base64sha256
  }
}
