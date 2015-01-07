#Reporting API
## Overview

The reporting API is meant to give advertisers and publishers a programmatic way to access data that is present on the dashboard.

|Host           |Request Headers        |API            |
| :-----------  | :-------------------  |:-----------   |
|`https://ssl.vungle.com`         |`Content-Type: application/json`         |Security is handled by passing an API key as a query parameter. Your API key: `API_KEY_HERE` <br> If you don't have one already, email <a href="mailto:tech-support@vungle.com?Subject=API%20Key%20Request" target="_top">tech-support@vungle.com</a> to request one!|

## Advertisers

|Resource       |Parameters             |Description    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns`         |`key=[API Key]`         | Returns a list of the campaigns you own. |
Example Response:

```JSON
{   
    "rate" : 0.01,
    "rateType" : "complete",
    "campaignId" : "51896da23436ae313c3939b9",
    "type" : "external",
    "name" : "Feed the Rat",
    "spent" : 2131
}
```

|Resource       |Parameters             |Description    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns/[Campaign ID]`         |`key=[API Key] date=[YYYY-MM-DD]`         | Returns the statistics for the specified campaign on the specified date.|
Example Response:

```JSON
{
    "clicks" : 1129,
    "completedViews" : 23080,
    "date" : "2012-08-19",
    "campaignId" : "51896da23436ae313c3939b9",
    "installs" : 590,
    "impressions" : 26722,
    "name" : "Feed the Rat",
    "views" : 26546,
    "dailySpend": 566
}
```

|Resource       |Parameters             |Description    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns/[Campaign ID]/installs`         |`key=[API Key] start=[YYYY-MM-DD] end=[YYYY-MM-DD]`         | Returns a list of the installs that have been attributed to the specified campaign during the specified date range.|
Example Response: 

```JSON
{
    "time_clicked": "2012-08-17T01:52:32.024Z",
    "time_installed": "2012-08-17T01:54:33.034Z",
    "openUDID": "e2c42c159286124f34702e770cc702240c2707e8",
    "mac": "98d6bb786fdd"
},
{
    "time_clicked": "2012-08-17T01:52:32.024Z",
    "time_installed": "2012-08-17T01:54:33.034Z",
    "openUDID": "e2c42c159286124f34702e770cc702240c2707e8",
    "mac": "98d6bb786fdd"
}
```

## Publishers

|Resource       |Parameters             |Description    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/applications`         |`key=[API Key]`         | Returns a list of the applications you own.|
Example Response: 

```JSON
{
    "status" : "a",
    "platform" : "iOS",
    "appId" : "51896d9c3436ae313c3939b8",
    "installs" : 1372,
    "name" : "Project Comet",
    "connection" : "all", "id": "51896d9c3436ae313c3939b8"
}
```