---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: Trendz Rest API
description: Trendz Rest API
---

* TOC
{:toc}

Trendz 提供简单的 Rest API，用于下载视图报告数据。

* 在 Trendz 中创建包含所有必需字段的表格视图。
* 复制该视图的链接并提取视图 ID。它是链接最后部分的 UUID 字符串
* 执行 HTTP POST 请求：

**URL**：http://localhost:8888/apiTrendz/publicApi/buildReport?jwt=YYYYYYY

**正文**：

```json
{
	"viewConfigId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", 
	"rangeStartTs": 1609462861000, 
	"rangeEndTs": 1630497968000, 
	"filters": {} 
}
```

其中

* `viewConfigId` - 应执行的视图 ID。必需参数
* `rangeStartTs` - 报告的开始时间范围（以毫秒为单位）。可选参数。如果为空，系统将从保存的视图中获取时间范围。
* `rangeEndTs` - 报告的结束时间范围（以毫秒为单位）。可选参数。如果为空，系统将从保存的视图中获取时间范围。
* `filters` - 覆盖保存的视图中的过滤器的自定义过滤器。可选参数。
* `jwt` - 用于请求身份验证的 JWT 令牌。

## 授权

所有请求都应包含用于授权的 jwt 令牌。它应作为查询参数或在 HTTP 头中添加。
在这两种情况下，参数名称都是 `jwt`。

您可以从 ThingsBoard Rest API 获取 JWT 令牌

请求：

```bash
curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{"username":"tenant@thingsboard.org", "password":"tenant"}' 'http://THINGSBOARD_URL/api/auth/login'
```

响应：

```json
{"token":"$YOUR_JWT_TOKEN", "refreshToken":"$YOUR_JWT_REFRESH_TOKEN"}
```

现在，您可以将 **$YOUR_JWT_TOKEN** 用作请求授权的 jwt 令牌。

## 响应格式

以下是一个响应示例：

```json
{
    "columnLabels": [
        "Building",
        "Date",
        "energyUsage"
    ],
    "dataTable": [
        {
            "Building": "Building ABC",
            "Date": "1606773600000",
            "energyUsage": 3.422654173312068
        },
        {
            "Building": "Building ABC",
            "Date": "1619816400000",
            "energyUsage": 9.189473684210526
        },
        {
            "Building": "Building XYZ",
            "Date": "1617224400000",
            "energyUsage": 7.015277777777778
        },
        {
            "Building": "Building XYZ",
            "Date": "1612130400000",
            "energyUsage": 6.513392857142857
        }
    ]
}
```

`columnLabels` - 包含报告中包含的字段标签。
`dataTable` - 以表格格式查看报告数据。

## 过滤器修改

在已配置的视图具有过滤器字段的情况下，您可以在请求期间修改过滤器选项。您应将 `fitlers` 字段添加到请求正文中。
以下是一个示例：

```json
{
	"viewConfigId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
	"filters": {
		"building": ["Building ABC"],
		"apartment": ["Apt 101", "Apt 407"]
	}
}
```

过滤器对象内的键应与视图中的过滤器名称匹配，值包含应应用于过滤器字段的值数组。


## 在自定义 ThingsBoard 小部件中使用

如果您需要具有特定逻辑的自定义小部件，则可以使用 Trendz Rest API 加载所需数据，并使用 ThingsBoard 自定义小部件功能创建所需的视觉效果。
以下是一个示例，描述了如何从 Trendz API 加载数据、应用仪表板时间以及从小部件数据源设置过滤器值。

