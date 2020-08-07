# Developer Documentation

If you are a developer setting up the chart and related on Kubernetes, or you are a more technical person, writing queries for Fleet. This section of the documentation is for you.

## Deployment

### Production deployment

Load balancer, cert-manager and other production necessary things.

[Production deployment](./deployment.md)

---
### Development deployment

If you wish to use self-signed certs, and just Nodeports, you can follow this.

[Development deployment](./dev-setup.md)

---

### Architecture overview

[Architecture](./architecture.md)

---

## Fleet + Launcher

### Setting up fleet

Kolide Fleet must have queries in order to be useful.

[Setting up fleet](./fleet-setup.md)

### Writing queries

So alerts and metrics are easier to see for non-technical users, use a standard return format for your queries.

[Writing queries for fleet](./writing-queries.md)

---

### Packaging launcher
In order to get an email to show in Kibana so you don't need to know the device UUID => User mapping to recognise which logs belong to which user, you can package launcher in a particular way, and use particular decorator queries.

[Packaging launcher for email in Kibana](./packaging-launcher.md)

---


## Kibana + Elastalert

### Elastalert
Setting up alerts is simple with the Elastalert Kibana plugin.

[Setting up alerts](./elastalert.md)

---

## Other
### SMTP Setup

[SMTP Setup](./smtp.md)