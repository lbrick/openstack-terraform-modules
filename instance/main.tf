terraform {
  required_version = ">= 0.14"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
  }
}

resource "openstack_compute_instance_v2" "host" {
  name        = var.instance_name
  flavor_name = var.flavor_name
  key_pair    = var.key_pair
  security_groups = var.secgroups


  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    volume_size           = var.instance_volume_size
    delete_on_termination = true
  }

  network {
    name = var.project_name
  }
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "host_floating_ip" {
  pool  = "external"
}

# Assign floating ip
resource "openstack_compute_floatingip_associate_v2" "host_floating_ip_association" {
  floating_ip  = openstack_networking_floatingip_v2.host_floating_ip.address
  instance_id  = openstack_compute_instance_v2.host.id
}
