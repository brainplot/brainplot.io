terraform {
  cloud {
    organization = "brainplot"

    workspaces {
      name = "brainplot-io"
    }
  }
}
