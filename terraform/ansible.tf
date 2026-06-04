resource "local_file" "ansible_terraform_vars" {
  filename = "${path.module}/../ansible/group_vars/all/terraform.yml"

  content = templatefile("${path.module}/templates/ansible_terraform.yml.tftpl", {
    redmine_db_host = module.postgresql.cluster_fqdns_list[0][0]
  })
}
