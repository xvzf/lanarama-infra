# Network Connectivity
> Each access switch gets its own (private) IPv4 and (public) IPv6 subnet.
> **NOTE** IPv6 prefixes are added here as soon as we know what exactly we'll get!

## Access
### IPv4
Each access switch gets its own IPv4 subnet following this schema:
```
192.168.<access-id>.0/24
```
The .1 in the network is always the switch and will act as gateway for connecting clients

### IPv6
tbd

### IP address configuration
For IPv6 we are using SLAAC - the IPv4 part is covered by a DHCP server running on *kvm0* to which the access switches connect as a dhcp-relay.

## Servers
### heaven0
*heaven0* is currently the only edge router. It NATs IPv4 and forwards IPv6 traffic. Additionally it does connection tracking in order to implement some basic network security for the gamers.
There is no traffic shaping in place yet as we get a 10 Gigabit uplink connection which we probably will not saturate.

### kvm0
*kvm0* is a virtual-machine host providing several instances like the DHCP server or monitoring. It advertises *192.168.122.0/24*