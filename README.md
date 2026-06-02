### Hexlet tests and linter status:
[![Actions Status](https://github.com/pigchevalier/devops-for-developers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/pigchevalier/devops-for-developers-project-77/actions)

https://climbingchevalier.ru/


## Requirements

- Terraform
- Ansible
- Yandex Cloud CLI
- existing Yandex Cloud folder
- existing Object Storage bucket for Terraform state
- existing DNS zone in Yandex Cloud DNS
- existing TLS certificate in Yandex Certificate Manager

## Secrets

Secrets are stored in `vault.yml` and are rendered into Terraform files with Ansible.

Copy a vault password file:

```bash
cp .vault_password.example .vault_password
```

Edit encrypted secrets:

```bash
make edit_vault
```

Generate Terraform secret files:

```bash
make update_secrets
```

This creates:

- `terraform/secret.auto.tfvars` for Terraform variables;
- `terraform/secret.backend.tfbackend` for Terraform backend configuration.

Both files are ignored by Git.

## Deploy

Initialize Terraform backend:

```bash
make terraform_init
```

Apply infrastructure:

```bash
make terraform_apply
```

If the IAM token expires, generate a new one:

```bash
yc iam create-token
```

Then update `vault.yml` and run:

```bash
make update_secrets
```

## Install Ansible dependencies

Установить зависимости:

```bash
make ansible_install
```
## Prepare inventory

Запустить подготовку inventory:

```bash
make ansible_inventory
make ansible_vars
```

## Prepare servers

Запустить подготовку серверов:

```bash
make ansible_prepare
```

## Deploy Redmine

Запустить Redmine на серверах:

```bash
make ansible_deploy
```
## Datadog restart

Запустить Redmine на серверах:

```bash
make ansible_datadog
```


