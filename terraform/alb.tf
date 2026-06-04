data "yandex_cm_certificate" "wiki" {
  name = "climbingchevalier"
}

data "yandex_dns_zone" "main" {
  name = "climbingchevalier"
}

resource "yandex_alb_target_group" "wiki" {
  name = "wiki-target-group"

  target {
    subnet_id  = yandex_vpc_subnet.subnet.id
    ip_address = yandex_compute_instance.vm["app-1"].network_interface[0].ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.subnet.id
    ip_address = yandex_compute_instance.vm["app-2"].network_interface[0].ip_address
  }
}

module "alb" {
  source = "github.com/terraform-yc-modules/terraform-yc-alb.git"

  network_id = yandex_vpc_network.net.id

  public_dns_record    = true
  public_dns_zone_id   = data.yandex_dns_zone.main.id
  public_dns_zone_name = "climbingchevalier.ru."

  alb_load_balancer = {
    name = "tfhexlet-alb"
    alb_backend_groups = {
      "wiki-backend-group" = {
        http_backends = [
          {
            name   = "wiki-backend"
            port   = 80
            weight = 100
            http2  = false

            existing_target_groups_ids = [yandex_alb_target_group.wiki.id]

            healthcheck = {
              healthcheck_port = 80
              timeout          = "3s"
              interval         = "10s"

              http_healthcheck = {
                path  = "/"
                http2 = false
              }
            }
          }
        ]
      }
    }

    alb_http_routers = ["wiki-router"]

    alb_virtual_hosts = {
      "wiki-virtual-host" = {
        http_router_name = "wiki-router"
        authority        = ["climbingchevalier.ru"]

        route = {
          name = "wiki-route"

          http_route = {
            http_route_action = {
              backend_group_name = "wiki-backend-group"
            }
          }
        }
      }
    }

    alb_locations = [
      {
        zone      = var.yc_zone
        subnet_id = yandex_vpc_subnet.subnet.id
      }
    ]

    alb_listeners = [
      {
        name = "http-listener"

        endpoint = {
          address = {
            external_ipv4_address = {}
          }
          ports = ["80"]
        }

        http = {
          redirects = {
            http_to_https = true
          }
        }
      },
      {
        name = "https-listener"

        endpoint = {
          address = {
            external_ipv4_address = {}
          }
          ports = ["443"]
        }

        tls = {
          default_handler = {
            http_handler = {
              http_router_name = "wiki-router"
            }

            certificate_ids = [data.yandex_cm_certificate.wiki.id]
          }
        }
      }
    ]

    log_options = {
      disable = true
    }
  }

  depends_on = [
    yandex_alb_target_group.wiki
  ]
}
