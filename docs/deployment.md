# How to deploy this app in a production ready state
NB: This has only been tested on Linode Kubernetes Engine (LKE) and some of the steps/resources are LKE specific e.g. PVs and PVCs.

This application is a helm chart. To deploy you will first need to have [helm installed](https://helm.sh/docs/intro/install/) on your machine.

1. Clone the repository

2. [Setup a Kubernetes Cluster - This is the LKE guide](https://www.linode.com/docs/kubernetes/deploy-and-manage-a-cluster-with-linode-kubernetes-engine-a-tutorial/)


3. Enter the secrets. You will find a file called `secrets.example.yaml` this should be renamed to `values.secret.yaml` and the values within changed to your secret values. You should not share these values with anyone. Once deployed, this file can be removed and/or the values changed so as not to reflect the values of the secrets in production.

For elastic, the secrets can be generated with scripts. Note, to generate the kibana encryption key you will need Docker running.

In `/creds`
Open the script and enter the values of the secrets you want to use
NB: These will be the credentials of the kibana admin account. It's advised you keep the admin username to `elastic` for convention adherance.
```
sh elastic-creds.sh
sh generate-es-certs.sh
```


1. Ensure you have a domain name.
A domain name is required for setting up a [kolide launcher package](packaging-launcher.md) and for using a TLS protected load balancer.


5. Setting up the Load Balancer + Ingress Controller
We set up an Ingress in order to route traffic to each user facing application (Kibana and Kolide fleet). It also allows us to manage TLS in a central location, and means we don't need to use/remember a port when accessing our services (as we would if we just used NodePort), we can just use the domain.

```
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/
$ helm install nginx-ingress stable/nginx-ingress --set controller.publishService.enabled=true
```

This should create a Load Balancer in whichever cloud provider you use, and its traffic will be routed to the nginx-ingress-controller within your cluster without extra configuration. 

>Note that due to limitations of Kolide Fleet, TLS terminates at the Fleet server for all Fleet requests (both HTTPS and GRPCS) but TLS terminates at the Load Balancer for any requests to other services.

The Ingresses are already contained in [ingress.yaml](../templates/ingress.yaml) and already contain reference to the production TLS cert, managed by Cert Manager.

1. Create A records, one that will route to the Kolide Fleet server, and one that will route to the Kibana dashboard. Point both to the Load Balancer's IP (find the Load Balancer in your cloud provider). The Ingress controller handles the routing of requests.

2. Certificates

## NEEDS REVIEW AFTER REFACTOR
The only certicate is managed by Cert Manager. Follow their [installation docs](https://cert-manager.io/docs/installation/kubernetes/) for creating the issuer.
>Note if you change the issuer name from `letsencrypt-prod` you will need to change the ref in [certificate-prod.yaml](../certificate-prod.yaml)

For production you will need to use:
`kubectl apply -f certificate-prod.yaml`
It may take up to an hour for Let's Encrypt to sign the request.

8. Deploying the application

From inside the project root directory.
>**NOTE: You MUST use 'kf' as the deployment name since there are several dependencies on this name.**:
```
helm install kf . --values values.yaml --values values.secret.yaml
```
If you make changes to the application, you can upgrade with:
```
helm upgrade kf . --values values.yaml --values values.secret.yaml
```

## Setting up SMTP
[Go here](smtp.md)