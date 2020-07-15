# Dev setup

In a dev setup, we don't setup a Load Balancer, hence, don't worry about ingresses. Instead, we use NodePorts to access services.

1. Clone the repository
2. Create the fleet certificate. Fleet must run on tls.

```
kubectl apply -f fleet-dev-cert.yaml
```
This is a self signed certificate. Do NOT use in production.

3. Setup elastic certs and kibana key. [See here](../creds/README.md)


4. Enter the secrets. You will find a file called `secrets.example.yaml` this should be renamed to `values.secret.yaml` and the values within changed to your secret values. You should not share these values with anyone. Once deployed, this file can be removed and/or the values changed so as not to reflect the values of the secrets in production.

5. 
Ensure you are in the project root directory again.
```
helm install <release_name> . --values values.yaml --values values.secret.yaml
```