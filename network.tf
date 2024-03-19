resource "scaleway_vpc" "vpc" {
  name       = var.kubecon2024_core.env_name
  tags       = var.tags
}

resource "scaleway_vpc_private_network" "pn" {
  vpc_id     = scaleway_vpc.vpc.id
  name       = "${var.kubecon2024_core.env_name}-pn"
  tags       = var.tags

  ipv4_subnet {
    subnet = var.kubecon2024_network.network_private_cidr
  }
  // Add ipv6 subnet
}

// Reserve an IP for the Public Gateway
resource "scaleway_vpc_public_gateway_ip" "gw_ip" {
  tags       = var.tags
}

// Create the Public Gateway
resource "scaleway_vpc_public_gateway" "pgw" {
  name            = "${var.kubecon2024_core.env_name}-pgw"
  type            = var.kubecon2024_network.network_pgw_type
  bastion_enabled = var.kubecon2024_network.network_pgw_enable_bastion
  ip_id           = scaleway_vpc_public_gateway_ip.gw_ip.id
  tags            = var.tags
}

// Attach Public Gateway, Private Network and DHCP config together
resource "scaleway_vpc_gateway_network" "vpc" {
  gateway_id         = scaleway_vpc_public_gateway.pgw.id
  private_network_id = scaleway_vpc_private_network.pn.id
  cleanup_dhcp       = true
  enable_masquerade  = true
  ipam_config {
    push_default_route = true
  }
}
