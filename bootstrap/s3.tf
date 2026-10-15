module "bucket_bootstrap" {
  source = "../modules/s3-bucket"

  name                  = "state.${local.bare_domain}"
  replica_name          = "state.${local.bare_domain}-replica"
  replication_role_name = "state.${local.bare_domain}-replication"
  object_ownership      = "BucketOwnerEnforced"
  bucket_key_enabled    = true
  tags                  = {}

  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
}
