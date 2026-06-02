edit_vault:
	ansible-vault edit ansible/group_vars/localhost/vault.yml --vault-password-file .vault_password

update_secrets:
	$(MAKE) -C ansible update_secrets

terraform_init:
	cd ./terraform; terraform init -backend-config=secret.backend.tfbackend

terraform_apply:
	cd ./terraform; terraform apply

ansible_install:
	$(MAKE) -C ansible install

ansible_prepare:
	$(MAKE) -C ansible prepare

ansible_deploy:
	$(MAKE) -C ansible deploy

ansible_edit_vault:
	$(MAKE) -C ansible edit_vault

ansible_datadog:
	$(MAKE) -C ansible datadog

ansible_inventory:
	cd ./terraform; terraform output -raw ansible_inventory > ../ansible/inventory.ini
ansible_vars:
	printf "redmine_db_host: %s\n" "$$(cd ./terraform; terraform output -raw redmine_db_host)" > ./ansible/group_vars/all/terraform.yml
