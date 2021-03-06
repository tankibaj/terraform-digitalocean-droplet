locals {
  host_name = "droplet"
  user_name = "naim"
}

resource "random_pet" "name" {}

data "digitalocean_ssh_key" "personal" {
  name = "thenaim"
}

resource "digitalocean_droplet" "this" {
  image     = "ubuntu-20-04-x64"
  name      = random_pet.name.id
  region    = "fra1"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [data.digitalocean_ssh_key.personal.id]
  user_data = templatefile("${path.module}/user-data.yaml", { HOST_NAME = local.host_name, USERNAME = local.user_name })
}