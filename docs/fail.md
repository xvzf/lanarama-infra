# Fails (read this)

- DHCP has to run on a **fucking physical interface** and **not a bridge**.
- Don't add any kernel routes (e.g. with iproute 2) on the arista switches. It **will** break routing!