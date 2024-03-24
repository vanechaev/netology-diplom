resource "yandex_vpc_network" "net" {
  name = var.vpc_name
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "central1-a" {
  name           = "central1-a"
  zone           = var.a_zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "central1-b" {
  name           = "central1-b"
  zone           = var.b_zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "central1-d" {
  name           = "central1-d"
  zone           = var.d_zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}
