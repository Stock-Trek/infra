resource "aws_iam_role" "instance" {
  name               = "${var.name}-instance"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
  tags               = var.tags
}

resource "aws_iam_policy" "pull-image" {
  name   = "${aws_iam_role.instance.name}-pull-image"
  policy = data.aws_iam_policy_document.pull-image.json
}

resource "aws_iam_role_policy_attachment" "pull-image" {
  role       = aws_iam_role.instance.name
  policy_arn = aws_iam_policy.pull-image.arn
}

resource "aws_iam_policy" "write-logs" {
  name   = "${aws_iam_role.instance.name}-write-logs"
  policy = data.aws_iam_policy_document.write-logs.json
}

resource "aws_iam_role_policy_attachment" "write-logs" {
  role       = aws_iam_role.instance.name
  policy_arn = aws_iam_policy.write-logs.arn
}

resource "aws_iam_instance_profile" "instance" {
  name = var.name
  role = aws_iam_role.instance.name
  tags = var.tags
}
