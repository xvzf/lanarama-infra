# KVM host with BGP routing capabilities using frrouting

Goal of these ansible playbooks is a working VM host which can advertise its networks via BGP.

## Infrastructure
- Edge Router / Firewall (WAN transfer net, BGP internal)
- KVM host which contains VMs running infrastructure and monitoring services (attached via BGP)
- Gameserver (tbd)

## Infrastructure Services & Monitoring
- DHCP Server (kea) with PSQL as database backend
- DNS Server (probably CoreDNS) tbd
- Prometheus for stats monitoring
- Elasticsearch for traffic monitoring/analysis

## Bootstrapping
Bootstrapping and maintaining the infrastructure is done with the help of `ansible` (configuration management) and `terraform` (stateful environment setup).
There is a `Makefile` containing all necesarry targets and their dependend tasks:

1. Run the `base.yaml` playbook which setups the KVM host(s) and hopefully the gateway.
2. Traverse into the `terraform` subdirectory and execute `terraform apply` which connects to the KVM host(s) and creats VMs with initial configuration
3. Run an additional ansible playbook which setups everything else (still on the TODO list)


## Used tooling

### Libvirt
Libvirt is used as the backend for the KVM host. [Terraform](https://www.terraform.io) connects to the backend and creates specified VMs. It shouldn't be required to manually intersect this process, however you can do it with `virsh`. For debugging it is quite handy to show usage statistics using `virt-top`

### FRR
We are using [frrouting](https://frrouting.org) as a routing daemon on linux systems (more specific, advertising internal subnets via BGP). Frr is also configuring IP addresses of the interfaces.
Privileged users can enter the configuration shell (similar to cisco) with:
```
sudo vtysh
```
