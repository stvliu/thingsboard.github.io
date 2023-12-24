* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard 配置文件和参数。我们**建议**使用环境变量配置 GridLinks。这样，您无需在新的平台版本发布时合并配置文件。可用的配置参数和相应的环境变量列表位于 [此处](#configuration-parameters)。

## 如何更改配置参数？

#### 在 Linux 上的整体部署

如果 ThingsBoard 以**整体应用程序**的形式安装在 **Linux** 上，您可以在 thingsboard.conf 文件中指定环境变量：

```bash
sudo nano /usr/share/thingsboard/conf/thingsboard.conf
```

使用以下简单示例添加值为“8081”的新环境变量“HTTP_BIND_PORT”。

```bash
...
export HTTP_BIND_PORT=8081
```

#### 在 Windows 上的整体部署

如果 ThingsBoard 以**整体应用程序**的形式安装在 **Windows** 上，您可以在以下目录中找到的 thingsboard.yml 文件中指定环境变量：

```bash
YOUR_INSTALL_DIR/conf
```

配置文件以 YAML 编写。

所有配置参数都有相应的环境变量名称和默认值。为了更改配置参数，您可以简单地更改其默认值。例如：

```bash
server:
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
```

在这种情况下，*'HTTP_BIND_ADDRESS'* 是环境变量名称，*'0.0.0.0'* 是默认值。

#### 基于 Docker 的部署

如果 GridLinks 安装在 docker compose 环境中，您可以编辑脚本并为相应的容器添加环境变量。
有关更多详细信息，请参阅 [docker 文档](https://docs.docker.com/compose/environment-variables/#/the-envfile-configuration-option)。

#### 基于 K8S 的部署

如果 GridLinks 安装在 K8S 环境中，您可以编辑脚本并为相应的部署/有状态集添加环境变量。
有关更多详细信息，请参阅 [K8S 文档](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。