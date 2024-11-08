terraform {
  cloud {
    organization = "brainplot"

    workspaces {
      name = "brainplot-io"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

data "cloudflare_zone" "this" {
  name = var.domain
}

resource "cloudflare_record" "pm_verification" {
  zone_id = data.cloudflare_zone.this.zone_id
  name    = "@"
  type    = "TXT"
  content = "\"${var.pm_verification}\""
}

resource "cloudflare_record" "pm_mx" {
  for_each = var.pm_mx_records

  zone_id  = data.cloudflare_zone.this.zone_id
  name     = "@"
  type     = "MX"
  priority = each.value.priority
  content  = each.key
}

resource "cloudflare_record" "pm_spf" {
  zone_id = data.cloudflare_zone.this.zone_id
  name    = "@"
  type    = "TXT"
  content = "\"${var.pm_spf_value}\""
}

resource "cloudflare_record" "pm_dkim" {
  for_each = var.pm_dkim_records

  zone_id = data.cloudflare_zone.this.zone_id
  name    = each.key
  type    = "CNAME"
  content = each.value
}

resource "cloudflare_record" "dmarc" {
  zone_id = data.cloudflare_zone.this.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "\"v=DMARC1; p=quarantine;\""
}

resource "cloudflare_zone_dnssec" "this" {
  zone_id = data.cloudflare_zone.this.zone_id
}
