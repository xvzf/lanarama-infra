.PHONY: terraform vmhosts

all: vmhosts terraform

firewall:
	ansible-playbook -i inventory firewall.yaml

vmhost:
	ansible-playbook -i inventory vmhost.yaml

terraform:
	cd terraform/ && terraform init
	cd terraform/ && terraform plan
	cd terraform/ && terraform apply
