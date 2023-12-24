---
layout: docwithnav
assignees:
- ashvayka
title: REST 客户端
description: 受支持的 REST API 参考，用于服务器端集成 Java 项目

---
 * 目录
 {:toc}
 
## REST 客户端

ThingsBoard REST API 客户端可帮助您通过 Java 应用程序与 ThingsBoard REST API 进行交互。
使用 Rest 客户端，您可以以编程方式在 GridLinks 中创建资产、设备、客户、用户和其他实体及其关系。
 
安装 Rest 客户端的推荐方法是使用构建自动化工具，例如 Maven。
REST 客户端的版本取决于您使用的平台版本。   
  
## 社区版 REST 客户端

为了将 REST 客户端添加到您的 Maven/Gradle 项目，您应该使用以下依赖项：
 
```xml
<dependencies>
    <dependency>
        <groupId>org.thingsboard</groupId>
        <artifactId>rest-client</artifactId>
        <version>{{ site.release.ce_full_ver}}</version>
    </dependency>
</dependencies>
```
{: .copy-code}

注意：REST 客户端构建在 Spring RestTemplate 之上，因此依赖于 Spring Web（在撰写本文时为 5.1.5.RELEASE）。

为了下载 REST 客户端依赖项，您应该将以下存储库添加到您的项目中。或者，您可以从 [sources](https://github.com/thingsboard/thingsboard/tree/master/rest-client) 构建 REST 客户端。

```xml
<repositories>
    <repository>
        <id>thingsboard</id>
        <url>https://repo.thingsboard.io/artifactory/libs-release-public</url>
    </repository>
</repositories>
```
{: .copy-code}
### 基本用法

以下示例代码演示了如何实例化 ThingsBoard 客户端、执行登录并获取当前登录用户的用户详细信息。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 默认租户管理员凭据
String username = "tenant@gridlinks.com";
String password = "tenant";

// 创建新的 rest 客户端并使用凭据进行身份验证
RestClient client = new RestClient(url);
client.login(username, password);

// 获取当前登录用户的详细信息并打印它
client.getUser().ifPresent(System.out::println);

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

### 示例

#### 获取租户设备
以下示例代码演示了如何通过页面链接获取租户设备。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 默认租户管理员凭据
String username = "tenant@gridlinks.com";
String password = "tenant";

// 创建新的 rest 客户端并使用凭据进行身份验证
RestClient client = new RestClient(url);
client.login(username, password);

PageData<Device> tenantDevices;
PageLink pageLink = new PageLink(10);
do {
    // 使用当前页面链接获取所有租户设备并打印每个设备
    tenantDevices = client.getTenantDevices("", pageLink);
    tenantDevices.getData().forEach(System.out::println);
    pageLink = pageLink.nextPageLink();
} while (tenantDevices.hasNext());

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 获取租户仪表板
以下示例代码演示了如何通过页面链接获取租户仪表板。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 默认租户管理员凭据
String username = "tenant@gridlinks.com";
String password = "tenant";

// 创建新的 rest 客户端并使用凭据进行身份验证
RestClient client = new RestClient(url);
client.login(username, password);

PageData<DashboardInfo> pageData;
PageLink pageLink = new PageLink(10);
do {
    // 使用当前页面链接获取所有租户仪表板并打印每个仪表板
    pageData = client.getTenantDashboards(pageLink);
    pageData.getData().forEach(System.out::println);
    pageLink = pageLink.nextPageLink();
} while (pageData.hasNext());

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 获取客户设备
以下示例代码演示了如何通过页面链接获取客户设备。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";
// 使用默认客户用户凭据登录
String username = "customer@gridlinks.com";
String password = "customer";
RestClient client = new RestClient(url);
client.login(username, password);

PageData<Device> pageData;
PageLink pageLink = new PageLink(10);
do {
    // 获取当前用户
    User user = client.getUser().orElseThrow(() -> new IllegalStateException("No logged in user has been found"));
    // 使用当前页面链接获取客户设备
    pageData = client.getCustomerDevices(user.getCustomerId(), "", pageLink);
    pageData.getData().forEach(System.out::println);
    pageLink = pageLink.nextPageLink();
} while (pageData.hasNext());

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 使用实体数据查询 API 计数实体

以下示例代码演示了如何使用实体数据查询 API 来计算总设备数、总活动设备数。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@gridlinks.com";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);

// 创建实体过滤器以获取所有设备
EntityTypeFilter typeFilter = new EntityTypeFilter();
typeFilter.setEntityType(EntityType.DEVICE);

// 使用提供的过滤器创建实体计数查询
EntityCountQuery totalDevicesQuery = new EntityCountQuery(typeFilter);

// 执行实体计数查询并获取总设备数
Long totalDevicesCount = client.countEntitiesByQuery(totalDevicesQuery);
System.out.println("第一个查询的总设备数：" + totalDevicesCount);

// 将键过滤器设置为现有查询以仅获取活动设备
KeyFilter keyFilter = new KeyFilter();
keyFilter.setKey(new EntityKey(EntityKeyType.ATTRIBUTE, "active"));
keyFilter.setValueType(EntityKeyValueType.BOOLEAN);

BooleanFilterPredicate filterPredicate = new BooleanFilterPredicate();
filterPredicate.setOperation(BooleanFilterPredicate.BooleanOperation.EQUAL);
filterPredicate.setValue(new FilterPredicateValue<>(true));
        
keyFilter.setPredicate(filterPredicate);

// 使用提供的过滤器创建实体计数查询
EntityCountQuery totalActiveDevicesQuery = 
        new EntityCountQuery(typeFilter, List.of(keyFilter));
        
// 执行活动设备查询并打印总设备数
Long totalActiveDevicesCount = client.countEntitiesByQuery(totalActiveDevicesQuery);
System.out.println("第二个查询的总设备数：" + totalActiveDevicesCount);
        
// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 使用实体数据查询 API 查询实体
以下示例代码演示了如何使用实体数据查询 API 来获取所有活动设备。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@gridlinks.com";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);

// 创建实体过滤器以仅获取设备
EntityTypeFilter typeFilter = new EntityTypeFilter();
typeFilter.setEntityType(EntityType.DEVICE);

// 创建键过滤器以仅查询活动设备
KeyFilter keyFilter = new KeyFilter();
keyFilter.setKey(new EntityKey(EntityKeyType.ATTRIBUTE, "active"));
keyFilter.setValueType(EntityKeyValueType.BOOLEAN);

BooleanFilterPredicate filterPredicate = new BooleanFilterPredicate();
filterPredicate.setOperation(BooleanFilterPredicate.BooleanOperation.EQUAL);
filterPredicate.setValue(new FilterPredicateValue<>(true));

keyFilter.setPredicate(filterPredicate);

// 准备要查询的设备字段列表
List<EntityKey> fields = List.of(
        new EntityKey(EntityKeyType.ENTITY_FIELD, "name"),
        new EntityKey(EntityKeyType.ENTITY_FIELD, "type"),
        new EntityKey(EntityKeyType.ENTITY_FIELD, "createdTime")
);

// 准备要查询的设备属性列表
List<EntityKey> attributes = List.of(
        new EntityKey(EntityKeyType.ATTRIBUTE, "active")
);

// 准备页面链接
EntityDataSortOrder sortOrder = new EntityDataSortOrder();
sortOrder.setKey(new EntityKey(EntityKeyType.ENTITY_FIELD, "createdTime"));
sortOrder.setDirection(EntityDataSortOrder.Direction.DESC);
EntityDataPageLink entityDataPageLink = new EntityDataPageLink(10, 0, "", sortOrder);

// 使用提供的实体过滤器、键过滤器、查询字段和页面链接创建实体查询
EntityDataQuery dataQuery = 
        new EntityDataQuery(typeFilter, entityDataPageLink, fields, attributes, List.of(keyFilter));

PageData<EntityData> entityPageData;
do {
    // 使用实体查询获取活动设备并打印它们
    entityPageData = client.findEntityDataByQuery(dataQuery);
    entityPageData.getData().forEach(System.out::println);
    dataQuery = dataQuery.next();
} while (entityPageData.hasNext());

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 设备管理示例

以下示例代码演示了设备管理 API 的基本概念（添加/获取/删除设备、获取/保存设备属性）。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@gridlinks.com";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);

// 构建设备对象
String newDeviceName = "Test Device";
Device newDevice = new Device();
newDevice.setName(newDeviceName);

// 创建 Json 对象节点并将其设置为附加信息
ObjectMapper mapper = new ObjectMapper();
ObjectNode additionalInfoNode = mapper.createObjectNode().put("description", "My brand new device");
newDevice.setAdditionalInfo(additionalInfoNode);

// 保存设备
Device savedDevice = client.saveDevice(newDevice);
System.out.println("Saved device: " + savedDevice);

// 通过设备 ID 查找设备，否则抛出异常
Optional<DeviceInfo> optionalDevice = client.getDeviceInfoById(savedDevice.getId());
DeviceInfo foundDevice = optionalDevice
        .orElseThrow(() -> new IllegalArgumentException("Device with id " + newDevice.getId().getId() + " hasn't been found"));

// 保存设备共享属性
ObjectNode requestNode = mapper.createObjectNode().put("temperature", 22.4).put("humidity", 57.4);
boolean isSuccessful = client.saveEntityAttributesV2(foundDevice.getId(), "SHARED_SCOPE", requestNode);
System.out.println("Attributes have been successfully saved: " + isSuccessful);

// 获取设备共享属性
var attributes = client.getAttributesByScope(foundDevice.getId(), "SHARED_SCOPE", List.of("temperature", "humidity"));
System.out.println("Found attributes: ");
attributes.forEach(System.out::println);

// 删除设备
client.deleteDevice(savedDevice.getId());

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 更多示例
你可以找到学习如何使用 GridLinks REST 客户端的示例 **[此处](https://github.com/thingsboard/tb-ce-rest-client-example)**。