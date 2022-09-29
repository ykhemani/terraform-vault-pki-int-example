variable "pki_mount" {
  type        = string
  description = "Where the PKI secret backend will be mounted."
}

variable "domain" {
  type = string
  description = "Domain for Intermediate CA."
}

variable "default_lease_ttl_seconds" {
  type        = number
  description = "Default lease duration for tokens and secrets in seconds."
  default     = 3600
}

variable "max_lease_ttl_seconds" {
  type        = number
  description = "Maximum possible lease duration for tokens and secrets in seconds."
  default     = 86400
}
