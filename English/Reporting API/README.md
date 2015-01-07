#Reporting API
## Overview

The reporting API is meant to give advertisers and publishers a programmatic way to access data that is present on the dashboard.

|Host           |Request Headers        |API            |
| :-----------  | :-------------------  |:-----------   |
|`https://ssl.vungle.com`         |`Content-Type: application/json`         |Security is handled by passing an API key as a query parameter. Your API key: `API_KEY_HERE` <br> If you don't have one already, email <a href="mailto:tech-support@vungle.com?Subject=API%20Key%20Request" target="_top">tech-support@vungle.com</a> to request one!'|

## Advertisers

|Resource       |Parameters             |Description    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns`         |`key=[API Key]`         | Returns a list of the campaigns you own. <br><pre>{<br>   "rate" : 0.01,<br>   "rateType" : "complete",<br>   "campaignId" : "51896da23436ae313c3939b9",<br>   "type" : "external",<br>   "name" : "Feed the Rat",<br>   "spent" : 2131<br>} </pre>|
|`GET /api/campaigns/[Campaign ID]`         |`key=[API Key] date=[YYYY-MM-DD]`         | Returns the statistics for the specified campaign on the specified date. <br><pre>{<br>   "clicks" : 1129,<br>   "completedViews" : 23080,<br>   "date" : "2012-08-19",<br>   "campaignId" : "51896da23436ae313c3939b9",<br>   "installs" : 590,<br>   "impressions" : 26722,<br>   "name" : "Feed the Rat",<br>   "views" : 26546,<br>   "dailySpend": 566<br>} </pre>|
|`GET /api/campaigns/[Campaign ID]/installs`         |`key=[API Key] start=[YYYY-MM-DD] end=[YYYY-MM-DD]`         | Returns a list of the installs that have been attributed to the specified campaign during the specified date range. <br> <pre>{<br>    "time_clicked": "2012-08-17T01:52:32.024Z",<br>   "time_installed": "2012-08-17T01:54:33.034Z",<br>   "openUDID": "e2c42c159286124f34702e770cc702240c2707e8",<br>   "mac": "98d6bb786fdd"<br>},<br>{<br>   "time_clicked": "2012-08-17T01:52:32.024Z",<br>   "time_installed": "2012-08-17T01:54:33.034Z",<br>   "openUDID": "e2c42c159286124f34702e770cc702240c2707e8",<br>   "mac": "98d6bb786fdd"<br>} </pre>|

## Publishers

|Resource       |Parameters             |Description    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/applications`         |`key=[API Key]`         | Returns a list of the applications you own. <br><pre>{<br>   "status" : "a",<br>   "platform" : "iOS",<br>   "appId" : "51896d9c3436ae313c3939b8",<br>   "installs" : 1372,<br>   "name" : "Project Comet",<br>   "connection" : "all", "id": "51896d9c3436ae313c3939b8"<br>} </pre>|
|`GET /api/applications/[App ID]`         |`key=[API Key] date=[YYYY-MM-DD]` <br> or <br> `key=[API Key] start=[YYYY-MM-DD] end=[YYYY-MM-DD]` | Returns a list of the statistics for the specified application on the specified date(s). <br><pre>{<br>  "date" : "2012-08-16",<br>  "impressions" : 5165, "views" : 5156,<br>  "completes" : 1686,<br>  "revenue" : 16.86,<br>  "eCPM" : 3.26<br>}</pre>|