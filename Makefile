.PHONY: terraform vmhosts

all: vmhosts terraform

vmhosts:
	ansible-playbook -i inventory infrastructure.yaml

terraform:
	cd terraform/ && terraform init
	cd terraform/ && terraform plan
	cd terraform/ && terraform apply
