# common cloud init iso (contains user(s) who are allowed to run ansible)
data "template_file" "cloud_init_user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

resource "libvirt_cloudinit_disk" "common" {
  # Change to lvm_default when bugfix is available
  pool      = "default"

  name      = "cloud-init-common.iso"
  user_data = "${data.template_file.cloud_init_user_data.rendered}"
}

# Base Image for Debian 10 provisioning (latest release)
resource "libvirt_volume" "debian10_openstack_base" {
  # Change to lvm_default when bugfix is available
  pool   =  "default"

  name   = "debian10_openstack_base"
  source = "https://cdimage.debian.org/cdimage/openstack/current-10/debian-10-openstack-amd64.qcow2"
}

resource "libvirt_volume" "debian10_openstack_base_10G" {
  # Change to lvm_default when bugfix is available
  pool           = "default"

  name           = "debian10_openstack_base_10G"
  base_volume_id = "${libvirt_volume.debian10_openstack_base.id}"
  size           = 10737418240
}

resource "libvirt_volume" "debian10_openstack_base_25G" {
  # Change to lvm_default when bugfix is available
  pool           = "default"

  name           = "debian10_openstack_base_25G"
  base_volume_id = "${libvirt_volume.debian10_openstack_base.id}"
  size           = 26843545600
}

resource "libvirt_volume" "debian10_openstack_base_50G" {
  # Change to lvm_default when bugfix is available
  pool           = "default"

  name           = "debian10_openstack_base_50G"
  base_volume_id = "${libvirt_volume.debian10_openstack_base.id}"
  size           = 53687091200
}

resource "libvirt_volume" "debian10_openstack_base_100G" {
  # Change to lvm_default when bugfix is available
  pool           = "default"

  name           = "debian10_openstack_base_100G"
  base_volume_id = "${libvirt_volume.debian10_openstack_base.id}"
  size           = 107374182400
}

resource "libvirt_volume" "debian10_openstack_base_200G" {
  # Change to lvm_default when bugfix is available
  pool           = "default"

  name           = "debian10_openstack_base_200G"
  base_volume_id = "${libvirt_volume.debian10_openstack_base.id}"
  size           = 214748364800
}

resource "libvirt_volume" "debian10_openstack_base_300G" {
  # Change to lvm_default when bugfix is available
  pool           = "default"

  name           = "debian10_openstack_base_300G"
  base_volume_id = "${libvirt_volume.debian10_openstack_base.id}"
  size           = 322122547200
}
