# How to Write Queries

This document outlines how to write or update queries that are consistent with the current queries. Osquery is a very flexible tool, however, for our purposes, in order to simplify the process of managing the queries and alerts, there is a standard method of writing the query.

If you're looking for how to apply queries you've written / add them for use. Please see [this document](fleet-setup.md).

## 1+ / 0 as Pass / Fail
When a query returns it should only return one value. 1 or higher implies that the device passes that test. 0 implies the device fails that test.
e.g. 

## 'compliant' as the return field name
A query should return the integer value that suggests Pass/Fail (described above) in a field named 'compliant'. This allows for more generic alerts later on, as we only need to check one particular field name for all the queries.

## Osquery documentation
Osquery can query for many things for each operating. In order to find out what Osquery can query you can check out their [documentation](https://osquery.io/schema).

## Examples
### Is Windows Auto-update on?

    select case when autoupdate='Good' then 1 else 0 end as compliant from windows_security_center;

There are a few things to notice here.
1. The use of `case when... then... else... end` this allows us to define the pass/fail values explicitly.
2. `as compliant` is used to explicitly label the return field as `compliant`
3. The check, `autoupdate=Good` , is specific to this Osquery table. You should check the documentation for information on what each of these fields returns, in order to write the query for it.
</ol>

### Is remote login off?

    select case when remote_login = 0 then 1 else 0 end as compliant from sharing_preferences

Note here that remote_login already returns a 0 or 1, however, they mean the opposite to what we want them to mean, thus we must flip the values.

### Is screenlock on?

    select case when enabled=0 or grace_period=-1 or grace_period > 300 then 0 else 1 end as compliant from screenlock;

For this query, you can see that the check contains 3 clauses, any of which fail (due to using `or` will cause the query to return 0 (fail)).
`enabled=0 or grace_period=-1 or grace_period > 300`. As the documentation informs, `grace_period=-1` means after the screen locks, no password is required. This is a fail. 


## Testing queries
The best way to test queries is to run them. You can download Osquery on a device with the OS you are attempting to write a query for and use the interactive query shell by using `osqueryi` command, and `CTRL+C` to exit. 
See the [documentation](https://osquery.readthedocs.io/en/stable/installation/install-macos/) for more details.

If the Fleet live query is enabled, you can also test queries on devices in your fleet through there, and save the queries directly.

**It is best practice to write the queries in a yaml file, like in this repo, under /fleet-config. This is to ensure that any environment is easily replicable from just the code base. Not dependent on any saved data in an external source.
The queries can be applied from the yaml by using the fleetctl CLI**