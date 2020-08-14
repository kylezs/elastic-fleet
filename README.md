# Elastic Fleet

## About

Elastic fleet is a dashboard made for Digital Security Specialists (DSSs) to monitor devices running on Windows and MacOS. DSSs are able to know when a partner fell from the cyber security wagon by knowing if:
- Firewall is enabled
- Disk-encryption is enabled
- Screen lock is enabled
- Automatic updates are enabled
- Remote login is disabled
- The device is authentication-protected
- A password manager is installed

## Sponsorship

This work was sponsored by the [ISC Project](https://www.iscproject.org/).


## More information

The goal of this project is to have a functioning endpoint management solution. The endpoints are monitored using osquery, wrapped in Kolide's launcher.

This repository is (mostly) a helm chart containing:
- [Kolide Fleet](https://github.com/kolide/fleet)
- [Elasticsearch](https://github.com/elastic/helm-charts/tree/master/elasticsearch)
- [Kibana](https://github.com/elastic/helm-charts/tree/master/kibana)
- [Elastalert](https://github.com/bitsensor/elastalert) - We use a custom image to allow for editing alerts from Kibana UI


Agent:
- [Kolide Launcher](https://github.com/kolide/launcher)

## Documentation
Find the documentation [here](docs/contents.md).

