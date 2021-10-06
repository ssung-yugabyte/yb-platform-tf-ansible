# yb-platform-tf-ansible

A GCP Terraform module to deploy and manage the Yugabyte data platform(ybdp)

## Pre-requisites

Following IAM roles are required for the Service Account

- Compute Admin
- DNS Administrator
- Service Account Admin
- Service Account User

## Initialization
* Clone this repo to the local workstation

```
$ git clone https://github.com/ssung-yugabyte/yb-plaform-tf-ansible.git
```

* Change directory to the cloned repo

```
$ cd yb-platform-tf-ansible
```

* Create `terraform.tfvars` file with the following info populated (or update `sample.terraform.tfvars` file appropriately and rename it to `terraform.tfvars`)

```
-----------------------------------------------mandatory inputs-----------------------------------------------
# GCP project info
project         = "# gcp project id"
control_name    = "# ybdp control plane name"
credentials     = "# gcp service account credential file path"

# ssh keys to connect to the bastion and replicated instances
ssh_private_key = "# ssh private key file path"
ssh_public_key  = "# ssh public key file path"
ssh_user        = "# ssh user name
```


## Usage

* Run terraform init to initialize the modules dependencies

```
$ terraform init
```

* Generate the terraform plan to understand the changes

```
$ terraform plan -out=plan
```

* Run the following to apply the changes

```
$ terraform apply plan
```

* Run the following the fetch the values from the terraform run

```
$ terraform output <output_variable>
```

* To destroy the provisioned resources,

```
$ terraform destroy
```

## Managed Resources

This terraform-module manages the following GCP resources

- vpc
- subnets
- hosted zone
- compute instances
- firewall
