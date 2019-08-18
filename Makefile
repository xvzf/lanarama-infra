.PHONY: terraform vmhosts

all: bootstrap

bootstrap:
	ansible-playbook -i inventory bootstrap.yaml

base:
	ansible-playbook -i inventory base.yaml

provisioning:
	ansible-playbook -i inventory_provisioning access_provisioning.yaml
