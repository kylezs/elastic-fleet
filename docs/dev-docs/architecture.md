# Architecture
This is a high-level architectural overview which explains how all the moving parts connect up together.

## High-level Architecture Diagram
![Architecture diagram](images/architecture.png)

1. The process begins by installing an agent on an endpoint. Kolide launcher is used to make packaging and connecting to kolide fleet simpler. 
2. Appling queries and packs on the fleet server, either by the UI or fleetctl, see [here](fleet-setup.md) - see [here](writing-queries.md) for how to write queries) - will result in the queries running on the agents once their configuration is updated.
3. The agent will then send the results of these queries to the Fleet server.
4. The filebeat sidecar will watch the Fleet server result logs folder for any updates. When an update is found it will push these logs to Elasticsearch.
5. Elasticsearch will ingest these logs automatically.
6. Kibana can then use the data stored in Elasticsearch for dashboards, queries, and alerts, using Elastalert.

## Non functional architecture

### Cert Manager
This project uses [cert-manager](https://cert-manager.io/docs/) to automatically rotate TLS certificates.

### Load Balancer
In production it is best to use a Load Balancer and ingress controller (ingresses in this repo are written for nginx ingress controller). 
It also uses a Load Balancer which receives *all* traffic, and then directs it to the appropriate service (Fleet or Kibana) 