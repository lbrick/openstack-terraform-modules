[all:vars]
vm_private_key_file=${vm_private_key_file}
%{~ for fips in floating_ips }
    %{~ for instance in instances ~}
        %{~ if fips.instance_id == instance.id ~}
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q cloud-user@${fips.floating_ip}"'
        %{~ endif ~}
%{~ endfor ~}
%{ endfor ~}

[all]
%{ for instance in instances ~}
    %{~ for fips in floating_ips ~}
        %{~ if fips.instance_id == instance.id ~}
${split(".", instance.name)[0]} ansible_host=${instance.access_ip_v4} node_fqdn=${ instance.name } external_ip=${fips.floating_ip}
        %{~ endif ~}
    %{~ endfor ~}
%{ endfor ~}
%{ for fips in floating_ips ~}
    %{~ for instance in instances ~}
        %{~ if fips.instance_id != instance.id ~}
${split(".", instance.name)[0]} ansible_host=${instance.access_ip_v4} node_fqdn=${ instance.name }
        %{~ endif ~}
    %{~ endfor ~}
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