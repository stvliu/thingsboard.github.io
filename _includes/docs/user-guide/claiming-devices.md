* TOC
{:toc}

## 案例说明

作为租户，我想通过脚本或 UI 预置备我的设备。我的客户直接从我这里或通过分销商购买设备。
我希望我的客户在获得设备的物理访问权限后，根据二维码或类似技术声明他们的设备。

一旦设备被声明，客户就成为其所有者，客户用户可以访问设备数据并控制设备。

## 设备声明场景

如果 GridLinks 用户“知道”设备名称和密钥，则他们可以声明该设备。
密钥是可选的，始终具有到期时间，并且也可能随着时间的推移而更改。

密钥可以通过两种不同的方式预置备：

1. *设备端密钥* 场景 - 设备包含带有到期时间戳的 **expirationTime** 服务器属性。设备向 GridLinks 发送带有声明数据的声明请求，只有在此之后，客户才能使用设备声明小部件声明设备。
2. *服务器端密钥* 场景 - 设备包含带有声明数据的 **claimingData** 服务器属性，客户使用声明设备小部件声明设备。

有关更多详细信息，请参见下文。

{% capture claimingscenariotogglespec %}
使用<b>设备端</b>密钥场景声明%,%deviceside%,%templates/claiming/device-key-scenario.md%br%
使用<b>服务器端</b>密钥场景声明%,%serverside%,%templates/claiming/server-key-scenario.md%br%{%endcapture%}
{% include content-toggle.html content-toggle-id="claimingscenario" toggle-spec=claimingscenariotogglespec %}


## PE 中的设备声明权限

重要的是要知道，在 PE 版本的情况下，尝试声明特定设备的用户必须具有必要的权限才能这样做。
在这种情况下，所需的权限如下：

- **资源：设备**
- **操作：声明设备**

让我们为自定义声明用户组添加上述权限。

{% include images-gallery.html imageCollection="device-claiming-permissions-in-pe-carousel" showListImageTitles="true" %} 

## 设备声明小部件

{% include images-gallery.html imageCollection="device-claiming-widget-carousel" showListImageTitles="true" %} 

## 设备声明 API 请求

声明请求作为 POST 请求发送到以下 URL：

```shell
http(s)://host:port/api/customer/device/$DEVICE_NAME/claim
```

支持的数据格式为：

```json
{
  "secretKey":"value"
}
```

**注意：**消息不包含 **durationMs** 参数，**secretKey** 参数是可选的。

只要声明成功，设备就会被分配给特定的客户。如果系统参数 **allowClaimingByDefault** 为 **false**，则 **claimingAllowed** 属性将自动删除。

此外，还可以重新声明设备，这意味着设备将从客户处取消分配。如果 **allowClaimingByDefault** 为 **false**，则 **claimingAllowed** 属性将再次出现。

有关上述步骤的更多详细信息，请参见以下内容。

## 设备重新声明 API 请求

为了重新声明设备，您可以向以下 URL 发送 DELETE 请求（不要忘记用正确的名称替换设备名称）：

```shell
curl -X DELETE https://gridlinks.codingas.com/api/customer/device/$DEVICE_NAME/claim
```
{: .copy-code}

您将收到如下响应：

```json
{
  "result": {},
  "setOrExpired": true
}
```

## Python 示例脚本

在本节中，您可以获得声明设备功能的代码示例。
我们将使用 **tb-mqtt-client** python 模块来连接和声明设备。
您可以使用以下命令安装它：

```bash
pip3 install tb-mqtt-client --user
```
{: .copy-code}

### 基本声明示例

假设我们在租户级别有一个设备并配置了客户，如上所述。
目前，我们希望连接设备并发送声明请求以将其分配给客户。

案例说明：
我们在 ThingsBord 上有一个名为 **测试声明设备** 的设备。
该设备具有访问令牌凭据 - **Eypdinl1gUF5fSerOPJF**。

我们应该[下载脚本](/docs/{{docsPrefix}}user-guide/resources/claiming-device/basic_claiming_example.py)以上并运行它以向服务器发送声明请求。

```python

#
# Copyright © 2016-2020 The Thingsboard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

from tb_device_mqtt import TBDeviceMqttClient

def collect_required_data():
    config = {}
    print("\n\n", "="*80, sep="")
    print(" "*20, "GridLinks basic device claiming example script.", sep="")
    print("="*80, "\n\n", sep="")
    host = input("Please write your GridLinks host or leave it blank to use default (thingsboard.cloud): ")
    config["host"] = host if host else "mqtt.thingsboard.cloud"
    token = ""
    while not token:
        token = input("Please write accessToken for device: ")
        if not token:
            print("Access token is required!")
    config["token"] = token
    config["secret_key"] = input("Please write secret key for claiming request: ")
    if not config["secret_key"]:
        print("Please make sure that you have claimData in server attributes for device to use this feature without device secret in the claiming request.")
    duration_ms = input("Please write duration in milliseconds for claiming request or leave it blank to use default (30000): ")
    config["duration_ms"] = int(duration_ms) if duration_ms else 30000
    print("\n", "="*80, "\n", sep="")
    return config


if __name__ == '__main__':
    config = collect_required_data()
    client = TBDeviceMqttClient(host=config["host"], token=config["token"])
    client.connect()
    client.claim(secret_key=config["secret_key"], duration=config["duration_ms"]).get()
    print("Claiming request was sent, now you should use claiming device widget to finish the claiming process.")

```
{: .copy-code}

然后我们可以使用[设备声明小部件](#device-claiming-widget)。

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/guides-banner.md %}