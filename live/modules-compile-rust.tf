module "bucket-uploads" {
  source = "./s3-bucket"
  name   = local.compile-rust-bucket
  tags   = local.tags
}

module "ecr-algorithm-compiler" {
  source                      = "./ecr-repository"
  name                        = local.algorithm-compiler-ecr-name
  mutability-exclusion-filter = local.algorithm-compiler-ecr-image-tag
  tags                        = local.tags
}
