# Monitoring

We are using [Prometheus](https://prometheus.io/) for monitoring the complete infrastructure. Currently, everything is hosted at `vm03` running as guest on `kvm0`

## General settings
The prometheus configuration is auto-generated and can uses an update interval of 10s.

## Server/VM monitoring
Every server and vm has an instance of [node_exporter](https://github.com/prometheus/node_exporter) running.

## Access Switch monitoring
Access switches provide basic port statistics and are scraped using the [smtp_exporter](https://github.com/prometheus/smtp_exporter).

## Core Switch monitoring
Both core switches are also monitored via snmp. Additionally there is flow monitoring in place with the help of [elastifloew](https://github.com/robcowart/elastiflow).

# Flow monitoring

In order to setup the elastiflow monitoring, the json containing the dashboard template & index patterns has to be uploaded via the Kibana web interface. The json file is placed in `/assets/elastifeed`