```javascript
self.onInit = function() {
    
    let requestObj = buildTrendzRequest("edee0e57-41b9-4df3-acdb-08900cf53653", false, 'building');
    loadDataFromTrendz(requestObj)
        .subscribe(
            data => console.log('ok data', data),
            err => console.log('something wrong', err)
        );
}

self.onDataUpdated = function() {
    let requestObj = buildTrendzRequest("edee0e57-41b9-4df3-acdb-08900cf53653", false, 'building');
    
    loadDataFromTrendz(requestObj)
        .subscribe(
            data => console.log('ok data', data),
            err => console.log('something wrong', err)
        );
}

function buildTrendzRequest(viewId, useDashobardTime, fitlerKey) {
    let requestObj = {};
    
    requestObj.viewConfigId = viewId;
    
    if(useDashobardTime) {
        applyDashboardTime(requestObj);
    }
    
    applyFilters(requestObj, fitlerKey);
    
    return requestObj;
}

function applyFilters(requestObj, key) {
    let filterValues = getAliasValues();
    if(filterValues.length) {
        requestObj.filters = {};
        requestObj.filters[key] = filterValues;
    }
}

function applyDashboardTime(requestObj) {
    let timeWindow = $scope.ctx.dashboard.dashboardTimewindow;
    if (timeWindow.realtime) {
        requestObj.rangeStartTs = Date.now() - timeWindow.realtime.timewindowMs;
        requestObj.rangeEndTs = Date.now();
    } else if (timeWindow.history) {
        if (timeWindow.history.fixedTimewindow && timeWindow.history.historyType === 1) {
            requestObj.rangeStartTs = timeWindow.history.fixedTimewindow.startTimeMs;
            requestObj.rangeEndTs = timeWindow.history.fixedTimewindow.endTimeMs;
        } else if (timeWindow.history.timewindowMs && timeWindow.history.historyType === 0) {
            requestObj.rangeStartTs = Date.now() - timeWindow.history.timewindowMs;
            requestObj.rangeEndTs = Date.now();
        }
    }
}

function loadDataFromTrendz(requestObj) {
    let trendzDomain = 'http://localhost:8888';
    let dataUrl = trendzDomain + '/apiTrendz/publicApi/buildReport?jwt=' + getToken();
    return self.ctx.http.post(dataUrl, requestObj);
}

function getAliasValues() {
    let filterValues = [];
    if(self.ctx && self.ctx.defaultSubscription && self.ctx.defaultSubscription.data && self.ctx.defaultSubscription.data.length > 0) {
        for(let i = 0; i<self.ctx.defaultSubscription.data.length; i++ ) {
            let value = getDescendantProp(self.ctx.defaultSubscription.data[i], 'data.0.1');
            if (value && value !== 'Unresolved') {
                filterValues.push(value);
            }
        }
    }
    return filterValues;
}

function getDescendantProp(obj, path) {
    return path.split('.').reduce((acc, part) => acc && acc[part], obj)
}

function getToken() {
    let jwtToken = localStorage.getItem('jwt_token');
    if(jwtToken) {
        jwtToken = jwtToken.replace(/"/g, '');
    }
    
    return jwtToken;
}

self.onResize = function() {

}

self.onDestroy = function() {
}

```

* `self.onInit` - 标准 ThingsBoard 小部件生命周期事件。在小部件首次初始化时调用。
* `self.onDataUpdated` - 标准 ThingsBoard 小部件生命周期事件。在小部件数据源或别名更新时调用。
* `buildTrendzRequest` - 初始化到 Trendz API 的请求对象。如果需要，从仪表板时间窗口设置时间范围。为请求设置过滤器。
* `applyFilters` - 从数据源读取数据并将其作为 Trendz API 请求的过滤器应用。
* `applyDashboardTime` - 将仪表板时间窗口中的时间范围应用于 Trendz API 请求。
* `loadDataFromTrendz` - 添加 jwt 令牌并执行对 API 的实际请求。
* `loadDataFromTrendz` - 添加 jwt 令牌并执行对 API 的实际请求。

如果您需要有关创建自定义小部件的帮助，请联系我们，我们将提供帮助。

## 限制

Trendz Rest API 有 2 个可配置限制：

* `SIMPLE_API_RATE_LIMITER_QUEUE_CAPACITY` - 等待执行的排队请求的最大数量。
如果收到更多请求，系统将拒绝它们。默认队列大小为 10 个请求。
* `SIMPLE_API_RATE_LIMITER_THREAD_POOL_SIZE` - 并行执行的请求数量。

## 可能的响应代码

* `403` - JWT 令牌无效或已过期。
* `415` - 不支持的媒体类型。在这种情况下，您应将 HTTP 请求中的 `Content-Type` 头设置为 **application/json**
* `429` - 请求过多。达到 API 限制。您需要等待并重复请求或更改 Trendz 配置中的 API 限制。