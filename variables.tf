variable "region" {
  description = "Banglore region"
  type        = string
  default     = "blr" # Banglore
}

variable "os_ids" {
  description = "OS IDs"
  type        = map(number)
  default = {
    "debian" = 477 # Debian 11
  }
}

variable "plans" {
  description = "Vultr Plans"
  type        = map(string)
  default = {
    "vc2_1c_1gb" = "vc2-1c-1gb" # 1 core, 1gb ram
  }
}

variable "api_key" {
  description = "Vultr API Key"
  type        = string
  sensitive   = true
}
