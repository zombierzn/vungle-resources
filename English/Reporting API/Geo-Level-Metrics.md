#Geo Level Metrics
## Overview
You asked, we listened. Better still, we acted! We’ve added a feature to our reporting API so that you can see how we perform across your different geos. 

If you have any questions, please fire 'em towards <a href="mailto:tech-support@vungle.com?Subject=Reporting%20API%20-%20Geo" target="_top">tech-support@vungle.com</a> and we’ll look after you there.

###Default Behavior
A quick refresher on how our API looks. A request to:

`https://ssl.vungle.com/api/applications/[yourReportingAPIID]?key=[yourAPIKeyHere]&date=2014-01-01 `

will return a result that looks like this:
```
{
"date"        : "2014-01-01",
"impressions" : 100000,
"views"       : 98000,
"completes"   : 70000,
"revenue"     : 680.00,
"eCPM"        : 6.80
}```

###Now Introducing Geo!
The addition to the api is simple - just add an extra argument to your query. The argument is `geo` and you can set it to one of two things: All Results or Individual Results.

_**NOTE**: We do not support date range for the Geo API. Please do not request for more than one day of geo data._ 

##### All Results
If you set the `geo` argument to `all` then you’ll receive an extra array of objects in your API response detailing the Views, Revenue, and eCPM of each geo.

`https://ssl.vungle.com/api/applications/[yourReportingAPIID]?key=[yourAPIKeyHere]&date=2014-01-01&geo=all`

Will return something of the form:
```
{
"date"        : "2014-01-01",
"views"       : 98000,
"revenue"     : 680.00,
"eCPM"        : 6.80,
"geo_eCPM"    : [{"country" : "US", "views" : 98000, "revenue" : 680.00,"eCPM" : 8.10}, {"country" : "TH", "views" : 98000, "revenue" : 680.00, "eCPM" : 5.11}, ...]
}
```
##### Individual Results
If you set the `geo` argument to a specific geo, e.g. `US` then you’ll receive an object specific to that geo:

`https://ssl.vungle.com/api/applications/[yourReportingAPIID]?key=[yourAPIKeyHere]&date=2014-01-01&geo=US`

Will return something of the form:
```
{
"date"        : "2014-01-01",
"country"     : "US",
"views"       : 98000,
"revenue"     : 680.00,
"eCPM"        : 8.10
}
```
This request may also return either of the following self-explanatory errors:
```
{
"date"        : "2014-01-01",
"country"     : "ZZ",
"error"       : "Geo Not Found"
}
```


