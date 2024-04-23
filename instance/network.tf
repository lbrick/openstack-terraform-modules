data "openstack_networking_network_v2" "project_network" {
  name = var.project_name
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "instance_floating_ip" {
  for_each = { for k, v in var.instances : k => v if v.assign_fip }

  description = "${each.key}"
  pool  = "external"
}

# Assign floating ip
resource "openstack_compute_floatingip_associate_v2" "host_floating_ip_association" {
  for_each = { for k, v in var.instances : k => v if v.assign_fip }

  floating_ip  = openstack_networking_floatingip_v2.instance_floating_ip[each.key].address
  instance_id  = openstack_compute_instance_v2.host[each.key].id
}

resource "openstack_networking_port_v2" "instance" {
  for_each = var.instances
  
  name = "${each.key}"
  network_id = data.openstack_networking_network_v2.project_network.id
  admin_state_up = "true"  
}