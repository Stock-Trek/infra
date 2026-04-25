locals {
  image-count  = (var.package-type == "Image" ? 1 : 0)
  zip-count    = (var.package-type == "Zip" ? 1 : 0)
  public-count = (var.public-access-cors-bare-domain == null ? 0 : 1)
  role-run     = "${var.name}-run"
  package-config = var.package-type == "Image" ? {
    image_uri = "${var.image.repository_url}:${var.image.image_tag}"
    image_config = {
      command           = var.image.config.command
      entry_point       = var.image.config.entry_point
      working_directory = var.image.config.working_directory
    }
    filename         = null
    handler          = null
    runtime          = null
    source_code_hash = null
    } : {
    image_uri = null
    image_config = {
      command           = null
      entry_point       = null
      working_directory = null
    }
    filename         = data.archive_file.dummy[0].output_path
    handler          = var.zip.handler
    runtime          = var.zip.runtime
    source_code_hash = data.archive_file.dummy[0].output_base64sha256
  }
}
