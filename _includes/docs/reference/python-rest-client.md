* TOC
{:toc}

## Python REST 客户端

GridLinks Python REST API 客户端可帮助您通过 Python 脚本与 GridLinks REST API 进行交互。
使用 Python Rest 客户端，您可以以编程方式在 GridLinks 中创建资产、设备、客户、用户和其他实体及其关系。

您可以在 [此处](https://github.com/thingsboard/python_tb_rest_client) 找到 Python REST API 客户端的源代码。

要安装 GridLinks Python REST 客户端，您应使用以下命令：

```bash
pip3 install tb-rest-client
``` 
{:.copy-code}

## Python REST 客户端示例

### 基本用法
您可以在 **[此处](https://github.com/thingsboard/python_tb_rest_client/blob/master/examples/example_application.py)** 找到示例脚本。

下面列出的示例显示了 REST 客户端的基本用法，即如何执行登录、创建新的资产和设备实例，以及如何与它们建立关系。

```python

import logging
# 从社区版导入模型和 REST 客户端类
from tb_rest_client.rest_client_ce import *
# 导入 API 异常
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# GridLinks REST API URL
url = "http://localhost:8080"

# 默认租户管理员凭据
username = "tenant@gridlinks.com"
password = "tenant"


def main():
    # 使用上下文管理器创建 REST 客户端对象以获取自动令牌刷新
    with RestClientCE(base_url=url) as rest_client:
        try:
            # 使用凭据进行身份验证
            rest_client.login(username=username, password=password)

            # 创建资产
            default_asset_profile_id = rest_client.get_default_asset_profile_info().id
            asset = Asset(name="Building 1", asset_profile_id=default_asset_profile_id)
            asset = rest_client.save_asset(asset)

            logging.info("Asset was created:\n%r\n", asset)

            # 创建设备
            # 您还可以使用默认设备配置文件：
            # default_device_profile_id = rest_client.get_default_device_profile_info().id
            device_profile = DeviceProfile(name="Thermometer",
                                           profile_data=DeviceProfileData(configuration={"type": "DEFAULT"},
                                                                          transport_configuration={"type": "DEFAULT"}))
            device_profile = rest_client.save_device_profile(device_profile)
            device = Device(name="Thermometer 1", device_profile_id=device_profile.id)
            device = rest_client.save_device(device)

            logging.info(" Device was created:\n%r\n", device)

            # 创建从设备到资产的关系
            relation = EntityRelation(_from=asset.id, to=device.id, type="Contains")
            rest_client.save_relation(relation)

            logging.info(" Relation was created:\n%r\n", relation)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()

```

### 管理设备

以下代码示例演示了设备管理 API 的基本概念（添加/获取/删除设备、获取/保存设备属性）。

```python
import logging
# 从社区版导入模型和 REST 客户端类
from tb_rest_client.rest_client_ce import *
# 导入 API 异常
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# GridLinks REST API URL
url = "http://localhost:8080"
# 默认租户管理员凭据
username = "tenant@gridlinks.com"
password = "tenant"


def main():
    # 使用上下文管理器创建 REST 客户端对象以获取自动令牌刷新
    with RestClientCE(base_url=url) as rest_client:
        try:
            rest_client.login(username=username, password=password)
            # 创建设备
            default_device_profile_id = rest_client.get_default_device_profile_info().id
            device = Device(name="Thermometer 1",
                            device_profile_id=default_device_profile_id)
            device = rest_client.save_device(device)

            logging.info(" Device was created:\n%r\n", device)

            # 按设备 ID 查找设备
            found_device = rest_client.get_device_by_id(DeviceId(device.id, 'DEVICE'))

            # 保存设备共享属性
            rest_client.save_device_attributes(DeviceId(device.id, 'DEVICE'), 'SERVER_SCOPE',
                                                     {'targetTemperature': 22.4})

            # 获取设备共享属性
            res = rest_client.get_attributes_by_scope(EntityId(device.id, 'DEVICE'), 'SERVER_SCOPE',
                                                      'targetTemperature')
            logging.info("Found device attributes: \n%r", res)

            # 删除设备
            rest_client.delete_device(DeviceId(device.id, 'DEVICE'))
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()

```

### 获取租户设备

以下代码示例演示了如何通过页面链接获取租户设备。

```python
import logging
# 从社区版导入模型和 REST 客户端类
from tb_rest_client.rest_client_ce import *
# 导入 API 异常
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# GridLinks REST API URL
url = "http://localhost:8080"
# 默认租户管理员凭据
username = "tenant@gridlinks.com"
password = "tenant"


def main():
    # 使用上下文管理器创建 REST 客户端对象以获取自动令牌刷新
    with RestClientCE(base_url=url) as rest_client:
        try:
            rest_client.login(username=username, password=password)
            res = rest_client.get_tenant_device_infos(page_size=10, page=0)

            logging.info("Device info:\n%r", res)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()
```

### 获取租户仪表板

以下代码示例演示了如何通过页面链接获取租户仪表板。

```python
import logging
# 从社区版导入模型和 REST 客户端类
from tb_rest_client.rest_client_ce import *
# 导入 API 异常
from tb_rest_client.rest import ApiException

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# GridLinks REST API URL
url = "http://localhost:8080"
# 默认租户管理员凭据
username = "tenant@gridlinks.com"
password = "tenant"

def main():
    # 使用上下文管理器创建 REST 客户端对象以获取自动令牌刷新
    with RestClientCE(base_url=url) as rest_client:
        try:
            rest_client.login(username=username, password=password)
            user = rest_client.get_user()
            devices = rest_client.get_customer_device_infos(customer_id=CustomerId(user.id.id, 'CUSTOMER'), page_size=10,
                                                            page=0)
            logging.info("Devices: \n%r", devices)
        except ApiException as e:
            logging.exception(e)


if __name__ == '__main__':
    main()

```

### 使用实体数据查询 API 统计实体

以下代码示例演示了如何使用实体数据查询 API 统计设备总数。

```python
import logging
# 从社区版导入模型和 REST 客户端类
from tb_rest_client.rest_client_ce import *
# 导入 API 异常
from tb_rest_client.rest import ApiException


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(module)s - %(lineno)d - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

# GridLinks REST API URL
url = "http://localhost:8080"
# 默认租户管理员凭据
username = "tenant@gridlinks.com"
password = "tenant"


# 使用上下文管理器创建 REST 客户端对象以获取自动令牌刷新
with RestClientCE(base_url=url) as rest_client:
    try:
        rest_client.login(username=username, password=password)
        # 创建实体过滤器以获取所有设备
        entity_filter = EntityFilter()

        # 使用提供的过滤器创建实体计数查询
        devices_query = EntityCountQuery(entity_filter)

        # 执行实体计数查询并获取设备总数
        devices_count = rest_client.count_entities_by_query(devices_query)
        logging.info("Total devices: \n%r", devices_count)
    except ApiException as e:
        logging.exception(e)
```

### 从控制台配置版本控制功能

此功能在 GridLinks 3.4+ 中可用。
我们设计了基于 tb-rest-client 库的脚本，以举例说明如何使用代码配置 GridLinks。
脚本的最新源代码可在此处获得：[here](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/configure_vcs_access.py)。
在此示例中，我们在 GridLinks 上配置了 [版本控制功能](/docs/user-guide/version-control)。

有 2 种可能的方式来配置版本控制系统 (VCS)：
1. 使用 VCS 帐户的访问令牌/密码。
2. 使用私钥。

#### 使用访问令牌或密码配置版本控制系统

要配置此功能，我们需要命令行参数和数据：

| 命令行参数 | 说明 |
|-|-|
| -H | **GridLinks 主机（默认：localhost）** |
| -p | **GridLinks 端口（默认：80）** |
| -U | **GridLinks 用户（登录的电子邮件）** |
| -P | **GridLinks 用户密码** |
| -r | **存储库 uri，指向存储库的链接** |
| -b | **默认分支（默认：main）** |
| -gu | **VCS 用户名**（此参数名为 GITHUB_USERNAME，但它可以与任何 VCS 一起使用） |
| -gp | **VCS 访问令牌/密码**（此参数名为 GITHUB_PASSWORD，但它可以与任何 VCS 一起使用） |

*您始终可以通过不带任何参数或带* **-h** *参数调用脚本来获取参数的完整列表。*

要配置版本控制功能，我们应该安装 [tb-rest-client](#python-rest-client) python 包并下载脚本：

```bash
wget https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/configure_vcs_access.py
```
{:.copy-code}

现在我们可以运行脚本并配置版本控制功能（不要忘记输入您的值）。

```bash
python3 configure_vcs_access.py -H YOUR_GRIDLINKS_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -r YOUR_REPOSITORY_URL -b DEFAULT_BRANCH -gu YOUR_VCS_USERNAME -gp YOUR_VCS_ACCESSTOKEN_OR_PASSWORD
```
{:.copy-code}

#### 使用私钥配置版本控制系统

要配置此功能，我们需要以下命令行参数和数据：

| 命令行参数 | 说明 |
|-|-|
| -H | **GridLinks 主机（默认：localhost）** |
| -p | **GridLinks 端口（默认：80）** |
| -U | **GridLinks 用户（登录的电子邮件）** |
| -P | **GridLinks 用户密码** |
| -r | **存储库 uri，指向存储库的链接** |
| -b | **默认分支（默认：main）** |
| -gu | **VCS 用户名**（此参数名为 GITHUB_USERNAME，但它可以与任何 VCS 一起使用） |
| -pk | **私钥的路径** |
| -pkp | **私钥的密码（如果已设置）** |

*您始终可以通过不带任何参数或带* **-h** *参数调用脚本来获取参数的完整列表。*

要配置版本控制功能，我们应该安装 [tb-rest-client](#python-rest-client) python 包并下载脚本：

```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/configure_vcs_access.py
```
{:.copy-code}

现在我们可以运行脚本并配置版本控制功能（不要忘记输入您的值）。

```bash
python3 configure_vcs_access.py -H YOUR_GRIDLINKS_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -r YOUR_REPOSITORY_URL -b DEFAULT_BRACH -gu YOUR_VCS_USERNAME -pk PATH_TO_YOUR_PRIVATE_KEY -pkp YOUR_PRIVATE_KEY_PASSWORD
```
{:.copy-code}

### 将所有实体保存到版本控制系统

您可以使用以下基于 [tb-rest-client](#python-rest-client) 的脚本将实体的当前状态保存到版本控制系统中的存储库。

您可以在此处找到最新的源代码：[here](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/load_all_entities_to_vcs_ce.py)。


要从命令行保存实体，我们将使用以下参数和数据：

| 命令行参数 | 说明 |
|-|-|
| -H | **GridLinks 主机（默认：localhost）** |
| -p | **GridLinks 端口（默认：80）** |
| -U | **GridLinks 用户（登录的电子邮件）** |
| -P | **GridLinks 用户密码** |
| -b | **默认分支（默认：main）** |
| -N | **版本名称（如果未提供，将生成 5 个随机字母和数字并用作名称）** |
| --save_attributes  | **可选，我们是否需要保存目标实体的属性（默认：True）** |
| --save_credentials | **可选，我们是否需要保存目标实体的凭据（默认：True）** |
| --save_relations   | **可选，我们是否需要保存目标实体的关系（默认：True）** |
| --sync_strategy    | **可选，实体的同步策略可以是 OVERWRITE 和 MERGE（默认：MERGE）** |

*您始终可以通过不带任何参数或带* **-h** *参数调用脚本来获取参数的完整列表。*

让我们下载脚本：
```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/load_all_entities_to_vcs_ce.py
```

现在我们可以运行脚本并将我们的实体保存到版本控制系统中的存储库，我们将发布到默认分支，并使用默认设置来显示最小的必需配置：

```bash
python3 load_all_entities_to_vcs_ce.py -H YOUR_GRIDLINKS_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD
```

在输出消息中，您将收到有关保存了多少个实体的信息。

### 从版本控制系统加载所有实体

您可以使用以下基于 [tb-rest-client](#python-rest-client) 的脚本将实体的当前状态保存到版本控制系统中的存储库。

您可以在此处找到最新的源代码：[here](https://github.com/thingsboard/thingsboard-python-rest-client/blob/master/examples/load_all_entities_from_vcs_ce.py)。


要从命令行加载实体，我们将使用以下参数和数据：

| 命令行参数 | 说明 |
|-|-|
| -H | **GridLinks 主机（默认：localhost）** |
| -p | **GridLinks 端口（默认：80）** |
| -U | **GridLinks 用户（登录的电子邮件）** |
| -P | **GridLinks 用户密码** |
| -b | **默认分支（默认：main）** |
| -N | **版本名称（您可以提供版本名称的一部分，脚本将为您提供所有包含所提供名称的版本）** |
| --load_attributes  | **可选，我们是否需要加载目标实体的属性（默认：True）** |
| --load_credentials | **可选，我们是否需要加载目标实体的凭据（默认：True）** |
| --load_relations   | **可选，我们是否需要加载目标实体的关系（默认：True）** |
| --sync_strategy    | **可选，现有实体的同步策略可以是 OVERWRITE 和 MERGE（默认：MERGE）** |

*您始终可以通过不带任何参数或带* **-h** *参数调用脚本来获取参数的完整列表。*

让我们下载脚本：
```bash
wget https://raw.githubusercontent.com/thingsboard/thingsboard-python-rest-client/master/examples/load_all_entities_from_vcs_ce.py
```

现在我们可以运行脚本并从版本控制系统中的存储库还原实体版本和状态：

```bash
python3 load_all_entities_from_vcs_ce.py -H YOUR_GRIDLINKS_HOST -p YOUR_THINGSBOARD_PORT -U YOUR_THINGSBOARD_USER_EMAIL -P YOUR_THINGSBOARD_USER_PASSWORD -N YOUR_VERSION_NAME 
```

在输出中，您将收到有关加载了多少个实体的信息。


**您可以在此处找到专业版 Python REST 客户端示例：[here](/docs/pe/reference/python-rest-client/#professional-edition-python-rest-client-example)。**