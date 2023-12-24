* TOC
{:toc}

## 批量配置概述

ThingsBoard 提供了使用 CSV 文件批量配置以下类型实体的选项：

- **设备**
- **资产**


不同的实体可能具有以下参数：

- **属性** - 与实体关联的静态和半静态键值对。例如，序列号、型号、固件版本；
- **遥测数据** - 可用于存储、查询和可视化的时序数据点。例如，温度、湿度、电池电量；
- **凭据** - 用于设备通过在设备上运行的应用程序连接到 ThingsBoard 服务器。

## 导入实体

要一次创建多个实体，您需要创建一个 CSV 文件，其中每一行都负责使用给定参数创建一个实体。<br>
如果您不需要为特定实体添加一些设置，请将此单元格留空。<br>
有三个保留的参数名称：名称、类型和标签，它们具有预定义的列类型。

### 步骤 1：选择文件

将 CSV 文件上传到系统。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-1.gif" alt="批量配置步骤 1">

### 步骤 2：导入配置

对于上传的文件，您需要配置以下参数：

- **CSV 分隔符** - 数据行中值之间的分隔字符；
- **第一行包含列名称** - 如果激活此选项，则文件的第 1 行将用作下一步中参数名称的默认值；
- **更新属性/遥测** - 如果激活此参数，则对于名称与 ThingsBoard 系统中现有实体匹配的所有实体，参数值将被更新。否则，对于 ThingsBoard 系统中已存在的名称的所有实体，将显示错误消息。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-2.gif" alt="批量配置步骤 2">

### 步骤 3：选择列类型

在此步骤中，您需要定义下载的文件的列与 ThingsBoard 平台中的数据类型之间的匹配。您还可以设置/更改属性/遥测键的默认名称。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-3.gif" alt="批量配置步骤 3">

### 步骤 4：创建新实体

处理输入数据。

### 步骤 5：完成

查询执行结果：创建/更新的实体数量和执行期间发生的错误数量。

<img data-gifffer="/images/user-guide/bull-provisioning/bulk-provision-step-5.gif" alt="批量配置步骤 5">


## 使用案例

假设我们要同时创建 10 个设备并为它们提供访问令牌。<br><br>
示例文件：
{% capture tabspec %}sample-file
A,test-import-device.csv,text,resources/test-import-device.csv,/docs/{{docsPrefix}}user-guide/resources/test-import-device.csv{% endcapture %}
{% include tabs.html %}
**注意：**文件应至少包含两列：实体名称和类型。<br>

<br>文件使用 CSV 文件编辑器创建，其中包含 10 个设备的数据。此外，**设备 5**省略了 **Data2** 参数，它不会为此设备创建。

#### 上传文件

转到 **设备** -> **导入设备**

上传示例文件：**test-import-device.csv**

![image](/images/user-guide/bull-provisioning/import-device-select-file.png)

#### 导入配置

- **CSV 分隔符** - 选择您的编辑器分隔符号。在示例文件中，分隔符为“,”；
- **第一行包含列名称** - 示例文件包含列名称，因此我们选择此选项；
- **更新属性/遥测** - 取消选中此选项，因为我们要添加新设备，而不是更新 ThingsBoard 平台中现有设备的参数。

![image](/images/user-guide/bull-provisioning/import-device-config.png)

#### 选择列类型

表格的第一列显示包含数据的文件第一行。<br>
由于在上一步骤中已选中 **第一行包含列名称** 复选框，因此第三列的值已根据文档的第一行初始化。<br>
让我们更改一些属性。将第三行中的列类型更改为 **时序**并设置属性/遥测键值，例如 **温度**。<br>
下表中的最后一行负责令牌，因此将 **服务器属性** 更改为 **访问令牌**。<br><br>

![image](/images/user-guide/bull-provisioning/import-device-column-type.png)<br>
**注意：**名称、类型和访问令牌等列类型只能选择一行。

#### 导入完成

创建过程完成后，将显示一些统计信息。<br>
在以下示例中，我们可以看到成功创建了 8 个设备，并且在创建 2 个设备时发生错误。原因是设备 1、设备 2 和设备 3 在给定的示例文件中具有相同的令牌。ThingsBoard 系统禁止这样做。

![image](/images/user-guide/bull-provisioning/import-device-info-created.png)<br>