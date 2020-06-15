# How to Setup Kolide Fleet
It's one thing to have everything launcher, however, without the queries applied to the kolide fleet app, the agents won't start logging, since there are no queries to apply.

## Recommended way
This way of applying and updating the queries is recommended because it uses the queries as they are stored in source control.

Queries are stored in [fleet-config](../fleet-config) under their respective kernel/OS.
- darwin => MacOS
- windows

We can use `fleetctl` a CLI for kolide fleet that allows us to apply queries, packs and configurations directly from files rather than having to create each query individually from the UI.

[Please find the official documentation here](https://github.com/kolide/fleet/tree/master/docs/cli)

## Non-recommended way
Using the UI to update queries is not recommended, but it is the easiest. Most of the time it is completely fine to use the UI to update queries. However, there is a little added risk of losing these changes, since they are not replicated in source control.