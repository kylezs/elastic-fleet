# How to use the Kibana Dashboard

This document will briefly outline a clean process of using kibana. It will show you to to create a 'query' which will allow you to just search for the results of a particular group of emails.

> If you are not seeing the results you expect, or any results at all, please ensure you have the time range set correctly. You can set this in the top right of the screen in Kibana, next to the search bar. It is advised to set from a week ago until now, using the "relative" time, based on the query schedule being used here.

## Finding endpoint failures

Once you have a set of visualisations set up. You can combine these into a group called a "dashboard" in Kibana.

To see the dashboards page, it is the 4th item from the top, on the left sidebar.

Clicking on one of these dashboards will present you with the last status update from all the devices.

In order to filter down to particular devices, for example, devices of people you manage, it is recommended you save a search containing only these device identifiers.

## How to save a new query

You can do this from the dashboard screen.

1. Select a dashboard so you can see the full view, and the search bar at the top.

> Windows and Mac need to have separate dashboards because they use different queries.

2. In the searchbar you want to write a search query like:

```
email : "<email1>"  or email : "<email2>" 
```

This search will now only show the dashboard for these emails. Hence any unique device/user identifier could be used here.

You can keep adding `or email:"<another_email>"` to add more emails to your list.

Continue until the result is down to the devices you want to see. Also ensure the time range is long enough. From now back to a week ago should be fine. 

1. On the left you can save your query. Your saved queries will be viewable by other users, so make sure you name them well. Perhaps a format like: `yourusername - what is the query`

2. Now when you come back to view the dashboards, you can click your saved search and get only information on the devices contained in that search.


## Updating a query

1. Click the Saved Queries button to the left of the search bar
2. Open open the query you wish to update
3. Change it to what you want
4. Click the Saved Queries button to the left of the search bar again
5. Save changes

## Deleting a query

1. Open the Saved Queries
2. Hover the query you wish to delete
3. Click the red trash can on the right of the query name
4. Delete