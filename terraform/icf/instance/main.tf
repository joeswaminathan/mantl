variable "ssh_username" {default = "centos"}
variable "count" {}
variable "role" {}
variable "datacenter" {}
variable "short_name" {default = "mantl"}
variable "catalog" {default = "ff19e470-561a-4fbb-aec0-5ec314b01bd9"}
variable "vdc" {default = "7b181127-3a6b-4d69-a69f-40ac0e724cb4"}
variable "network" {default = "4b77ad16-15eb-4483-9ffe-8df9e497b3e5"}

resource "icf_instance" "instance" {
  count = "${var.count}"
#  role = "${var.role}"
#  short_name = "${var.short_name}"
#  datacenter = "${var.datacenter}"
  vdc = "${var.vdc}"
  catalog = "${var.catalog}"
  network = "${var.network}"

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

