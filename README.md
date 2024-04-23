# openstack-terraform-modules

Instance Module - Generates a single Openstack VM with a floating IP, This will also output a host.ini inventory file to be used with ansible

Example usage

```
module "instance" {
    #source = "github.com/lbrick/openstack-terraform-modules.git//instance/"
    source = "../host"

    project_name = "NeSI-Rebase-Sandbox"

    key_pair = "kahus-key"
    key_file = "~/.ssh/id_flexi"

    instances = {
        server-01: {
            flavor_name: "balanced1.2cpu4ram"
            image_id: var.image_id
            volume_size: 30
            secgroups: ["default","ssh-allow-all"]
            assign_fip: true
        }
        server-02: {
            flavor_name: "balanced1.2cpu4ram"
            image_id: var.image_id
            volume_size: 30
            secgroups: ["default","ssh-allow-all"]
            assign_fip: false
        }
        server-03: {
            flavor_name: "balanced1.2cpu4ram"
            image_id: var.image_id
            volume_size: 30
            secgroups: ["default","ssh-allow-all"]
            assign_fip: false
        }
    }

    ansible_groups = {
        web: "server-01"
        db: "server-02"
        media: "server-03"
    }
}

```