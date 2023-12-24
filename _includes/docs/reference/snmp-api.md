* TOC
{:toc}

### SNMP 基础知识

简单网络管理协议 (SNMP) 是一种用于从受管设备收集信息并发送信息以修改这些设备行为的 Internet 标准协议。

SNMP 架构由 SNMP 管理器和 SNMP 代理组成。SNMP 代理是在连接到网络的设备上运行的程序。SNMP 代理将受管系统上的管理数据作为变量公开。可通过 SNMP 访问的变量按层次结构组织。这些层次结构被描述为管理信息库 (MIB)。MIB 描述设备子系统的管理数据的结构；它们使用包含对象标识符 (OID) 的分层命名空间。每个 OID 标识一个可通过 SNMP 读写或设置的变量。代理从 MIB 获取信息，并在查询后将其传递给 SNMP 管理器。SNMP 管理器是一个负责与连接的 SNMP 代理通信的系统。SNMP 管理器查询代理，接收代理的响应并设置代理变量。ThingsBoard SNMP 传输充当管理器。管理器和代理之间的关系基于消息和命令。传输使用的命令类型为“GET”和“SET”。每个 SNMP 消息都包含一个协议数据单元 (PDU)。

SNMP 在 Internet 协议套件的应用层中运行。SNMP 消息可以通过用户数据报协议 (UDP) 或传输控制协议 (TCP) 传输：您可以通过 `SNMP_UNDERLYING_PROTOCOL` 环境变量配置此项。

已经开发并部署了三个重要的 SNMP 版本。SNMP v1 是该协议的原始版本。较新版本 SNMP v2c 和 SNMP v3 在性能、灵活性和安全性方面进行了改进。ThingsBoard 支持所有这些版本。

### 设备配置文件配置

首先，您应该配置 SNMP 设备配置文件：指定请求超时（确认请求重新发送或超时之前的超时时间（以毫秒为单位））、重试次数（在请求超时之前执行）以及主要部分 - 通信配置。

以下是一个设备配置文件配置示例：

{% include images-gallery.html imageCollection="deviceProfileConfiguring1" %}

稍后，在查看 SNMP 设备配置后，我们将讨论可能的配置类型。

### 设备配置

无论您的 SNMP 设备的版本如何，您都必须指定主机和端口。

至于 SNMP 中的安全性，SNMP v1 和 v2c 以明文形式通过网络发送密码（团体字符串），而 SNMP v3 支持身份验证和数据加密。

因此，对于版本 1 和 2c，您必须设置团体字符串。此类 SNMP 设备的配置示例：

{% include images-gallery.html imageCollection="deviceConfiguring1" %}

让我们进一步了解 SNMP 的第三个版本。ThingsBoard 使用“authPriv”安全级别，它支持身份验证和加密。使用的安全模型是 USM（基于用户的安全模型）。

除了主机和端口外，您还需要为 SNMP v3 设备配置以下属性：

- 用户名
- 安全名称
- 上下文名称
- 身份验证协议（基本上是用于对身份验证密码进行哈希处理的哈希函数的名称；支持的协议有 SHA-1、SHA-224/256/384/512 和 MD5）
- 身份验证密码
- 隐私协议（数据加密算法；支持 DES（CBC 模式）和 AES-128/192/256）
- 隐私密码
- 引擎 ID

以下是一个版本 3 配置示例：

{% include images-gallery.html imageCollection="deviceConfiguring2" %}

### 遥测

如前所述，您的 SNMP 设备配置文件配置中应该有一些通信配置，并且对于遥测查询，您也需要一个。对于此类配置，您必须指定一些映射和查询频率。需要映射以便我们可以在将其解析为指定的数据类型后将接收到的 OID 值映射到特定的遥测密钥。

以下是一个示例：

{% include images-gallery.html imageCollection="deviceProfileConfiguring2" %}

顺便说一下，支持的数据类型有：`LONG`、`DOUBLE`、`BOOLEAN` 和 `STRING`（对于 SNMP，配置的数据类型为 `JSON` 的接收变量值将被视为常规字符串）。

对于此查询配置和其他查询配置，正在使用的方法类型是 `GET`。

### 属性

#### 客户端属性

要设置 SNMP 设备属性的查询，您可以添加另一个通信配置。此配置与遥测配置相同，应包含映射和所需的查询频率。

一个示例：

{% include images-gallery.html imageCollection="deviceProfileConfiguring3" %}

#### 共享属性

为了使您的 SNMP 设备接收某些共享属性的更新，您可以在 SNMP 设备配置文件中添加另一个通信配置：

{% include images-gallery.html imageCollection="deviceProfileConfiguring4" %}

对于此配置，您只需要配置映射：将更新的共享属性值设置为哪个 OID。在这种情况下，映射中的键是共享属性的名称。顺便说一下，使用的 SNMP 方法是 `SET`。

对于此类配置（以及其他使用 `SET` 类型 SNMP 方法的配置），需要数据类型来决定在 PDU 中发送哪种类型的 SNMP 变量。对于 `LONG` 数据类型，我们使用 `INTEGER`（或 `Integer32`，一个有符号的 32 位整数），对于所有其他数据类型，我们使用 `OCTET STRING`。

### 服务器端 RPC

要发送自定义 SNMP 请求，您可以使用 RPC 功能。首先，您应该在设备配置文件中配置一些密钥映射以在 RPC 命令中使用：

{% include images-gallery.html imageCollection="deviceProfileConfiguring5" %}

之后，我们可以在 RPC 命令中使用已配置映射的键：

```json
{
  "method": "GET",
  "params": {
    "key": "systemInfo"
  }
}
```

如您所见，对于“method”字段，您必须指定 SNMP 方法类型：`GET` 或 `SET`。对于此方法，我们将向 OID “1.2.3.0.9.2.8.1”发送“GET”SNMP 请求，并将响应解析为字符串，然后按照以下格式将其路由到下一个规则节点：

```json
{
  "systemInfo": "SNMP device"
}
```

以下是一个“SET”RPC 命令的示例：

```json
{
  "method": "SET",
  "params": {
    "key": "lastUpdateTime",
    "value": "12901200312"
  }
}
```

在这种情况下，我们将向映射中配置的 OID（“1.2.3.0.6.4.3.1”）发送“SET”SNMP 请求，其值是“12901200312”，为 OCTET STRING。

请注意，对于“SET”请求，您必须在 RPC 命令中指定某个值。

### 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}