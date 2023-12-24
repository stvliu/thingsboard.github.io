---
layout: docwithnav
title: ESP32 OTA 使用 GridLinks
description: 使用 GridLinks 进行 ESP32 OTA 更新的 GridLinks IoT 平台示例
hidetoc: "true"
---

* TOC
{:toc}

## 简介
{% include templates/what-is-thingsboard.md %}
[ESP32](https://www.espressif.com/en/products/hardware/esp32/overview) 是一系列低成本、低功耗的 SOC 微控制器，集成了自包含的 Wi-Fi 和双模蓝牙。
此示例应用程序允许您使用 GridLinks 和 OTA 将新的固件映像传递给 EPS32。

## 视频教程

有关此示例的视频教程，请参见下方，其中包含有关如何在 Windows 上安装和配置 [ESP-IDF](https://github.com/espressif/esp-idf) 的其他详细演示。

<br>
<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/nx44dS_Syqk" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 您需要什么
- 已安装和配置 [ESP-IDF](https://github.com/espressif/esp-idf)，这是 ESP32 芯片的官方开发框架。
  请参阅 [ESP-IDF 入门](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/) 文档以设置软件环境。
  在继续之前，请确保您可以成功构建并刷新 ESP-IDF 中的一些示例，例如 [Hello World](https://github.com/espressif/esp-idf/tree/master/examples/get-started/hello_world)。
  对于示例，使用了 ESP-IDF 版本 ***v3.3-beta1-328-gabea9e4c0***。
  如果出现任何构建错误，请参阅 [ESP-IDF 版本](https://docs.espressif.com/projects/esp-idf/en/latest/versions.html#esp-idf-versions) 文档以更新已安装 EPS-IDF 的版本。
- 任何带有 ESP32-PICO-D4 芯片的开发板。
  对于此示例，我们使用 [ESP32-PICO-KIT 迷你开发板](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/get-started-pico-kit.html#overview)
    <img src="/images/samples/esp32/ota/esp32_board.png" width="400" alt="esp32 board">
- ThingsBoard 应用程序中的帐户。您可以使用您自己的实例或 [GridLinks Cloud](https://gridlinks.codingas.com)
  我们需要说明的是，此示例适用于 CE 和 PE，但我们使用 PE 云，因为它具有更多功能，并且在下一个示例中，我们将展示如何同时为多个设备执行大规模固件更新。

## GridLinks 配置
1. 创建一个新设备，将其命名为 *ESP32* 并将其类型设置为 *ESP32_OTA*。
指定的设备类型将在规则链和仪表板中稍后使用。

    <img src="/images/samples/esp32/ota/tb_create_device.png" width="600" alt="create device">

2. 添加将更新设备的服务器属性 *fwStateIsSynced* 的新规则链。
属性类型为布尔值，它将用于在仪表板上显示固件是否已同步。
下载、导入 [检查 ESP32 固件是否已同步](/docs/samples/esp32/resources/check_is_esp32_firmware_synced.json) 规则链到 GridLinks 并保存：

    <img data-gifffer="/images/samples/esp32/ota/import_rule_chain.gif" width="1000" alt="import rule chain">

    规则链有 3 个节点：
    - *将属性添加到元数据* - 将客户端属性 *currentFwVer* 和服务器属性 *lastTargetFwVer* 添加到元数据
    - *更新服务器属性 'fwStateIsSynced'* - 比较属性 *currentFwVer* 和 *lastTargetFwVer* 的相等性，并将比较结果分配给 *fwStateIsSynced* 属性
    - *保存 'fwStateIsSynced' 属性* - 保存更新后的属性 *fwStateIsSynced*

3. 将导入的规则链 *检查 ESP32 固件是否已同步* 添加到 *根规则链*。打开 *根规则链*，从节点列表中拖放 *规则链* 节点，然后从下拉列表中选择 *检查 ESP32 固件是否已同步*。
应将两个链接连接到添加的节点：
    - 从 *消息类型开关* 连接类型为 *属性已更新*
    - 从 *保存属性* 连接类型为 *成功*

    <img data-gifffer="/images/samples/esp32/ota/tb_extend_root_rule_chain.gif" width="1000" alt="extend root rule chain">

    此类规则配置允许在以下情况下比较收到的固件版本（在更新后）：
    - 通过 OTA 将 ESP32 刷新为新固件后。
    ESP32 在重新启动后发送新固件版本的值（作为客户端属性 *currentFwVer*），并通过规则链中的 *发布属性* 链接传递。
    - 用户在小部件中保存新的 OTA 配置后。
    新固件版本的值通过规则链中的 *属性已更新* 链接作为服务器属性 *lastTargetFwVer* 传递。

4. 下载并导入 [OTA 小部件（ThingsBoard v3.x）](/docs/samples/esp32/resources/ota_widgets_v2.json) 或 [OTA 小部件（ThingsBoard v2.x）](/docs/samples/esp32/resources/ota_widgets.json) 小部件组到小部件库，以允许指定固件 URL 和版本，并将 OTA 配置发送到 ESP32。
5. 下载并导入 [ESP32 的 OTA（ThingsBoard v3.x）](/docs/samples/esp32/resources/ota_for_esp32_v2.json) 或 [ESP32 的 OTA（ThingsBoard v2.x）](/docs/samples/esp32/resources/ota_for_esp32.json) 仪表板到仪表板组。仪表板具有别名 *ESP32_OTA_alias*，适用于类型为 *ESP32_OTA* 的设备。
它允许在仪表板上显示支持 OTA 的 ESP32 列表以及列表中每个设备的当前固件状态（已同步或未同步）。
用户可以通过单击最后一列中的“选择 OTA 配置”控件，从列表中更改和更新任何 ESP32 的 OTA 配置。

    <img src="/images/samples/esp32/ota/tb_dashboard_main_state.png" width="600" alt="dashboard main state">

    由于只创建了一个类型为 *EPS32_OTA* 的设备，因此表格只包含一行。如果添加了类型为 *ESP32_OTA* 的新设备，那么它将自动出现在仪表板的实体表中。

## 配置和刷新 ESP32 工厂分区固件
1. 从 [ESP32 OTA](https://github.com/thingsboard/esp32-ota) ThingsBoard 存储库克隆示例源。
2. 转到克隆项目的目录并配置 MQTT 代理地址、Wi-Fi 凭据等。
打开终端并执行以下命令：
    ```bash
    make menuconfig
    ```
    在打开的菜单中，选择 *ThingsBoard OTA 配置* 子菜单，然后将有效参数输入到字段中：
    -  *WiFi SSID* - 您的 WiFi 接入点的登录名
    -  *WiFi 密码* - 您的 WiFi 接入点的密码
    -  *MQTT 代理 URL* - ThingsBoard MQTT 端点
    -  *MQTT 代理端口* - ThingsBoard MQTT 端口
    -  *MQTT 访问令牌* - GridLinks 中的设备访问令牌

    <img src="/images/samples/esp32/ota/framework_config.png" width="600" alt="framework config">

    保存配置并选择 *退出* 以返回主菜单。
3. 选择 *串行闪存器配置* 子菜单，然后更改 *默认串行端口*、*默认波特率* 和 *闪存大小* 参数：
    - *默认串行端口* - 根据您的操作系统选择串行端口名称（对于 Windows 为 COM 类型，对于 MacOS 为 /dev/cu/，对于 Linux 为 /dev/tty/）
    - *默认波特率* - 921600 波特率（默认 *111500 波特率*）
    - *闪存大小* - 4 MB（默认 *1 MB*）

    <img src="/images/samples/esp32/ota/serial_flasher_config.png" width="600" alt="serial flasher config">

    保存配置并选择 *退出* 以返回主菜单。
4. 选择 *分区表* 子菜单，然后更改 *分区表* 参数：
    - *分区表* - 工厂应用程序，两个 OTA 定义（默认 *单个工厂应用程序，无 OTA*）

    <img src="/images/samples/esp32/ota/partition_table.png" width="600" alt="partition table">

    保存配置并选择 *退出* 两次以退出 *menuconfig* 实用程序。
5. 任何支持 HTTPS 并返回图像文件的 Web 服务器都可以用于 OTA。对于此示例，我们将使用 GitHub 存储库，以便 ESP32 通过 OTA 更新下载图像。*[ca_cert.pem](https://raw.githubusercontent.com/thingsboard/esp32-ota/master/server_certs/ca_cert.pem)* 文件已经包含 GitHub 公共证书。

    **可选**
    如果您要使用其他服务器来传递固件映像，那么应替换 *[ca_cert.pem](https://raw.githubusercontent.com/thingsboard/esp32-ota/master/server_certs/ca_cert.pem)* 文件的内容。
    要获取服务器的公共 SSL 证书，请执行以下命令（首先将 *raw.githubusercontent.com* 替换为所需的服务器地址）
    ```bash
    openssl s_client -showcerts -connect raw.githubusercontent.com:443
    ```
    将输出中的证书内容复制到 *[ca_cert.pem](https://raw.githubusercontent.com/thingsboard/esp32-ota/master/server_certs/ca_cert.pem)* 并保存文件。
6. 现在，该项目已配置好，可以进行编译和刷新。在第一次刷新之前，有必要擦除 ESP32 闪存。
转到 [根示例目录](https://github.com/thingsboard/esp32-ota) 并执行以下命令
    ```bash
    make erase_flash
    ```
    执行以下命令以构建源、刷新 ESP32 并获取固件输出：
    ```bash
    make flash monitor
    ```
    如果编译和刷新成功，并且 ESP32 连接到 GridLinks，则会打印以下日志消息：

    <img src="/images/samples/esp32/ota/monitor_output_after_flashing.png" width="600" alt="monitor output after flashing">

    我们来看一下日志消息格式，例如 *I (5219) tb_ota: Connected to WI-FI, IP address: 192.168.2.45*
    - *I* - 信息日志类型，可以是 W（警告）、E（错误）或 D（调试）
    - *(5219)* - 调度程序在 APP CPU 上启动后的毫秒数
    - *tb_ota:* - 用于标识产生日志消息的组件的标记
    - *Connected to ...* - 日志消息本身

    应用程序的流程如下：
    1. 固件刷新到 *factory* 分区。将来，在 OTA 过程中收到的图像将交替写入分区 *ota_0* 或 *ota_1*。
    有关更多详细信息，请参阅 [空中更新 (OTA)](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/system/ota.html) ESP32 API 参考。
    2. 应用程序检查闪存是否包含 Wi-Fi 凭据。
    由于已将编译的映像刷新到 *factory* 分区并且已擦除闪存，因此在 *menuconfig* 中输入的 Wi-Fi 凭据将保留到闪存中，并将在以后使用。
    3. 应用程序尝试连接到提供的 Wi-Fi 接入点。
    4. 在建立与 Wi-Fi 接入点的连接后，应用程序检查闪存是否包含 MQTT URL、端口和 GridLinks 访问令牌。
    由于应用程序已刷新到 *factory* 分区并且已擦除闪存，因此在 *menuconfig* 中输入的 MQTT 客户端参数（URL、端口和访问令牌）将保留到闪存中，并将在以后使用。
    5. 应用程序尝试通过 MQTT 连接到 GridLinks。
    6. 建立连接后，应用程序从 GridLinks 获取共享属性 *targetFwUrl* 和 *targetFwVer*。
    它允许涵盖 ESP32 断电或失去与 GridLinks 的连接但共享属性当时已更新的情况。
    仅当共享属性值不为空且 *targetFwVer* 不等于硬编码的应用程序固件版本时，才会启动 OTA。
    由于尚未在 GridLinks 中创建任何共享属性（稍后将通过小部件创建），因此现在跳过 OTA 过程。
    7. 应用程序开始执行自定义任务（例如，将一些遥测或属性数据发送到 GridLinks）并等待共享属性 *targetFwUrl* 和 *targetFwVer* 的更新以执行 OTA。

## 从 GridLinks 执行 OTA
转到 *ESP32 的 OTA* 仪表板，然后按设备的 *选择 OTA 配置*。在打开的仪表板中，在 *OTA 控制* 小部件中输入以下参数：
  - *目标固件版本* - 硬编码在新固件映像中的预期固件版本，*v1.2*
  - *固件服务器 URL* - 新固件映像的链接，*https://raw.githubusercontent.com/thingsboard/esp32-ota/master/firmware/example-v1.2.bin*

按 *开始 OTA* 按钮以创建共享属性并将其发送到 EPS32。

<img data-gifffer="/images/samples/esp32/ota/tb_successful_ota_from_dashboard.gif" width="1000" alt="successful ota from dashboard">

示例的 [固件](https://github.com/thingsboard/esp32-ota/tree/master/firmware/) 目录包含两个具有以下差异的映像：
  - [example-v1.1.bin](https://raw.githubusercontent.com/thingsboard/esp32-ota/master/firmware/example-v1.1.bin) - [main.h](https://github.com/thingsboard/esp32-ota/blob/master/main/main.h) 中的 *FIRMWARE_VERSION* 值等于 *v1.1*。
  *counter* 变量在 [main_application_task](https://github.com/thingsboard/esp32-ota/blob/master/main/main.c) 中的值为 *1*。
  - [example-v1.2.bin](https://raw.githubusercontent.com/thingsboard/esp32-ota/master/firmware/example-v1.2.bin) - [main.h](https://github.com/thingsboard/esp32-ota/blob/master/main/main.h) 中的 *FIRMWARE_VERSION* 值等于 *v1.2*。
  *counter* 变量在 [main_application_task](https://github.com/thingsboard/esp32-ota/blob/master/main/main.c) 中的值为 *2*。

在 *OTA 控制* 小部件上更新固件版本和 URL 后，GridLinks 会向 *v1/devices/me/attributes* MQTT 主题发送包含共享属性的 MQTT 消息。
由于 ESP32 订阅了此 MQTT 主题，因此一旦收到更新消息，它就会被解析并比较固件版本。
如果 [main.h](https://github.com/thingsboard/esp32-ota/blob/master/main/main.h) 中定义的 *FIRMWARE_VERSION* 值不等于从 GridLinks 收到的固件版本，则 OTA 更新过程将启动，*monitor* 实用程序输出以下日志：

  <img src="/images/samples/esp32/ota/shared_attributes_updated.png" width="600" alt="shared attributes updated">

应用程序的流程如下：
  - 显示收到的 URL 和固件版本
  - 显示固件版本不同以及它们之间的差异的警告
  - 如果服务器的证书有效并且已从提供的 URL 成功下载映像，则 OTA 过程开始（打印 *Starting OTA...* 消息）
  - 在 OTA 过程中，所有其他任务都可能以一些延迟执行。
    例如，应用程序将遥测数据（在本示例中是 *counter* 变量的当前值）发送到 GridLinks，而没有确定的周期。
    如果 OTA 过程成功完成，ESP32 将重新启动，并在启动后显示以下日志：

  <img src="/images/samples/esp32/ota/ota_finished_successfully.png" width="600" alt="ota finished successfully">

让我们回顾一下与将固件刷新到 *factory* 分区时相比的日志差异：
  - 现在运行的分区是 *ota_0*，而不是 *factory*
  - Wi-Fi 凭据是从闪存中加载的，没有使用在 *menuconfig* 实用程序中输入的凭据
  - GridLinks 的 MQTT 访问令牌也从闪存中加载
  - 获取共享属性后，不会启动新的 OTA 过程，因为固件版本相同
  - 应用程序正在等待共享属性的下一个更新，这次将把新下载的映像写入 *ota_1* 分区。

现在，仅用于测试，您可以使用以下值更新 *OTA 控制* 小部件：
  - *目标固件版本* - v1.1
  - *固件服务器 URL* - https://raw.githubusercontent.com/thingsboard/esp32-ota/master/firmware/example-v1.1.bin

在此 OTA 更新之后，*counter* 会定期将其值更改为 0 或 1，与将映像刷新到 *factory* 分区后相同。但这次的区别在于映像已刷新到 *ota_1* 分区。

## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 GridLinks 主要功能相关的指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。

不要犹豫，在 **[github](https://github.com/thingsboard/thingsboard)** 上为 GridLinks 加星，以帮助我们传播信息。
如果您对本示例有任何疑问，请将其发布在 **[issues](https://github.com/thingsboard/esp32-ota/issues)** 上。

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}