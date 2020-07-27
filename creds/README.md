# Certs folder

This folder contains scripts to provide a quick and easy way to create new self-signed certificates and put them in a k8s secret, as well as other credentials for the Elastic stack.

## How to use

```
sh generate-es-certs.sh
sh generate-kibana-enckey.sh
```

The first command will create self-signed certs for transport layer TLS.

To run the second script requires Docker to be running on your local machine, to create a container that will randomise an encryption key that will be used as the encryption key for Kibana.