terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "= 0.99.1"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "app" {
  name = "${var.stage}-reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file("${var.private_key_path}")
  }

  provisioner "file" {
    content     = templatefile("${path.module}/files/puma.service", { mongod_ip = var.mongod_ip })
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
