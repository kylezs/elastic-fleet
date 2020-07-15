# Elastic Fleet

The goal of this project is to have a functioning endpoint management solution. The endpoints are monitored using osquery, wrapped in Kolide's launcher.

This repository is (mostly) a helm chart containing:
- [Kolide Fleet](https://github.com/kolide/fleet)
- [Elasticsearch](https://github.com/elastic/helm-charts/tree/master/elasticsearch)
- [Kibana](https://github.com/elastic/helm-charts/tree/master/kibana)
- [Elastalert](https://github.com/bitsensor/elastalert) - We use a custom image to allow for editing alerts from Kibana UI

Agent:
- [Kolide Launcher](https://github.com/kolide/launcher)