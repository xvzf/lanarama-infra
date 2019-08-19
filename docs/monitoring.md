# Monitoring

We are using [Prometheus](https://prometheus.io/) for monitoring the complete infrastructure. Currently, everything is hosted at `vm03` running as guest on `kvm0`

## General settings
The prometheus configuration is auto-generated and can uses an update interval of 10s.

## Server/VM monitoring
Every server and vm has an instance of [node_exporter](https://github.com/prometheus/node_exporter) running.