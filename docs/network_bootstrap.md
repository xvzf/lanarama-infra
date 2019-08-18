# Network Bootstrap

The network configuration is fully automated and based on [ansible](https://www.ansible.com).

## Provisioning core switches
Currently there is only support for updating the config of the already reachable core switches. This will be adapted as soon as we have more than two backbone switches. Admins are lazy :-P

## Provisioning access switches
Each access switch has to have the default cumulus linux login credentials configured. Additionally it has the IP address assigned to `eth0` (the management interface) as stated in the [provisioning](https://github.com/xvzf/kvm-frrouting-ansible/tree/master/inventory_provisioning) inventory.

Provisioning can be done by executing
```bash
ansible-playbook -i inventory_provisioning access.yaml
```