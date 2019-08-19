# Network Topology
> Network connectivity heavily relies on the BGP(4) protocol. Each access switch has its own AS number (detailed information following) and peers with both core switches which also have their own AS number.

## Hardware overview

### Core layer
The two core switches consists of two *Arista DCS7050SX-64* which peer via an 80 Gigabit interconnect. Ideally this link never sees much traffic and if so, something is going wrong with routing or there is a physical damage on the connection between one of the core switches and one of the access switches.

### Highspeed access layer
tbd

### Uplink Layer
Currently there is one Uplink gateway which is "just" a *Dell R420* (2x E5-2430v2, 64GB DDR3) NATing with nftables and forwarding IPv6 traffic. It peers with the Core layer and advertises a default route.

### Service Layer
Servers are also integrated here. Hardware varies.

### Access Layer
We currently have 7 access switches planned (*Penguin Computing 4804i-q*) which have a 10 Gigabit connection to **each** of the core switches. ECMP (**E**qual **C**ost **M**ultipath **R**outing) is enabled which ensures the switch routes packets over both link simultaniously. The switch performs a hash algorithm on the source/destination and decides on which link to send the packet.


## BGP internals
> We are using the private 16bit AS-range for our network.

### Core layer
> Core switches are running Aristas EOS.

- **core0** -> **AS64666**
- **core1** -> **AS64667**

### Uplink layer
> The uplink gateway is running [frrouting](https://frrouting.org) and advertises a default route.

- **heaven0** -> **AS65001**

### Service layer
> Our servers are also running [frrouting](https://frrouting.org) and advertises their internal network via BGP.

- **kvm0** -> **AS64801**

### Access layer
> The access switches are running the (seemingly acient) [quagga](https://www.quagga.net) routing suite.

- **access1** -> **AS64701**
- **access2** -> **AS64702**
- **access3** -> **AS64703**
- **access4** -> **AS64704**
- **access5** -> **AS64705**
- **access6** -> **AS64706**
- **access7** -> **AS64707**

# Connecting to the switches
Every switch has a unique IP which is advertised and should be available from each point in the network. It is derived from the AS number.

Some examples:

- *64666* -> *10.64.66.6/32*
- *64702* -> *10.64.70.2/32*
- *65001* -> *10.65.0.1/32*

# Peering
> **ATTENTION** The BGP daemon on the core switches is listening only on the IPv6 address range! (more specific: `fc00::/16`)

Peering is possible at the coreswitches on Port 1-16 (10 Gbit) as well as 49-52 (40 Gbit, 51 and 52 split up to 4x10G for Server connections) following this schema (IPv4, IPv6). All ASes are accepted!
```
  10.<core-id>.<port-index>.1/30
  fc00:<core-id>:<port-index>::1/126
```