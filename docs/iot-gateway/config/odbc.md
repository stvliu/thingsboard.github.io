---
layout: docwithnav-gw
title: ODBC 连接器配置
description: GridLinks IoT 网关的 ODBC 支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks IoT 网关的 ODBC 连接器配置。
使用 [常规配置](/docs/iot-gateway/configuration/) 启用此连接器。
我们将在下面描述连接器配置文件。

<b>ODBC 连接器配置文件示例。</b>

{% capture odbcConf %}

{
  "connection": {
    "str": "Driver={PostgreSQL};Server=localhost;Port=5432;Database=thingsboard;Uid=postgres;Pwd=postgres;",
    "attributes": {
      "autocommit": true,
      "timeout": 0
    },
    "encoding": "utf-8",
    "decoding": {
      "char": "utf-8",
      "wchar": "utf-8",
      "metadata": "utf-16le"
    },
    "reconnect": true,
    "reconnectPeriod": 60
  },
  "pyodbc": {
    "pooling": false
  },
  "polling": {
    "query": "SELECT bool_v, str_v, dbl_v, long_v, entity_id, ts FROM ts_kv WHERE ts > ? ORDER BY ts ASC LIMIT 10",
    "period": 5,
    "iterator": {
      "column": "ts",
      "query": "SELECT MIN(ts) - 1 FROM ts_kv",
      "save": false
    }
  },
  "mapping": {
    "device": {
      "type": "postgres",
      "name": "'ODBC ' + entity_id"
    },
    "sendDataOnlyOnChange": false,
    "attributes": "*",
    "timeseries": [
      "ts",
      {
        "name": "value",
        "value": "[i for i in [str_v, long_v, dbl_v,bool_v] if i is not None][0]"
      }
    ]
  },
  "serverSideRpc": {
    "enableUnknownRpc": true,
    "methods": [
      "procedureOne",
      {
        "name": "procedureTwo",
        "args": [ "One", 2, 3.0 ]
      }
    ]
  }
}

{% endcapture %}
{% include code-toggle.liquid code=odbcConf params="conf|.copy-code.expandable-20" %}

## 先决条件

要安装并使 ODBC 连接器正常工作，需要执行以下几个步骤：

