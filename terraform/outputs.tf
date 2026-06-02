output "ansible_inventory" {
  value = join("\n", concat(
    ["[webservers]"],
    [
      for name, instance in yandex_compute_instance.vm :
      "${name} ansible_host=${instance.network_interface[0].nat_ip_address} ansible_user=ubuntu"
    ]
  ))
}
output "redmine_db_host" {
  value = module.postgresql.cluster_fqdns_list[0][0]
}
