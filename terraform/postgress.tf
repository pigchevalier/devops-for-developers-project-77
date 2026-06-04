module "postgresql" {
  source = "github.com/terraform-yc-modules/terraform-yc-postgresql.git"

  name        = "tfhexlet"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.net.id

  pg_version         = "17"
  resource_preset_id = "s2.micro"
  disk_type          = "network-ssd"
  disk_size          = 15

  postgresql_config = {
    max_connections = 100
  }

  maintenance_window = {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  hosts_definition = [
    {
      zone      = var.yc_zone
      subnet_id = yandex_vpc_subnet.subnet.id
    }
  ]

  owners = [
    {
      name     = nonsensitive(var.db_user)
      password = nonsensitive(var.db_password)
    }
  ]

  users = []

  databases = [
    {
      name       = nonsensitive(var.db_name)
      owner      = nonsensitive(var.db_user)
      lc_collate = "en_US.UTF-8"
      lc_type    = "en_US.UTF-8"
    }
  ]
}
