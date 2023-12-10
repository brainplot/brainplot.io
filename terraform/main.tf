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
