# How to deploy this app in a production ready state
NB: This has only been tested on Linode Kubernetes Engine (LKE) and some of the steps/resources are LKE specific e.g. PVs and PVCs.



Apply necessary credentials


Ensure you have a domain name


SSL cert rotation

## Setting up Ingress
We set up an Ingress (Load Balancer) in order to route traffic to each user facing application (Kibana and Kolide fleet). It also allows us to manage TLS in a central location, and means we don't need to use/remember a port when accessing our services (as we would if we just used NodePort), we can just use the domain.

[This is Linode's guide for setting up an ingress, that was followed here](https://www.linode.com/docs/kubernetes/how-to-deploy-nginx-ingress-on-linode-kubernetes-engine/)



