.PHONY: install prepare deploy edit_vault datadog

install:
	ansible-galaxy install -r requirements.yml --force

prepare:
	ansible-playbook -i inventory.ini playbook.yml --tags prepare --vault-password-file ../.vault_password

deploy:
	ansible-playbook -i inventory.ini playbook.yml --tags deploy --vault-password-file ../.vault_password

edit_vault:
	ansible-vault edit group_vars/webservers/vault.yml --vault-password-file ../.vault_password

update_secrets:
	ansible-playbook generate-secrets.yml --vault-password-file ../.vault_password

datadog:
	ansible-playbook -i inventory.ini playbook.yml --tags datadog --vault-password-file ../.vault_password
