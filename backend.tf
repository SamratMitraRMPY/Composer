# Partial backend configuration: the bucket and prefix are supplied per
# environment at init time, e.g.
#   terraform init -backend-config=envs/sandbox.gcs.tfbackend
terraform {
  backend "gcs" {}
}
