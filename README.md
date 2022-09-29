# Example: Use the Vault Provider for Terraform to provision and manage a PKI Secrets Engine

This repo provides example of how you can use the [Vault](https://vaultproject.io) [Provider](https://registry.terraform.io/providers/hashicorp/vault/latest/docs) for [Terraform](https://terraform.io) to provision and manage a [PKI secrets engine](https://www.vaultproject.io/docs/secrets/pki).

## Usage

### Set environment variables for your Vault cluster

* `VAULT_ADDR`
* `VAULT_TOKEN`

Your Vault token must have permissions to provision a secret engine and manage the provisioned secret engine.

### Set Terraform variables

* `domain`
* `pki_mount`

### Run Terraform

* `terraform init`

```
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Installing hashicorp/vault v3.8.2...
- Installed hashicorp/vault v3.8.2 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

* `terraform validate`

```
$ terraform validate 
Success! The configuration is valid.
```

* `terraform plan`

```
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_mount.pki-int will be created
  + resource "vault_mount" "pki-int" {
      + accessor                     = (known after apply)
      + audit_non_hmac_request_keys  = (known after apply)
      + audit_non_hmac_response_keys = (known after apply)
      + default_lease_ttl_seconds    = 3600
      + description                  = "PKI Intermediate CA"
      + external_entropy_access      = false
      + id                           = (known after apply)
      + max_lease_ttl_seconds        = 86400
      + path                         = "pki-int"
      + seal_wrap                    = (known after apply)
      + type                         = "pki"
    }

  # vault_pki_secret_backend_intermediate_cert_request.pki-int will be created
  + resource "vault_pki_secret_backend_intermediate_cert_request" "pki-int" {
      + backend            = "pki-int"
      + common_name        = "example.com Intermediate CA"
      + csr                = (known after apply)
      + format             = "pem"
      + id                 = (known after apply)
      + key_bits           = 2048
      + key_type           = "rsa"
      + private_key        = (sensitive value)
      + private_key_format = "der"
      + private_key_type   = (known after apply)
      + type               = "internal"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + csr = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly
these actions if you run "terraform apply" now.
```

* `terraform apply`

```
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_mount.pki-int will be created
  + resource "vault_mount" "pki-int" {
      + accessor                     = (known after apply)
      + audit_non_hmac_request_keys  = (known after apply)
      + audit_non_hmac_response_keys = (known after apply)
      + default_lease_ttl_seconds    = 3600
      + description                  = "PKI Intermediate CA"
      + external_entropy_access      = false
      + id                           = (known after apply)
      + max_lease_ttl_seconds        = 86400
      + path                         = "pki-int"
      + seal_wrap                    = (known after apply)
      + type                         = "pki"
    }

  # vault_pki_secret_backend_intermediate_cert_request.pki-int will be created
  + resource "vault_pki_secret_backend_intermediate_cert_request" "pki-int" {
      + backend            = "pki-int"
      + common_name        = "example.com Intermediate CA"
      + csr                = (known after apply)
      + format             = "pem"
      + id                 = (known after apply)
      + key_bits           = 2048
      + key_type           = "rsa"
      + private_key        = (sensitive value)
      + private_key_format = "der"
      + private_key_type   = (known after apply)
      + type               = "internal"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + csr = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

vault_mount.pki-int: Creating...
vault_mount.pki-int: Creation complete after 0s [id=pki-int]
vault_pki_secret_backend_intermediate_cert_request.pki-int: Creating...
vault_pki_secret_backend_intermediate_cert_request.pki-int: Creation complete after 0s [id=pki-int/intermediate/generate/internal]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

csr = <<EOT
-----BEGIN CERTIFICATE REQUEST-----
MIICazCCAVMCAQAwJjEkMCIGA1UEAxMbZXhhbXBsZS5jb20gSW50ZXJtZWRpYXRl
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxE471cGYdvpmaqTg
QOrAsLRD39inWBZVNgqZYZ5ydzMKTB5a/GD41nany9LPnM1x7dNIVxnr4fFqHKWt
Cw60SfaAj5KnniAm+UCqdWDObAKuAF2w/k92ge+xZg2jEKg6pmqSKz0bFTmiC6W+
oOSrZm0Vcez7NR8DBSgTU1WY9Ux8loOD6BTvROnCjpLMWnnWEZwMYns5PcIzQZu/
1THwL5MF1Fbd50FEyoPNM31DZdvnjYcKsvV3ppkm6mds1LxLrPBDATMx4nXrpKJl
I7NjmWoHv+KsU8OP3aFfpPEcKIe2q7TadkLLxaYSjBtJqbCq4hfxi39gZKvb/DTL
+f4KlwIDAQABoAAwDQYJKoZIhvcNAQELBQADggEBAEGRtfezhHWK3q4UipegRMDd
VonUF2odw6VoFS3irU8G+QtSE4+w+nU9QLanjYO6dkD3FLeTzYJ0JCifDeVZYdAs
PPqwPDh3XfILiZ10g0UneVP3HvD9st1/HjSPyC635TnVUtFPd9bDkJg3sQuFQ+5G
+uYMQVHHePiH/6bR3J7MVxnDTBGyk7Gw9dBhdek3N/IJ0GmTZK4tzlZFIc+q9wpb
2//Blrcx6ybT7R5qWQmYNei1AoYFr3CZBL8Dg0qLPJodDOvikTn8eQe+PGiZhrld
fGreu9iGSvrxbQxL/YUAgawOAgx2uv90OkSP4Cs+Gxhz11CKub8QSiU1PBHRoQU=
-----END CERTIFICATE REQUEST-----
EOT
```

Please note that the Terraform state contains the CSR, which is also provided as an output. It does NOT contain the private key for the CA because it is internal to the CA.
