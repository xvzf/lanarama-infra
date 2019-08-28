# Network Connectivity
> Each access switch gets its own (private) IPv4 and (public) IPv6 subnet.
> **NOTE** IPv6 prefixes are added here as soon as we know what exactly we'll get!

## Uplink

### Gateway(s)

#### IPv4
`185.7.211.33`

#### IPv6
Gateway: `2a01:05c0:06:20::1/60`
Routed to: `2a01:05c0:06:20::2/60`

### Routed
```
-[ipv4 : 185.7.211.32/27] - 0

[CIDR]
Host address		- 185.7.211.32
Host address (decimal)	- 3104297760
Host address (hex)	- B907D320
Network address		- 185.7.211.32
Network mask		- 255.255.255.224
Network mask (bits)	- 27
Network mask (hex)	- FFFFFFE0
Broadcast address	- 185.7.211.63
Cisco wildcard		- 0.0.0.31
Addresses in network	- 32
Network range		- 185.7.211.32 - 185.7.211.63
Usable range		- 185.7.211.33 - 185.7.211.62

-
-[ipv6 : 2a01:05c0:0006:1000::/52] - 0

[IPV6 INFO]
Expanded Address	- 2a01:05c0:0006:1000:0000:0000:0000:0000
Compressed address	- 2a01:5c0:6:1000::
Subnet prefix (masked)	- 2a01:5c0:6:1000:0:0:0:0/52
Address ID (masked)	- 0:0:0:0:0:0:0:0/52
Prefix address		- ffff:ffff:ffff:f000:0:0:0:0
Prefix length		- 52
Address type		- Aggregatable Global Unicast Addresses
Network range		- 2a01:05c0:0006:1000:0000:0000:0000:0000 -
			  2a01:05c0:0006:1fff:ffff:ffff:ffff:ffff

-
```

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