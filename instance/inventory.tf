resource "local_file" "hosts" {
  content  = templatefile("${path.module}/inventory.tpl",
                          {
                            "instances": openstack_networking_port_v2.instance,
                            "floating_ips": openstack_networking_floatingip_v2.instance_floating_ip,
                            "ansible_groups": var.ansible_groups,
                            "vm_private_key_file": var.key_file
                          },
                          )
  filename = "../hosts"
}