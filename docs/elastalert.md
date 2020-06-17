# How to Write Alerts

In order for alerts to work, [SMTP needs to be configured](smtp.md).

## Using the ConfigMap

Because we use Kubernetes to deploy the application suite, we include elastalert rules in a [ConfigMap](../templates/elastalert-configmap.yaml).


## Using Kibana - if enabled

In kibana - configuring it for kibana?