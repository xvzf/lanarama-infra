## Helpful tools/commands

### FRR
We are using [frrouting](https://frrouting.org) as a routing daemon on linux systems (more specific, advertising internal subnets via BGP). Frr is also configuring IP addresses of the interfaces.
Privileged users can enter the configuration shell (similar to cisco) with:
```
sudo vtysh
```