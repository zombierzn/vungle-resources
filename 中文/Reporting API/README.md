#Reporting API
## 概述

Reporting API是一种为广告投放商还有发行商提供控制板上数据的程序化接口。

|Host           |Request Headers        |API            |
| :-----------  | :-------------------  |:-----------   |
|`https://ssl.vungle.com`         |`Content-Type: application/json`         |传递一个API密钥是安全协议的一个参数<br> 如果你还没有，请发邮件到 <a href="mailto:tech-support@vungle.com?Subject=API%20Key%20Request" target="_top">tech-support@vungle.com</a> 来申请一个！|

## 广告商

|资源       |参数             |描述    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns`         |`key=[API Key]`         | 返回一系列的campaign（推广活动）. |
回复范例:

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

|资源       |参考             |描述    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns/[Campaign ID]`         |`key=[API Key] date=[YYYY-MM-DD]`         | 返回特定的campaign(推广活动）在特定时间的数据。|
回复范例:

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

|资源       |参数             |描述    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/campaigns/[Campaign ID]/installs`         |`key=[API Key] start=[YYYY-MM-DD] end=[YYYY-MM-DD]`         | 返回一系列特定campaign(推广活动）在特定时间的下载数据|
回复范例: 

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

## 发行商

|资源       |参数             |描述    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/applications`         |`key=[API Key]`         | 返回你拥有的所有应用程序的表单|
回复范例: 

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

|资源       |参数             |描述    |
| :-----------  | :-------------------  |:-----------   |
|`GET /api/applications/[App ID]`         |`key=[API Key] date=[YYYY-MM-DD]` <br> or <br> `key=[API Key] start=[YYYY-MM-DD] end=[YYYY-MM-DD]` | 返回特定应用程序在特定时间的一系列相关数据.|
回复范例: 

```JSON
{
    "date" : "2012-08-16",
    "impressions" : 5165, "views" : 5156,
    "completes" : 1686,
    "revenue" : 16.86,
    "eCPM" : 3.26
}
```