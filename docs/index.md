# Lanarama Infrastructure & Server Setup

# Basic network topology
The network topology sort of follows the spine-leaf concept. There are two switches for backbone routing and several access switches which connect to both of the backbone (further called core) switches.

## Infrastructure
- Edge Router / Firewall (WAN transfer net, BGP internal)
- KVM host which contains VMs running infrastructure and monitoring services (attached via BGP)
- Gameserver (tbd)

## Infrastructure Services & Monitoring
- DHCP Server (isc-dhcp-server)
- DNS Server (probably CoreDNS) tbd
- Prometheus for stats monitoring
- Elasticsearch for traffic monitoring/analysis
