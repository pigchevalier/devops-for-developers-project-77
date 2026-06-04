edit_vault:
	ansible-vault edit ansible/group_vars/all/vault.yml --vault-password-file .vault_password

update_secrets:
	$(MAKE) -C ansible update_secrets

terraform_init:
	$(MAKE) -C terraform init

terraform_apply:
	$(MAKE) -C terraform apply

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
	$(MAKE) -C terraform ansible_inventory
