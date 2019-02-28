# Specify the provider and access details
# provider "aws" {
#   version = "~> 1.0"
# }

provider "aws" {
  version = "~> 1.16.0"
  region = "${var.region}"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "${var.profile}"
}
