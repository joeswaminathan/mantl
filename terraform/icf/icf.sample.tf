variable "control_count" { default = 3 }
variable "short_name" {default = "mantl"}
variable "ssh_username" {default = "centos"}
variable "worker_count" { default = 2 }
variable "datacenter" {default = "jswamina-vdc"}
variable "vdc" {default = "5a1c6570-2a5e-46dd-a28d-9719cff6a2b6"}
variable "catalog" {default = "e8fa364b-fed5-46ba-888e-341fd26fcc5d"}
variable "network" {default = "36403b9a-17d5-4684-b773-02ff962b6213"}
variable "provider_access" {default = false}


provider "icf" {
	username = "admin"
	password = "Sfish123"
	icfb = "10.193.75.216"
	vdc = "${var.vdc}"
}	

module "control-nodes" {
  source = "terraform/icf/instance"
  role = "control"
  datacenter = "${var.datacenter}"
  count = "${var.control_count}"
  ssh_username = "${var.ssh_username}"
  short_name = "${var.short_name}"
  vdc = "${var.vdc}"
  catalog = "${var.catalog}"
  network = "${var.network}"
  provider_access = "${var.provider_access}"
}

module "worker-nodes" {
  source = "terraform/icf/instance"
  role = "worker"
  datacenter = "${var.datacenter}"
  count = "${var.worker_count}"
  ssh_username = "${var.ssh_username}"
  short_name = "${var.short_name}"
  vdc = "${var.vdc}"
  catalog = "${var.catalog}"
  network = "${var.network}"
  provider_access = "${var.provider_access}"
}

