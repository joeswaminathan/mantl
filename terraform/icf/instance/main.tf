variable "ssh_username" {default = "centos"}
variable "count" {}
variable "role" {}
variable "datacenter" {}
variable "short_name" {default = "mantl"}
variable "catalog" {}
variable "vdc" {}
variable "network" {}
variable "provider_access" {}

resource "icf_instance" "instance" {
  count = "${var.count}"
#  role = "${var.role}"
#  short_name = "${var.short_name}"
#  datacenter = "${var.datacenter}"
  vdc = "${var.vdc}"
  catalog = "${var.catalog}"
  network = "${var.network}"
  provider_access = "${var.provider_access}"

  tags {
    Name = "${var.short_name}-${var.role}-${format("%02d", count.index+1)}"
    sshUser = "${var.ssh_username}"
    role = "${var.role}"
    dc = "${var.datacenter}"
  }

}

output "icf_ids" {
  value = "${join(\",\", icf_instance.instance.*.id)}"
}

output "icf_ips" {
  value = "${join(\",\", icf_instance.instance.*.public_ip)}"
}

