resource "vault_mount" "pki-int" {
  path        = var.pki_mount
  type        = "pki"
  description = "PKI Intermediate CA"

  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_intermediate_cert_request" "pki-int" {
  backend = vault_mount.pki-int.path
  type = "internal"
  common_name = "${var.domain} Intermediate CA"
}
