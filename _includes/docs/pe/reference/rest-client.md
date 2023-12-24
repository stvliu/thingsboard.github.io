* TOC
{:toc}
 
## REST 客户端

ThingsBoard REST API 客户端可帮助您通过 Java 应用程序与 ThingsBoard REST API 进行交互。
使用 Rest 客户端，您可以以编程方式在 ThingsBoard 中创建资产、设备、客户、用户和其他实体及其关系。
 
安装 Rest 客户端的推荐方法是使用构建自动化工具，例如 Maven。
REST 客户端的版本取决于您正在使用的平台的版本。   
  
## 专业版 REST 客户端

要将 REST 客户端添加到您的 Maven/Gradle 项目，您应该使用以下依赖项：
 
```xml
<dependencies>
    <dependency>
        <groupId>org.thingsboard</groupId>
        <artifactId>rest-client</artifactId>
        <version>{{ site.release.pe_full_ver}}</version>
    </dependency>
</dependencies>
```

注意：REST 客户端构建在 Spring RestTemplate 之上，因此依赖于 Spring Web（在撰写本文时为 5.1.5.RELEASE）。

要下载 REST 客户端依赖项，您应该将以下存储库添加到您的项目。

```xml
<repositories>
    <repository>
        <id>thingsboard</id>
        <url>https://repo.thingsboard.io/artifactory/libs-release-public</url>
    </repository>
</repositories>
```

### 基本用法

以下示例代码演示了如何实例化 ThingsBoard 客户端、执行登录并获取当前登录用户的用户详细信息。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 默认租户管理员凭据
String username = "tenant@thingsboard.org";
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

#### 获取用户权限

以下示例代码演示了如何获取当前登录用户的允许权限，然后检查示例权限。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@thingsboard.org";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);

// 获取用户是否对设备实体具有通用读取权限
AllowedPermissionsInfo permissionsInfo = client.getAllowedPermissions().orElseThrow();
boolean hasDeviceReadPermission = 
        permissionsInfo.getUserPermissions().hasGenericPermission(Resource.DEVICE, Operation.READ);
System.out.println("具有通用设备读取权限：" + hasDeviceReadPermission);
        
// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```

#### 获取用户设备
以下示例代码演示了如何通过页面链接获取租户设备。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 默认租户管理员凭据
String username = "tenant@thingsboard.org";
String password = "tenant";

// 创建新的 rest 客户端并使用凭据进行身份验证
RestClient client = new RestClient(url);
client.login(username, password);

