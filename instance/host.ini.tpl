[servers]
${instance_hostname} ansible_host=${instance_floating_ip} hostname=${instance_hostname}

[servers:vars]
vm_private_key_file=${vm_private_key_file}
ansible_ssh_common_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

