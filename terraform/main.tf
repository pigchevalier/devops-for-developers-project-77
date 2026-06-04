data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_network" "net" {
  name = "tfhexlet"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "tfhexlet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.192.0/24"]
}
