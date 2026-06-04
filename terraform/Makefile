.PHONY: init apply ansible_inventory

init:
	terraform init -backend-config=secret.backend.tfbackend

apply:
	terraform apply

ansible_inventory:
	terraform output -raw ansible_inventory > ../ansible/inventory.ini
