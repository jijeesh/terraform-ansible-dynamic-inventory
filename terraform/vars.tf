variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "key_name" {
  default = "terraform-ansible-key"
}

variable "profile" {
  default = "dinesh"
}

variable "region" {
  default = "us-west-2"
}

variable "tags" {
  type = "map"
  default = {
    Repo = "terraform-ansible-example"
    Terraform = true
  }
}
