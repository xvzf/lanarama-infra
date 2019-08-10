# VM for kea dhcp server

# disk image for the vm
resource "libvirt_volume" "vm_kea_dhcp_qcow2" {
  pool           = "default"
  name           = "vm_kea_dhcp_image.qcow2"
  base_volume_id = "${libvirt_volume.debian10_openstack_base_25G.id}"
}

# domain for vm
resource "libvirt_domain" "domain_vm_kea_dhcp" {
  name   = "kea_dhcp"
  memory = "8192"
  vcpu   = 4

  cloudinit = "${libvirt_cloudinit_disk.common.id}"

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "tcp"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = "${libvirt_volume.vm_kea_dhcp_qcow2.id}"
  }
}

output "kea_dhcp_ip" {
  value = "${libvirt_domain.domain_vm_kea_dhcp.network_interface.0.addresses.0}"
}
