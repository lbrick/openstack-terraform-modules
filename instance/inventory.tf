resource "local_file" "hosts" {
  content  = templatefile("${path.module}/inventory.tpl",
                          {
                            "instances": openstack_compute_instance_v2.host,
                            "floating_ips": openstack_compute_floatingip_associate_v2.host_floating_ip_association,
                            "ansible_groups": var.ansible_groups,
                            "vm_private_key_file": var.key_file
                          },
                          )
  filename = "../hosts"
}