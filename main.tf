provider "vultr" {
    api_key = var.api_key
}

resource "vultr_ssh_key" "tf_ssh_key" {
  name = "tf_ssh_key"
  ssh_key = file("ssh_key.pub")
}

resource "vultr_vpc" "vpc_net_banglore" {
  region = var.region
  description = "Banglore"
}

resource "vultr_instance" "terraform_instance" {
  region = var.region
  plan = lookup(var.plans, "vc2_1c_1gb")
  os_id =  var.os_ids.debian
  ddos_protection = true
  label = "instance-from-terraform"
  ssh_key_ids = [ vultr_ssh_key.tf_ssh_key.id ]
  vpc_ids = [ vultr_vpc.vpc_net_banglore.id ]
}