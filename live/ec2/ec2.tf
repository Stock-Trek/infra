resource "aws_instance" "instance" {
  ami                  = data.aws_ssm_parameter.amazon-linux-2023.value
  instance_type        = var.instance-type
  iam_instance_profile = aws_iam_instance_profile.instance.name
  user_data = templatefile("${path.module}/user-data.tftpl", {
    registry       = local.registry
    repository-url = var.image.repository-url
    image-tag      = var.image.image-tag
    port           = var.port
  })
  tags = merge(var.tags, { Name = var.name })
  depends_on = [
    aws_iam_role_policy_attachment.pull-image,
    aws_iam_role_policy_attachment.write-logs,
  ]
}
