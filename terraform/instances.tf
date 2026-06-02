resource "yandex_compute_instance" "vm" {
  for_each = {
    app-1 = {
      name     = "tfhexlet-1"
      hostname = "tfhexlet-1"
    }

    app-2 = {
      name     = "tfhexlet-2"
      hostname = "tfhexlet-2"
    }
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  depends_on = [module.postgresql]
}