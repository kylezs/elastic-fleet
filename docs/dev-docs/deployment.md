# How to deploy this app in a production ready state
NB: This has only been tested on Linode Kubernetes Engine (LKE) and some of the steps/resources are LKE specific e.g. PVs and PVCs.

This application is a helm chart. To deploy you will first need to have [helm installed](https://helm.sh/docs/intro/install/) on your machine.

1. Clone the repository

2. [Setup a Kubernetes Cluster - This is the LKE guide](https://www.linode.com/docs/kubernetes/deploy-and-manage-a-cluster-with-linode-kubernetes-engine-a-tutorial/)


3. Enter the secrets. You will find a file called `secrets.example.yaml` this should be renamed to `values.secret.yaml` and the values within changed to your secret values. You should not share these values with anyone. Once deployed, this file can be removed and/or the values changed so as not to reflect the values of the secrets in production.

4. Setup elastic certs and kibana key. [See here](../creds/README.md)


5. Ensure you have a domain name.
A domain name is required for setting up a [kolide launcher package](packaging-launcher.md) and for using a TLS protected load balancer.


6. Setting up the Load Balancer + Ingress Controller

```
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/
$ helm install nginx-ingress stable/nginx-ingress --set controller.publishService.enabled=true
```

This should create a Load Balancer in whichever cloud provider you use, and its traffic will be routed to the nginx-ingress-controller within your cluster without extra configuration. 

>Note that due to limitations of Kolide Fleet, TLS terminates at the Fleet server for all Fleet requests (both HTTPS and GRPCS) but TLS terminates at the Load Balancer for any requests to other services.

The Ingresses are already contained in [ingress.yaml](../templates/ingress.yaml) and already contain reference to the production TLS cert, managed by Cert Manager.

1. Create A records, one that will route to the Kolide Fleet server, and one that will route to the Kibana dashboard. Point both to the Load Balancer's IP (find the Load Balancer in your cloud provider). The Ingress controller handles the routing of requests.

2. Certificates

The only certicate is managed by Cert Manager. Follow their [installation docs](https://cert-manager.io/docs/installation/kubernetes/) for creating the Custom Resource Definitions.

The cert-manager issuer and certificate are deployed alongside the rest of the application, from within the helm chart, using the cert-manager CRDs.

Setting `certs.mode: dev` in values will disable this, so you can use self-signed certs.


3. Deploying the application

From inside the project root directory.

```
helm install kf . --values values.yaml --values values.secret.yaml
```
If you make changes to the application, you can upgrade with:
```
helm upgrade kf . --values values.yaml --values values.secret.yaml
```

## Setting up SMTP
[Go here](smtp.md)