---
layout: docwithnav
title: Dart API 客户端
description: GridLinks API 客户端库，适用于 Dart 开发人员

---
 * 目录
 {:toc}

## 概述

[Dart GridLinks API 客户端](https://pub.dev/packages/thingsboard_client) 包是一个 [Dart](https://dart.dev/) 库，
提供模型对象和服务，用于通过 [RESTful API](/docs/reference/rest-api/) 和 WebSocket 协议与 GridLinks 平台进行通信。
使用 Dart 客户端，您可以以编程方式访问 GridLinks API 来管理 [实体](/docs/user-guide/entities-and-relations/)，
查询 [遥测数据](/docs/user-guide/telemetry/) 并通过 [WebSocket API](/docs/user-guide/telemetry/#websocket-api) 获取实时更新。
Dart GridLinks API 客户端也是 GridLinks 移动应用程序的一部分。

Dart GridLinks API 客户端的版本取决于您使用的平台版本。

## 安装 Dart GridLinks API 客户端（社区版）

要在您的 Dart/Flutter 项目中使用 Dart GridLinks API 客户端包，请运行此命令：

使用 Dart：

```bash
dart pub add thingsboard_client
```
{: .copy-code}

使用 Flutter：

```bash
flutter pub add thingsboard_client
```
{: .copy-code}

这会将类似这样的行添加到您的 package 的 pubspec.yaml（并运行隐式 `dart pub get`）：

```yaml
dependencies:
  thingsboard_client: ^1.0.7
```
{: .copy-code}

或者，您的编辑器可能支持 `dart pub get` 或 `flutter pub get`。查看您编辑器的文档以了解更多信息。

现在，在您的 Dart 代码中，您可以使用：

```dart
import 'package:thingsboard_client/thingsboard_client.dart';
```
{: .copy-code}

### 基本用法

以下示例代码演示了如何实例化 GridLinks 客户端、执行登录并获取当前登录用户的用户详细信息。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    print('isAuthenticated=${tbClient.isAuthenticated()}');

    print('authUser: ${tbClient.getAuthUser()}');

    // 获取当前登录用户的用户详细信息
    var currentUserDetails = await tbClient.getUserService().getUser();
    print('currentUserDetails: $currentUserDetails');

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

### 示例

#### 获取租户设备

以下示例代码演示了如何通过页面链接获取租户设备。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    var pageLink = PageLink(10);
    PageData<DeviceInfo> devices;
    do {
        // 使用当前页面链接获取租户设备
        devices = await tbClient.getDeviceService().getTenantDeviceInfos(pageLink);
        print('devices: $devices');
        pageLink = pageLink.nextPageLink();
    } while (devices.hasNext);

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 获取租户仪表板

以下示例代码演示了如何通过页面链接获取租户仪表板。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    var pageLink = PageLink(10);
    PageData<DashboardInfo> dashboards;
    do {
        // 使用当前页面链接获取租户仪表板
        dashboards = await tbClient.getDashboardService().getTenantDashboards(pageLink);
        print('dashboards: $dashboards');
        pageLink = pageLink.nextPageLink();
    } while (devices.hasNext);

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 获取客户设备

以下示例代码演示了如何通过页面链接获取客户设备。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认客户用户凭据执行登录
    await tbClient.login(LoginRequest('customer@gridlinks.com', 'customer'));

    var pageLink = PageLink(10);
    PageData<DeviceInfo> devices;
    do {
        // 使用当前页面链接获取客户设备
        devices = await tbClient
                .getDeviceService()
                .getCustomerDeviceInfos(tbClient.getAuthUser()!.customerId, pageLink);
        print('devices: $devices');
        pageLink = pageLink.nextPageLink();
    } while (devices.hasNext);

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 使用实体数据查询 API 统计实体

以下示例代码演示了如何使用实体数据查询 API 来统计设备总数、活动设备总数和非活动设备总数。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    // 创建实体过滤器以获取所有设备
    var entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

    // 创建实体计数查询，其中包含提供的过滤器
    var devicesQuery = EntityCountQuery(entityFilter: entityFilter);

    // 执行实体计数查询并获取设备总数
    var totalDevicesCount =
        await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
    print('Total devices: $totalDevicesCount');

    // 将键过滤器设置为现有查询以仅获取活动设备
    var activeDeviceKeyFilter = KeyFilter(
      key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
      valueType: EntityKeyValueType.BOOLEAN,
      predicate: BooleanFilterPredicate(
          operation: BooleanOperation.EQUAL,
          value: FilterPredicateValue(true)));
    devicesQuery.keyFilters = [activeDeviceKeyFilter];

    // 执行实体计数查询并获取活动设备总数
    var activeDevicesCount =
      await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
    print('Active devices: $activeDevicesCount');

    // 将键过滤器设置为现有查询以仅获取非活动设备
    var inactiveDeviceKeyFilter = KeyFilter(
      key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
      valueType: EntityKeyValueType.BOOLEAN,
      predicate: BooleanFilterPredicate(
          operation: BooleanOperation.EQUAL,
          value: FilterPredicateValue(false)));
    devicesQuery.keyFilters = [inactiveDeviceKeyFilter];

    // 执行实体计数查询并获取非活动设备总数
    var inactiveDevicesCount =
      await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
    print('Inactive devices: $inactiveDevicesCount');

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 使用实体数据查询 API 查询实体

以下示例代码演示了如何使用实体数据查询 API 来获取所有活动设备。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    // 创建实体过滤器以仅获取设备
    var entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

    // 创建键过滤器以仅查询活动设备
    var activeDeviceKeyFilter = KeyFilter(
        key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
        valueType: EntityKeyValueType.BOOLEAN,
        predicate: BooleanFilterPredicate(
            operation: BooleanOperation.EQUAL,
            value: FilterPredicateValue(true)));

    // 准备查询的设备字段列表
    var deviceFields = <EntityKey>[
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'name'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'type'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime')
    ];

    // 准备查询的设备属性列表
    var deviceAttributes = <EntityKey>[
      EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active')
    ];

    // 创建实体查询，其中包含提供的实体过滤器、键过滤器、查询的字段和页面链接
    var devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        keyFilters: [inactiveDeviceKeyFilter],
        entityFields: deviceFields,
        latestValues: deviceAttributes,
        pageLink: EntityDataPageLink(
            pageSize: 10,
            sortOrder: EntityDataSortOrder(
                key: EntityKey(
                    type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
                direction: EntityDataSortOrderDirection.DESC)));

      PageData<EntityData> devices;
      do {
        // 使用当前页面链接获取活动设备
        devices = await tbClient
            .getEntityQueryService()
            .findEntityDataByQuery(devicesQuery);
        print('Active devices entities data:');
        devices.data.forEach((device) {
          print(
              'id: ${device.entityId.id}, createdTime: ${device.createdTime}, name: ${device.field('name')!}, type: ${device.field('type')!}, active: ${device.attribute('active')}');
        });
        devicesQuery = devicesQuery.next();
      } while (devices.hasNext);

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 设备管理示例

以下示例代码演示了设备管理 API 的基本概念（添加/获取/删除设备、获取/保存设备属性）。

```dart
import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    var deviceName = 'My test device';

    // 构建设备对象
    var device = Device(deviceName, 'default');
    device.additionalInfo = {'description': 'My test device!'};

    // 添加设备
    var savedDevice = await tbClient.getDeviceService().saveDevice(device);
    print('savedDevice: $savedDevice');

    // 按设备 ID 查找设备
    var foundDevice =
       await tbClient.getDeviceService().getDeviceInfo(savedDevice.id!.id!);
    print('foundDevice: $foundDevice');

    // 保存设备共享属性
    var res = await tbClient.getAttributeService().saveEntityAttributesV2(
      foundDevice!.id!,
      AttributeScope.SHARED_SCOPE.toShortString(),
      {'targetTemperature': 22.4, 'targetHumidity': 57.8});
    print('Save attributes result: $res');

    // 获取设备共享属性
    var attributes = await tbClient.getAttributeService().getAttributesByScope(
      foundDevice.id!,
      AttributeScope.SHARED_SCOPE.toShortString(),
      ['targetTemperature', 'targetHumidity']);
    print('Found device attributes: $attributes');

    // 删除设备
    await tbClient.getDeviceService().deleteDevice(savedDevice.id!.id!);

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### WebSocket API 示例

以下示例代码演示了 WebSocket API 的基本概念。在此代码中，我们将创建一个新设备，
创建订阅以使用实体数据查询 API 通过 WebSocket API 获取设备数据和遥测更新。
最后，通过侦听订阅的数据流来发布示例遥测并获取数据更新。

```dart
import 'dart:math';

import 'package:thingsboard_client/thingsboard_client.dart';

// GridLinks REST API URL
const thingsBoardApiEndpoint = 'http://localhost:8080';

void main() async {
  try {

    // 创建 GridLinks API 客户端实例
    var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // 使用默认租户管理员凭据执行登录
    await tbClient.login(LoginRequest('tenant@gridlinks.com', 'tenant'));

    var deviceName = 'My test device';

    // 构建设备对象
    var device = Device(deviceName, 'default');
    device.additionalInfo = {'description': 'My test device!'};

    // 添加设备
    var savedDevice = await tbClient.getDeviceService().saveDevice(device);
    print('savedDevice: $savedDevice');

    // 创建实体过滤器以按其名称获取设备
    var entityFilter = EntityNameFilter(
        entityType: EntityType.DEVICE, entityNameFilter: deviceName);

    // 准备查询的设备字段列表
    var deviceFields = <EntityKey>[
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'name'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'type'),
      EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime')
    ];

    // 准备查询的设备时序列表
    var deviceTelemetry = <EntityKey>[
      EntityKey(type: EntityKeyType.TIME_SERIES, key: 'temperature'),
      EntityKey(type: EntityKeyType.TIME_SERIES, key: 'humidity')
    ];

    // 创建实体查询，其中包含提供的实体过滤器、查询的字段和页面链接
    var devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        entityFields: deviceFields,
        latestValues: deviceTelemetry,
        pageLink: EntityDataPageLink(
            pageSize: 10,
            sortOrder: EntityDataSortOrder(
                key: EntityKey(
                    type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
                direction: EntityDataSortOrderDirection.DESC)));

    // 创建时序订阅命令以获取过去一小时内“温度”和“湿度”键的数据，并进行实时更新
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var timeWindow = Duration(hours: 1).inMilliseconds;

    var tsCmd = TimeSeriesCmd(
        keys: ['temperature', 'humidity'],
        startTs: currentTime - timeWindow,
        timeWindow: timeWindow);

    // 创建订阅命令，其中包含实体查询和时序订阅
    var cmd = EntityDataCmd(query: devicesQuery, tsCmd: tsCmd);

    // 使用提供的订阅命令创建订阅
    var telemetryService = tbClient.getTelemetryService();
    var subscription = TelemetrySubscriber(telemetryService, [cmd]);

    // 创建侦听器以从 WebSocket 获取数据更新
    subscription.entityDataStream.listen((entityDataUpdate) {
      print('Received entity data update: $entityDataUpdate');
    });

    // 执行订阅（通过 WebSocket API 发送订阅命令并侦听响应）
    subscription.subscribe();

    // 发布示例遥测
    var rng = Random();
    for (var i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      var temperature = 10 + 20 * rng.nextDouble();
      var humidity = 30 + 40 * rng.nextDouble();
      var telemetryRequest = {'temperature': temperature, 'humidity': humidity};
      print('Save telemetry request: $telemetryRequest');
      var res = await tbClient
        .getAttributeService()
        .saveEntityTelemetry(savedDevice.id!, 'TELEMETRY', telemetryRequest);
      print('Save telemetry result: $res');
    }

    // 等待几秒钟以显示订阅侦听器接收数据更新
    await Future.delayed(Duration(seconds: 2));

    // 最后取消订阅以释放订阅
    subscription.unsubscribe();

    // 删除设备
    await tbClient.getDeviceService().deleteDevice(savedDevice.id!.id!);

    // 最后执行注销以清除凭据
    await tbClient.logout();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}
```
{: .copy-code}

#### 更多示例

您可以在 **[此处](https://github.com/thingsboard/dart_thingsboard_client/tree/master/example)** 找到更多示例，以了解如何使用 Dart GridLinks API 客户端。