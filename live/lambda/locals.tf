locals {
  image-count  = (var.package-type == "Image" ? 1 : 0)
  zip-count    = (var.package-type == "Zip" ? 1 : 0)
  public-count = (var.public-access-cors-bare-domain == null ? 0 : 1)
  role-run     = "${var.name}-run"
  package-config = var.package-type == "Image" ? {
    image_uri        = "${var.image.repository-url}:${var.image.image-tag}"
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