1. 为 Windows 安装 [Visual C++ Redistributable 包](https://github.com/mkleehammer/pyodbc/wiki/Install#installing-on-windows) 或为 Linux 安装 [ODBC 包](https://github.com/mkleehammer/pyodbc/wiki/Install#installing-on-linux)。
2. 为 GridLinks 网关需要连接的数据库安装 ODBC 驱动程序。
3. 在 Windows 上的 [ODBC 数据源管理器](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/open-the-odbc-data-source-administrator) 中添加数据源，或在 Unix 系统上将驱动程序信息（名称、库路径等）添加到 ODBC 配置文件 [odbcinst.ini](https://github.com/mkleehammer/pyodbc/wiki/Drivers-and-Driver-Managers#odbc-configuration-files-unix-only) 中。

## “connection”部分

此 **强制性** 部分提供有关如何连接或重新连接到 ODBC 数据库的信息。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| **str** | | 数据库 [连接字符串](https://www.connectionstrings.com)。 |
| attributes | | 连接 [属性](https://github.com/mkleehammer/pyodbc/wiki/Connection#connection-attributes)。 |
| encoding | **utf-16** | 将字符串数据写入数据库时使用的编码。 |
| decoding | | 从数据库读取字符串数据时使用的编码配置。 |
| reconnect | **true** | 在捕获数据库错误后是否重新连接。 |
| reconnectPeriod | **60.0** | 重新连接尝试之间的间隔（以秒为单位）。浮点数表示比秒更精确的时间。 |

**注意**：有关编码/解码的更多信息，请阅读 [此处](https://github.com/mkleehammer/pyodbc/wiki/Unicode)。

### “attributes”小节

此 **可选** 小节提供了 [多个选项](https://github.com/mkleehammer/pyodbc/wiki/Connection#connection-attributes) 来调整连接过程。

### “decoding”小节

此 **可选** 小节提供了有关如何解码从数据库读取的字符串数据和元数据的信息。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| char | **utf-16** | 从数据库读取字符串数据时使用的编码。 |
| wchar | **utf-16** | 从数据库读取 Unicode 字符串数据时使用的编码。 |
| metadata | **utf-16** | 从数据库读取元数据时使用的编码。 |

**注意**：有关编码/解码的更多信息，请阅读 [此处](https://github.com/mkleehammer/pyodbc/wiki/Unicode)。

## “pyodbc”部分

此 **可选** 部分提供了 [选项](https://github.com/mkleehammer/pyodbc/wiki/The-pyodbc-Module#pyodbc-attributes) 来调整在 ODBC 连接器内部工作的 *pyodbc* Python 库。

```json
"pyodbc": {
  "pooling": false,
  "native_uuid": true
},
```

## “converter”属性

ODBC 连接器提供了内置的上行数据转换器。可以在此 **可选** 属性中指定自定义转换器类。

```json
"converter": "CustomOdbcUplinkConverter",
```

## “polling”部分

ODBC 连接器的主要思想是定期查询 ODBC 数据库是否出现新数据。

此 **强制性** 部分提供了有关查询数据库的频率、要选择的数据以及用于迭代结果的数据库列的信息。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| query | | 从数据库获取数据的 SQL 选择查询。 |
| period | **60.0** | 轮询周期（以秒为单位）。浮点数表示比秒更精确的时间。 |
| iterator | | 迭代器配置。 |

*query* 选项的要求：

1. 满足 GridLinks 网关需要连接的数据库的 SQL 方言要求的有效 SQL *SELECT* 语句。
2. 在 _SELECT_ 列表中包含 *attributes* 或/和 *timeseries* 列。
3. 在 _SELECT_ 列表中包含 [*device*](/docs/iot-gateway/config/odbc/#subsection-device) 列，以找出数据属于哪个设备。
4. 在 _SELECT_ 列表中包含 [*iterator*](/docs/iot-gateway/config/odbc/#subsection-iterator) 列。
5. 在其他条件中，SQL _WHERE_ 子句必须包含 [*iterator*](/docs/iot-gateway/config/odbc/#subsection-iterator) 条件。
6. 在其他排序表达式中，SQL _ORDER BY_ 子句必须包含 [*iterator*](/docs/iot-gateway/config/odbc/#subsection-iterator) 排序表达式。
7. *建议* 使用 SQL _LIMIT_ 子句来减少每次从数据库读取时的内存消耗。

**示例**：

每次轮询迭代，连接器将按 _ts_ 列（[*iterator*](/docs/iot-gateway/config/odbc/#subsection-iterator)）排序，读取 10 条记录。

每条记录包含时序列（*bool_v*、*str_v*、*dbl_v*、*long_v*）、[设备](/docs/iot-gateway/config/odbc/#subsection-device) 列（*entity_id*）和 [*iterator*](/docs/iot-gateway/config/odbc/#subsection-iterator) 列（*ts*）。

每次轮询迭代后，连接器都会记住第 10 条记录（最后一条记录）的 *ts* 列的值，并在下次迭代中将其用于 _WHERE_ 子句。
```sql
SELECT bool_v, str_v, dbl_v, long_v, entity_id, ts   (2-3)
FROM ts_kv
WHERE ts > ?                                         (4)
ORDER BY ts ASC                                      (5)
LIMIT 10                                             (6)
```

### “iterator”小节

此 **强制性** 小节提供了有关用于迭代结果集的数据库列、迭代器的初始值以及是否在网关工作会话之间使用迭代器数据的信息。
<br>
<br>
**重要提示**

*iterator* 特性的主要挑战是明确确定是从以前的网关工作会话中恢复迭代器数据还是使用连接器配置文件中的值。

每个 *iterator* 都在 *config/odbc/* 文件夹中存储了自己的文件。每次轮询迭代后，连接器都会将 *iterator* 数据（请参见下面的 *persistent* 选项）保存到此类文件中。
<br>
<hr/>
*\- 连接器如何将迭代器文件彼此区分？*

\- 简短的回答是，决策基于 *iterator* 文件名。
<hr/>
具体来说，一旦连接器启动并连接到数据库，它就会检查 *persistent* 标志（见下文）是否设置为 *true*。如果是，连接器会计算 *iterator* 文件名并检查它是否存在于 *config/odbc/* 文件夹中。

如果文件存在，连接器会从其中加载 *iterator* 数据。否则，会从连接器的配置文件中加载 *iterator* 数据。

*iterator* 文件名是以下内容的哈希：
* ODBC 驱动程序名称
* 数据库服务器名称
* 数据库名称
* 迭代器列（请参见下面的 *column* 选项）

<br>
**缺点**

在使用同一个数据库时，**表列表可能完全改变**，但 ***iterator* 列名称没有**，仅仅是因为不同的表中使用了相同的列名称。在这种情况下，**连接器会加载错误的 *iterator* 数据**。
<br>
<br>
**结论**

1. 对于同一个数据库，每个迭代器使用唯一的名称。
2. 仅在其他连接器配置部分已调试且属性和时序列表已最终确定时，才启用 _iterator_ 持久性功能。


| **参数** | **默认值** | **说明** |
|:-|:-|-|
| **column** | | 用于迭代结果集的数据库列名称。 |
| **value** | | 迭代器的初始值。 |
| **query** | | 用于计算迭代器初始值的 SQL 查询。 |
| persistent | **false** | 是否在网关工作会话之间使用迭代器数据。 |

**注意**：*value* 和 *query* 选项互斥。如果同时设置了这两个选项，将使用 _value_。

## “mapping”部分

此 **强制性** 部分提供了有关如何将从数据库获取的结果集映射到设备属性和时序值的信息。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| **device** | | 设备配置。 |
| sendDataOnlyOnChange | **false** | 仅在数据自上次检查以来发生更改时发送，如果未指定，则每次轮询迭代后都会发送数据。 |
| attributes | | 设备属性列表。 |
| timeseries | | 时序键列表。 |

### “device”小节

此 **强制性** 小节提供了有关如何将结果集映射到 **唯一** 设备名称及其类型的信息。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| **name** | | Python [eval()](https://docs.python.org/3/library/functions.html#eval) 表达式，用于生成 **唯一** 的设备名称。 |
| type | **odbc** | GridLinks 设备类型。 |

**注意** SQL *SELECT* 子句中列出的所有数据库列都可以在 Python [eval()](https://docs.python.org/3/library/functions.html#eval) 上下文中通过其名称使用。

例如，
```json
"device": {
  "name": "'ODBC' + entity_id"
}
```
,表示设备名称是两个字符串的连接结果：*ODBC* 和数据库列 *entity_id* 的值。

### “attributes”和“timeseries”小节

这些 **可选** 小节提供了有关哪些数据库列被视为属性，哪些被视为时序键，以及在发送到 GridLinks 服务器之前应执行哪些预处理工作的信息。

连接器支持这些小节的几种配置模式：

* 数据库列列表
```json
"timeseries": [ "str_v", "ts" ]
```
* 配置列表
```json
"timeseries": [
  {
    "name": "boolValue",
    "column": "bool_v"
  },
  {
    "nameExpression": "key_name",
    "value": "[i for i in [str_v, long_v, dbl_v,bool_v] if i is not None][0]"
  },
  {
    "name": "value",
    "value": "[i for i in [str_v, long_v, dbl_v,bool_v] if i is not None][0]"
  }
]
```

| **参数** | **说明** |
|:-|:-|
| **name** | 别名。 |
| **nameExpression** | Python [eval()](https://docs.python.org/3/library/functions.html#eval) 表达式，用于计算别名。 |
| column | 数据库列名称。 |
| value | Python [eval()](https://docs.python.org/3/library/functions.html#eval) 表达式，用于计算值。 |

**注意** SQL *SELECT* 子句中列出的所有数据库列都可以在 Python [eval()](https://docs.python.org/3/library/functions.html#eval) 上下文中通过其名称使用。

* 组合模式
```json
"timeseries": [
  "ts",
  {
    "name": "value",
    "value": "[i for i in [str_v, long_v, dbl_v,bool_v] if i is not None][0]"
  }
]
```
* 通配符
```json
"timeseries": "*"
```
,表示将所有数据库列视为时序。

## “serverSideRpc”部分

连接器能够调用带或不带参数的 SQL 过程/函数。参数可以从连接器的配置文件或从服务器收到的 [数据](/docs/reference/gateway-mqtt-api/#server-side-rpc) 中获取。

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| enableUnknownRpc | **false** | 允许处理未在 *methods* 小节中列出的 RPC 命令。 |
| overrideRpcConfig | **false** | 允许通过从服务器收到的数据覆盖 RPC 命令配置。 |
| methods | | RPC 方法及其参数的列表。 |

连接器支持 *methods* 小节的几种配置模式：

* 不带参数的过程/函数列表
```json
"methods": [ "procedureOne", "procedureTwo" ]
```
* 过程/函数配置列表
<br><br>
**参数的顺序很重要**。它必须与 SQL 过程/函数中参数的顺序相同。
```json
"methods": [
  {
    "name": "rpcProcOne",
    "args": [ "One", 2, 3.0 ],
    "query": "CALL procedureOne(?,?,?)"
  },
  {
    "name": "functionOne",
    "args": [ false ]
  }
]
```
**过程 / 函数配置参数**

| **参数** | **默认值** | **说明** |
|:-|:-|-|
| **name** | | RPC 方法或 SQL 过程/函数的名称。 |
| query | | 调用过程/函数的自定义 SQL 查询。 |
| args | | SQL 过程/函数参数列表。 |
| result | **false** | **仅适用于 SQL 函数** 是否处理函数结果，如果不处理，连接器将返回处理过程/函数的状态（即 *成功* / *失败* ）。 |


* 组合模式
```json
"methods": [
  "procedureOne",
  {
    "name": "procedureTwo",
    "args": [ "One", 2, 3.0 ]
  }
]
```

**重要提示**

如果 *enableUnknownRpc* 设置为 *true*，[RPC 参数](/docs/reference/gateway-mqtt-api/#server-side-rpc) **必须** 具有 **所有必需的** **过程/函数配置参数**。

如果 *overrideRpcConfig* 设置为 *true*，[RPC 参数](/docs/reference/gateway-mqtt-api/#server-side-rpc) **可能包含** **所有或部分** **过程/函数配置参数**，以覆盖连接器配置文件中指定的参数。

**参数的顺序很重要**。它必须与 SQL 过程/函数中参数的顺序相同。
```json
{
  "device": "ODBC Device 1", 
  "data": {
    "method": "procedureOne", 
    "params": {
      "args": [ "OverridedValue", 123, 3.14 ]
    }
  }
}
```

## 后续步骤

探索与 GridLinks 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。