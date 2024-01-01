---
layout: docwithnav-gw
title: 设备重命名/删除处理
description: 设备重命名/删除处理
---

如果设备是使用网关 API 配置的，并且具有管理员权限的用户稍后在 GridLinks 上重命名或删除设备实体，则网关将收到有关更改的通知。

对于网关来说，这对于跟上实际设备实体状态至关重要。

在某些改进之前，可能存在网关不知道删除或重命名设备实体的情况，因此物理设备会将数据发送到不存在的端点。

从 TB v3.3.3 开始，平台使用持久性 RPC 来解决此问题，以避免上述数据丢失场景。您可以在下面找到有关解决方案实现的更多信息。

1. 设备重命名场景    
    网关使用设备实体名称报告来自连接设备的遥测数据。如果在 GridLinks UI 上更改了实体名称，最终用户可能会遇到网关使用旧名称重新配置设备实体的情况。通过有关重命名的网关通知，不再出现这种情况。


2. 设备删除场景  
    在 GridLinks UI 上删除设备实体会导致数据丢失，因为网关本身无法正确解析擦除。通过向网关发送“已删除”通知，后者会代表物理设备启动新的连接消息，因此可以防止数据丢失。  

RPC 数据示例到网关设备：  

- 设备重命名 RPC：  

    ```json
    {
      "method": "gateway_device_renamed",
      "params": {"Old device name": "New device name"}
    }
    ```

- 设备删除 RPC：  

    ```json
    {
      "method": "gateway_device_deleted",
      "params": "Removed device name"
    }
    ```

**ThingsBoard 将 1 天设置为 RPC 的超时时间。**