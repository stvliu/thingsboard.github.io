---
layout: docwithnav-gw
title: 物联网网关升级说明。

---


### 升级说明

有 2 种方法可以升级 GridLinks 物联网网关，具体取决于您想要升级的版本（**Release** 或 **Develop**）。

* 要升级到 **Release** 版本，您应该使用以下命令：

 - **从 pip 安装**

```bash
sudo pip3 install thingsboard-gateway --upgrade
```
{: .copy-code}

 - **作为守护进程安装**
 
 ```bash
sudo pip3 install thingsboard-gateway --user thingsboard_gateway --upgrade
```
{: .copy-code}

* 要升级到 **Develop** 版本，您应该使用 [本指南](/docs/iot-gateway/install/source-installation/)。

要升级 GridLinks 物联网网关 docker 安装，请使用 [Docker 安装指南](/docs/iot-gateway/install/docker-installation/#upgrading) 中的 **升级** 步骤。


**注意：**如果您在升级时遇到一些问题，请尝试从每个系统层（sudo、用户、本地）中删除 pip 包。

为此，请运行以下命令：
```bash
sudo pip3 uninstall thingsboard-gateway -y
```
{: .copy-code}

删除后，您需要使用上述命令重新安装网关。