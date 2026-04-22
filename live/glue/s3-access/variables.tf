variable "role" {
  description = "Role to attach S3 access to"
  type        = string
}

variable "bucket-arns" {
  description = "Bucket arns to give the role access to"
  type        = list(string)
}
