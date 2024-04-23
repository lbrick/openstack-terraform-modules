[all:vars]
vm_private_key_file=${vm_private_key_file}
ansible_ssh_common_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

[all]
%{ for instance in instances ~}
${split(".", instance.name)[0]} ansible_host=${instance.all_fixed_ips[0]} node_fqdn=${ instance.name }
%{ endfor ~}

# Define ansible groups
%{~ for type_name, type_descr in ansible_groups}
[${type_name}]
    %{~ for node_name, node_type in instances ~}
        %{~ if type_descr == node_name ~}
${node_name}
        %{~ endif ~}
%{~ endfor ~}
%{ endfor ~}