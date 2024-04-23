# Generate ansible hosts
locals {
  host_ini_all = templatefile("${path.module}/all-hosts.tpl", {
    instance_floating_ip = openstack_networking_floatingip_v2.host_floating_ip.address,
    instance_hostname = var.instance_name
    vm_private_key_file = var.key_file
  })
}

# Generate ansible host.ini file
locals {
  host_ini_content = templatefile("${path.module}/host.ini.tpl", {
    instance_floating_ip = openstack_networking_floatingip_v2.host_floating_ip.address,
    instance_hostname = var.instance_name
    vm_private_key_file = var.key_file
  })
}

resource "local_file" "host_ini" {
  filename = "../host.ini"
  content  = "${local.host_ini_all}\n${local.host_ini_content}"
  file_permission = "0644"
}
