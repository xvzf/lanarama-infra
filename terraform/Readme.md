# Automatic provisioning of VMs using terraform (0.11.x)
> **ATTENTION** Everything relies on [this plugin]( https://github.com/dmacvicar/terraform-provider-libvirt#installing). Make sure it is installed!

> *INFO* After there is a stable release of `oterraform-provider-libvirt` is available for `terraform == 0.12.x`, this will be upgraded!

### Gotchas
There is currently a bug in terraform which prevents image resizing on a lvm storage pool. Be sure the default pool is large enough for these operations! VMs are packed onto the lvm nevertheless.


Command pipeline:
```
terraform init  # Just run one time so the plugin is initialized
terraform plan
terraform apply

terraform destroy  # In case you want to teardown everything
```

# Available image types:
- debian10_openstack_base_10G
- debian10_openstack_base_25G
- debian10_openstack_base_50G
- debian10_openstack_base_100G
- debian10_openstack_base_200G
- debian10_openstack_base_300G


# Lanarama Infrastructure
- `coredns` -> VM which inhabits the DNS Server (Coredns)
- `kea_dhcp` -> VM which inhabits the DHCP Server (Kea)
- `infra_monitoring` -> VM which inhabits the infrastructure monitoring services (prometheus + grafana)
