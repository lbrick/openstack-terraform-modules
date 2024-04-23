resource "openstack_compute_instance_v2" "host" {

  for_each = var.instances

  name        = "${each.key}"
  flavor_name = var.instances[each.key].flavor_name
  key_pair    = var.key_pair
  security_groups = var.secgroups


  block_device {
    uuid                  = var.instances[each.key].image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    volume_size           = var.instances[each.key].volume_size
    delete_on_termination = true
  }

  network {
    name = var.project_name
  }
}
