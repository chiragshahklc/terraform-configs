output "public_ip" {
    value = vultr_instance.terraform_instance.main_ip
}