PageData<Device> tenantDevices;
PageLink pageLink = new PageLink(10);
do {
    // 使用当前页面链接获取所有租户设备并打印每个设备
    tenantDevices = client.getUserDevices("", pageLink);
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
String username = "tenant@thingsboard.org";
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

#### 获取实体组

以下示例代码演示了如何获取实体组。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@thingsboard.org";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);

// 遍历所有可用的实体组类型
for (EntityType type : EntityType.values()) {
    // 获取指定类型的全部实体组并打印它们
    List<EntityGroupInfo> entityGroupsByType = client.getEntityGroupsByType(type);
    entityGroupsByType.forEach(System.out::println);
}
        
// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 使用实体数据查询 API 统计实体

以下示例代码演示了如何使用实体数据查询 API 统计设备总数和活动设备总数。
```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@thingsboard.org";
String password = "tenant";
RestClient client = new RestClient(url);
client.login(username, password);

// 创建实体过滤器以获取所有设备
EntityTypeFilter typeFilter = new EntityTypeFilter();
typeFilter.setEntityType(EntityType.DEVICE);

// 使用提供的过滤器创建实体计数查询
EntityCountQuery totalDevicesQuery = new EntityCountQuery(typeFilter);

// 执行实体计数查询并获取设备总数
Long totalDevicesCount = client.countEntitiesByQuery(totalDevicesQuery);
System.out.println("第一个查询的设备总数：" + totalDevicesCount);

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
        
// 执行活动设备查询并打印设备总数
Long totalActiveDevicesCount = client.countEntitiesByQuery(totalActiveDevicesQuery);
System.out.println("第二个查询的设备总数：" + totalActiveDevicesCount);
        
// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

#### 使用实体数据查询 API 查询实体
以下示例代码演示了如何使用实体数据查询 API 获取所有活动设备。

```java
// ThingsBoard REST API URL
String url = "http://localhost:8080";

// 使用默认客户用户凭据登录
String username = "tenant@thingsboard.org";
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

// 准备查询的设备字段列表
List<EntityKey> fields = List.of(
        new EntityKey(EntityKeyType.ENTITY_FIELD, "name"),
        new EntityKey(EntityKeyType.ENTITY_FIELD, "type"),
        new EntityKey(EntityKeyType.ENTITY_FIELD, "createdTime")
);

// 准备查询的设备属性列表
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
String username = "tenantg@thingsboard.org";
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
System.out.println("已保存设备：" + savedDevice);

// 按设备 ID 查找设备，否则抛出异常
Optional<DeviceInfo> optionalDevice = client.getDeviceInfoById(savedDevice.getId());
DeviceInfo foundDevice = optionalDevice
        .orElseThrow(() -> new IllegalArgumentException("Device with id " + newDevice.getId().getId() + " hasn't been found"));

// 保存设备共享属性
ObjectNode requestNode = mapper.createObjectNode().put("temperature", 22.4).put("humidity", 57.4);
boolean isSuccessful = client.saveEntityAttributesV2(foundDevice.getId(), "SHARED_SCOPE", requestNode);
System.out.println("属性已成功保存：" + isSuccessful);

// 获取设备共享属性
var attributes = client.getAttributesByScope(foundDevice.getId(), "SHARED_SCOPE", List.of("temperature", "humidity"));
System.out.println("已找到属性：");
attributes.forEach(System.out::println);

// 删除设备
client.deleteDevice(savedDevice.getId());

// 执行当前用户的注销并关闭客户端
client.logout();
client.close();
```
{: .copy-code}

### 一些有用的代码片段

```java
// ThingsBoard REST API URL
final String url = "http://localhost:8080";

// 默认系统管理员凭据
final String username = "sysadmin@thingsboard.org";
final String password = "sysadmin";

// 创建新的 restClient 并使用系统管理员凭据进行身份验证
restClient = new RestClient(url);
login(username, password);

// 创建租户
Tenant tenant = new Tenant();
tenant.setTitle("Test Tenant");
tenant = restClient.saveTenant(tenant);

final String tenantUsername = "testtenant@thingsboard.org";
final String tenantPassword = "testtenant";

// 为租户创建用户
User tenantUser = new User();
tenantUser.setAuthority(Authority.TENANT_ADMIN);
tenantUser.setEmail(tenantUsername);
tenantUser.setTenantId(tenant.getId());

tenantUser = restClient.saveUser(tenantUser, false);
restClient.activateUser(tenantUser.getId(), tenantPassword);

// 使用租户登录
login(tenantUsername, tenantPassword);

// 从文件中加载小部件
Path widgetFilePath = Paths.get("src/main/resources/custom_widget.json");
JsonNode widgetJson = mapper.readTree(Files.readAllBytes(widgetFilePath));
loadWidget(widgetJson);

// 从文件中加载规则链
Path ruleChainFilePath = Paths.get("src/main/resources/rule_chain.json");
JsonNode ruleChainJson = mapper.readTree(Files.readAllBytes(ruleChainFilePath));
loadRuleChain(ruleChainJson, false);

// 在租户级别创建仪表板组
EntityGroup sharedDashboardsGroup = new EntityGroup();
sharedDashboardsGroup.setName("Shared Dashboards");
sharedDashboardsGroup.setType(EntityType.DASHBOARD);
sharedDashboardsGroup = restClient.saveEntityGroup(sharedDashboardsGroup);

// 从文件中加载仪表板
JsonNode dashboardJson = mapper.readTree(RestClientExample.class.getClassLoader().getResourceAsStream("watermeters.json"));
Dashboard dashboard = new Dashboard();
dashboard.setTitle(dashboardJson.get("title").asText());
dashboard.setConfiguration(dashboardJson.get("configuration"));
dashboard = restClient.saveDashboard(dashboard);

// 将仪表板添加到共享仪表板组
restClient.addEntitiesToEntityGroup(sharedDashboardsGroup.getId(), Collections.singletonList(dashboard.getId()));

// 创建客户 1
Customer customer1 = new Customer();
customer1.setTitle("Customer 1");
customer1 = restClient.saveCustomer(customer1);

Device waterMeter1 = new Device();
waterMeter1.setCustomerId(customer1.getId());
waterMeter1.setName("WaterMeter1");
waterMeter1.setType("waterMeter");
waterMeter1 = restClient.saveDevice(waterMeter1);

// 更新设备令牌
DeviceCredentials deviceCredentials = restClient.getDeviceCredentialsByDeviceId(waterMeter1.getId()).get();
deviceCredentials.setCredentialsId("new_device_token");
restClient.saveDeviceCredentials(deviceCredentials);

// 获取自动创建的“客户管理员”组。
EntityGroupInfo customer1Administrators = restClient.getEntityGroupInfoByOwnerAndNameAndType(customer1.getId(), EntityType.USER, "Customer Administrators").get();

// 创建只读角色
Role readOnlyRole = restClient.createGroupRole("Read-Only", Arrays.asList(Operation.READ, Operation.READ_ATTRIBUTES, Operation.READ_TELEMETRY, Operation.READ_CREDENTIALS));

// 将共享仪表板分配给客户 1 管理员
GroupPermission groupPermission = new GroupPermission();
groupPermission.setRoleId(readOnlyRole.getId());
groupPermission.setUserGroupId(customer1Administrators.getId());
groupPermission.setEntityGroupId(sharedDashboardsGroup.getId());
groupPermission.setEntityGroupType(sharedDashboardsGroup.getType());
groupPermission = restClient.saveGroupPermission(groupPermission);

// 使用租户“共享仪表板”组中的默认仪表板为客户 1 创建用户。
String userEmail = "user@thingsboard.org";
String userPassword = "secret";
User user = new User();
user.setAuthority(Authority.CUSTOMER_USER);
user.setCustomerId(customer1.getId());
user.setEmail(userEmail);
ObjectNode additionalInfo = mapper.createObjectNode();
additionalInfo.put("defaultDashboardId", dashboard.getId().toString());
additionalInfo.put("defaultDashboardFullscreen", false);
user.setAdditionalInfo(additionalInfo);
user = restClient.saveUser(user, false);
restClient.activateUser(user.getId(), userPassword);

restClient.addEntitiesToEntityGroup(customer1Administrators.getId(), Collections.singletonList(user.getId()));
```
您可以在 **[此处](https://github.com/thingsboard/tb-pe-rest-client-example)** 找到示例应用程序。