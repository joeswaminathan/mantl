variable "control_count" { default = 3 }
variable "short_name" {default = "mantl"}
variable "ssh_username" {default = "centos"}
variable "worker_count" { default = 2 }
variable "datacenter" {default = "jswamina-vdc"}
variable "catalog" {default = "cc1fffde-7736-435a-aca7-89535cec7edd"}
variable "vdc" {default = "5db60744-14ac-4497-ac12-2da287cb47a9"}
variable "network" {default = "d57fa801-e5ab-437e-8b95-cfee24a035ae"}


provider "icf" {
	username = "admin"
	password = "Sfish123"
	icfb = "10.193.75.216"
	vdc = "${var.vdc}"
}	

module "control-nodes" {
  source = "../microservices-infrastructure/terraform/icf/instance"
  role = "control"
  datacenter = "${var.datacenter}"
  count = "${var.control_count}"
  ssh_username = "${var.ssh_username}"
  short_name = "${var.short_name}"
  vdc = "${var.vdc}"
  catalog = "${var.catalog}"
  network = "${var.network}"
}

module "worker-nodes" {
  source = "../microservices-infrastructure/terraform/icf/instance"
  role = "worker"
  datacenter = "${var.datacenter}"
  count = "${var.worker_count}"
  ssh_username = "${var.ssh_username}"
  short_name = "${var.short_name}"
  vdc = "${var.vdc}"
  catalog = "${var.catalog}"
  network = "${var.network}"
}

