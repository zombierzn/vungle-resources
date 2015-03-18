#地区级别的特征值
## 概述
我们争取做到最好，现在我们已经可以提供不同地区的数据了！

如果你有任何问题, 请发邮件到 'em towards <a href="mailto:tech-support@vungle.com?Subject=Reporting%20API%20-%20Geo" target="_top">tech-support@vungle.com</a>，我们期待为你解答。

###默认动作
我们界面上一个API要求的预览. 发送一个请求到:

`https://ssl.vungle.com/api/applications/[yourReportingAPIID]?key=[yourAPIKeyHere]&date=2014-01-01 `

会返回以下的JSON:
```JSON
{
    "date"        : "2014-01-01",
    "impressions" : 100000,
    "views"       : 98000,
    "completes"   : 70000,
    "revenue"     : 680.00,
    "eCPM"        : 6.80
}
```

###现在介绍不同的地域!
这个API的额外功能很简单-在你的请求里面多加一个参数就可以了。这个参数是`geo` ，你可以设置为: 得到全部结果，或者一部分结果.

_**注意**: 我们对Geo API不支持一定时间范围的. 请不要发多于一天的请求._ 

##### All 所有的结果
如果你设置参数 `geo` 值为 `all` 那么你会在你的API回复收到一串数组，有关于每个geo的 Views, Revenue, 和 eCPM。

`https://ssl.vungle.com/api/applications/[yourReportingAPIID]?key=[yourAPIKeyHere]&date=2014-01-01&geo=all`

会返回类似以下的内容：
```JSON
{
    "date"        : "2014-01-01",
    "views"       : 98000,
    "revenue"     : 680.00,
    "eCPM"        : 6.80,
    "geo_eCPM"    : [
                        {
                            "country" : "US",
                            "views" : 98000,
                            "revenue" : 680.00,
                            "eCPM" : 8.10
                        },
                        {
                            "country" : "TH",
                            "views" : 98000,
                            "revenue" : 680.00,
                            "eCPM" : 5.11
                        },
                    ]
}
```
##### 单独的结果
如果你设置参数 `geo` 值为某个特定的地区, 比如 `US` 那么你会收到这个地区特定的数据:

`https://ssl.vungle.com/api/applications/[yourReportingAPIID]?key=[yourAPIKeyHere]&date=2014-01-01&geo=US`

会返回类似以下的内容:
```JSON
{
    "date"        : "2014-01-01",
    "country"     : "US",
    "views"       : 98000,
    "revenue"     : 680.00,
    "eCPM"        : 8.10
}
```
这个请求可能也会返回类似以下的错误信息:
```JSON
{
    "date"        : "2014-01-01",
    "country"     : "ZZ",
    "error"       : "Geo Not Found"
}
```


