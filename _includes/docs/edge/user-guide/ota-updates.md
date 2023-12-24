* TOC
{:toc}

#### 概述

边缘空中更新的设计方式与 [平台（云）OTA 更新](/docs/{{cloudDocsPrefix}}user-guide/ota-updates/) 相同。
请阅读 *平台* OTA 更新文档以了解有关 OTA 更新功能的总体知识。

#### 将 OTA 软件包传播到边缘

OTA 软件包在 *平台* 上创建。在当前版本中，您**不能**在 *边缘* 上创建、修改或删除它们。

在平台上创建的所有 OTA 固件和软件包都会自动传播到连接到平台的每个边缘实例。
租户管理员或用户无需执行其他分配操作。

#### 在设备或设备配置文件配置中使用 OTA

*边缘* 上的 OTA 软件包可以在设备或设备配置文件配置中使用，与用于 *平台* 设备或设备配置文件配置的方式相同。

在 *边缘* 上使用这些软件包与在 *平台* 上相同，因此您可以按照 [*平台* 文档](/docs/{{cloudDocsPrefix}}user-guide/ota-updates/) 进行操作。

## 后续步骤

{% include templates/edge/guides-banner-edge.md %}