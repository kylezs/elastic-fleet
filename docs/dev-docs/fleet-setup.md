# How to Setup Kolide Fleet
It's one thing to have everything deployed, however, without the queries applied to the kolide fleet app, the agents won't start logging, since there are no queries to apply.

## CLI - Recommended
Using the CLI is faster and encourages you to source control your queries.

We can use `fleetctl` a CLI for kolide fleet that allows us to apply queries, packs and configurations directly from files rather than having to create each query individually from the UI.

[Please find the official documentation here](https://github.com/kolide/fleet/tree/master/docs/cli)

Queries are stored in [fleet-config](../fleet-config) under their respective kernel/OS.
- darwin => MacOS
- windows

## UI - Less recommended
You can also add and update queries and packs using the Fleet UI.

## Setting up SMTP
[See here](smtp.md)