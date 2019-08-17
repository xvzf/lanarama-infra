.PHONY: terraform vmhosts

all: bootstrap

bootstrap:
	ansible-playbook -i inventory bootstrap.yaml

base:
	ansible-playbook -i inventory base.yaml

terraform:
	cd terraform/ && terraform init
	cd terraform/ && terraform plan
	cd terraform/ && terraform apply
