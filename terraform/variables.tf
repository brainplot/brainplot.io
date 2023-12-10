variable "domain" {
  type        = string
  description = "The naked domain name (without dot at the end)"
  validation {
    # https://stackoverflow.com/a/106223/6335279
    condition     = can(regex("^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$", var.domain))
    error_message = "The domain name is not a valid hostname or is not naked."
  }
}

variable "pm_verification" {
  type        = string
  description = "ProtonMail proof-of-ownership record"
}

variable "pm_mx_records" {
  type = map(object({
    priority = number
  }))
}

variable "pm_spf_value" {
  type = string
}

variable "pm_dkim_records" {
  type = map(string)
}
