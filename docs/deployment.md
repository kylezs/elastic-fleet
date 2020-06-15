# How to deploy this app in a production ready state
NB: This has only been tested on Linode Kubernetes Engine (LKE) and some of the steps/resources are LKE specific e.g. PVs and PVCs.

This application is a helm chart. To deploy you will first need to have [helm installed](https://helm.sh/docs/intro/install/) on your machine.

1. Clone the repository and 

```
git clone ...
cd ...
```

2. [Setup a Kubernetes Cluster - This is the LKE guide](https://www.linode.com/docs/kubernetes/deploy-and-manage-a-cluster-with-linode-kubernetes-engine-a-tutorial/)


3. Setup the credentials. -- Requires more info, will add after deployment.

4. Ensure you have a domain name.
A domain name is required for setting up a [kolide launcher package](packaging-launcher.md) and for using a TLS protected load balancer.


SSL cert rotation

## Setting up Ingress
We set up an Ingress (Load Balancer) in order to route traffic to each user facing application (Kibana and Kolide fleet). It also allows us to manage TLS in a central location, and means we don't need to use/remember a port when accessing our services (as we would if we just used NodePort), we can just use the domain.

[This is Linode's guide for setting up an ingress, that was followed here](https://www.linode.com/docs/kubernetes/how-to-deploy-nginx-ingress-on-linode-kubernetes-engine/)


## Setting up SMTP
[Go here](smtp.md)
