locals {
  # The default username for our AMI
  vm_user = "ec2-user"
}

data "aws_ami" "amazon_linux" {
 most_recent = true
 filter {
   name = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name = "name"
   values = ["amzn-ami-hvm-*-x86_64-gp2"]
 }
}
# Get the latest Ubuntu Xenial AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"
  tags = "${var.tags}"
  ami = "${data.aws_ami.amazon_linux.id}"

  # The name of our SSH keypair
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  subnet_id = "${aws_subnet.default.id}"

provisioner "file" {
    source      = "scripts/cleanup.sh"
    destination = "~/cleanup.sh"
    connection {
      user = "${local.vm_user}"

    }
  }
  provisioner "file" {
      source      = "scripts/crontab"
      destination = "~/crontab"
      connection {
        user = "${local.vm_user}"
      }
    }
  provisioner "remote-exec" {
    inline = [
      "sudo mv ~/cleanup.sh /usr/local/src/cleanup.sh",
      "sudo chmod +x /usr/local/src/cleanup.sh",
      "echo '* * * * * /bin/nice -5 /usr/local/src/cleanup.sh' | sudo crontab -",
      ]
      connection {
        user = "${local.vm_user}"
      }
  }
  #
  # force Terraform to wait until a connection can be made, so that Ansible doesn't fail when trying to provision
  provisioner "remote-exec" {
    # The connection will use the local SSH agent for authentication
    inline = ["echo Successfully connected"]

    # The connection block tells our provisioner how to communicate with the resource (instance)
    connection {
      user = "${local.vm_user}"
    }
  }
}
