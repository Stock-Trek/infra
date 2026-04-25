data "aws_ecr_authorization_token" "dummy" {}

provider "docker" {
  registry_auth {
    address  = data.aws_ecr_authorization_token.dummy.proxy_endpoint
    username = data.aws_ecr_authorization_token.dummy.user_name
    password = data.aws_ecr_authorization_token.dummy.password
  }
}

resource "docker_image" "dummy" {
  count = local.image-count

  name         = "alpine:latest"
  keep_locally = false

  lifecycle {
    ignore_changes = all
  }
}

resource "docker_tag" "dummy" {
  count = local.image-count

  source_image = docker_image.dummy[0].name
  target_image = local.package-config.image_uri

  lifecycle {
    ignore_changes = all
  }
}

resource "docker_registry_image" "dummy" {
  count = local.image-count

  name = docker_tag.dummy[0].target_image

  lifecycle {
    ignore_changes = all
  }
}
