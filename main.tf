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

resource "vultr_startup_script" "install_docker" {
  name = "install_docker"
  script = "IyEvYmluL2Jhc2gKc2V0IC1leApzdWRvIGFwdCB1cGRhdGUKc3VkbyBhcHQgdXBncmFkZQpjdXJsIC1mc1NMIGh0dHBzOi8vZ2V0LmRvY2tlci5jb20gLW8gZ2V0LWRvY2tlci5zaApzdWRvIHNoIGdldC1kb2NrZXIuc2gKdXNlcm5hbWU9ImZ1cnlkcmFnb24iCmFkZHVzZXIgLS1kaXNhYmxlZC1wYXNzd29yZCAtLWdlY29zICIiICR1c2VybmFtZQpzdWRvIHVzZXJtb2QgLWEgLUcgc3VkbyAkdXNlcm5hbWUKc3VkbyB1c2VybW9kIC1hIC1HIGRvY2tlciAkdXNlcm5hbWUKY3AgLVIgIH4vLnNzaCAvaG9tZS8kdXNlcm5hbWUKY2hvd24gLVIgJHVzZXJuYW1lOiR1c2VybmFtZSAvaG9tZS8kdXNlcm5hbWUvLnNzaApwYXNzd2QgLWUgLWQgJHVzZXJuYW1lCg=="
}

resource "vultr_instance" "terraform_instance" {
  region = var.region
  plan = lookup(var.plans, "vc2_1c_1gb")
  os_id =  var.os_ids.debian
  ddos_protection = true
  label = "instance-from-terraform"
  ssh_key_ids = [ vultr_ssh_key.tf_ssh_key.id ]
  vpc_ids = [ vultr_vpc.vpc_net_banglore.id ]
  script_id = vultr_startup_script.install_docker.id
}