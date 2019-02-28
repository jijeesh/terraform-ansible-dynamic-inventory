# Terraform+Ansible Example


This repository sets up:

* A VPC
* A subnet
* An internet gateway
* A security group
* An SSH key pair
* A publicly-accessible EC2 instance
* Within the instance:
   * Python 2 (for Ansible)
   * Nginx

   ## Setup

   1. Install the following locally:
       * [Terraform](https://www.terraform.io/) >= 0.10.0
       * [Terraform Inventory](https://github.com/adammck/terraform-inventory)
       * Python (see [requirements](https://docs.ansible.com/ansible/latest/intro_installation.html#control-machine-requirements))
       * [pip](https://pip.pypa.io/en/stable/installing/)
   1. Set up AWS credentials in [`~/.aws/credentials`](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files).
       * The easiest way to do so is by [setting up the AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html).
   1. Ensure you have an SSH public key at `~/.ssh/id_rsa.pub`.
       * [How to generate](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)



Install:

1. [Go](https://golang.org/doc/install)

Once installed, create a workspace, configure the GOPATH and add the workspace's bin folder to your system path:
```
$ mkdir $HOME/go
$ export GOPATH=$HOME/go
$ export PATH=$PATH:$GOPATH/bin
```
Next, install terraform-inventory

```
$ go get -u github.com/jijeesh/terraform-inventory
```

##Generating a new SSH key
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Usage
```
./deploy.sh
```


[More information about the AWS environment variables](https://www.terraform.io/docs/providers/aws/#environment-variables). If it is successful, you should see an `address` printed out at the end. Visit this in your browser, and the page should say "Welcome to nginx!"

### Notes

* `./deploy.sh` is [idempotent](http://stackoverflow.com/questions/1077412/what-is-an-idempotent-operation).
* [Information](https://www.terraform.io/intro/getting-started/variables.html#assigning-variables) about overriding [the Terraform variables](terraform/vars.tf).

## Cleanup

```sh
cd terraform
terraform destroy
```
