### 前提条件

- 激活 [DigitalOcean](https://cloud.digitalocean.com/){:target="_blank"} 帐户

### 步骤 1. 在 DigitalOcean 上启动 Ubuntu 18.04

##### 步骤 1.1 创建 DigitalOcean Droplet

- 登录到您的 DigitalOcean 帐户。
- 单击“Droplets”菜单项，然后单击“Create Droplet”按钮（请参见下图）。

![image](/images/user-guide/install/digital-ocean-pe/create-droplet.png)

##### 步骤 1.2 选择您的套餐

- “Create Droplets”页面加载后，选择“Ubuntu 18.04 x64”作为您的镜像（请参见下图）。
- 选择您的套餐。对于初学者，我们建议选择 2 个 CPU 和 4GB RAM 的套餐。

注意：高级 ThingsBoard 用户可以选择最适合其工作负载的套餐。

![image](/images/user-guide/install/digital-ocean-pe/choose-plan.png)

##### 步骤 1.3 选择区域

- 向下滚动以从可用列表中选择数据中心区域（请参见下图）。
- [可选] 启用备份。虽然这是可选的，但我们强烈建议您这样做。
- [可选] 添加块存储

![image](/images/user-guide/install/digital-ocean-pe/choose-region.png)

##### 步骤 1.4 身份验证

- 使用现有 SSH 密钥或创建新的 SSH 密钥，该密钥将用于连接到您的实例。确保您可以访问您选择的 SSH 密钥。我们将在本指南的后面部分使用此密钥连接到此实例。
- 输入一个有意义的主机名
- 添加“thingsboard”标签，以防万一，我们不会在本说明中使用它。
- 最后，单击“Create Droplet”按钮。

![image](/images/user-guide/install/digital-ocean-pe/create-final.png)

- 创建 droplet 后，将 droplet 的 IP 地址复制到安全的地方。我们将在本指南的后面部分使用它。

![image](/images/user-guide/install/digital-ocean-pe/droplet-created.png)

### 步骤 2. 配置防火墙规则

现在我们需要配置防火墙规则以允许 MQTT、CoAP 和 HTTP 流量。请参见下图：

![image](/images/user-guide/install/digital-ocean-pe/create-firewall.png)

- 为您的防火墙命名一个有意义的名称；
- 配置 HTTP、HTTPS 和三个自定义规则，如下面的屏幕所示。

![image](/images/user-guide/install/digital-ocean-pe/firewall-config.png)

- 保留出站规则不变；
- 选择您的 droplet 或标签来分配此防火墙；
- 最后，单击“Create Firewall”按钮。

![image](/images/user-guide/install/digital-ocean-pe/firewall-final.png)

### 步骤 3. 使用 SSH 连接到您的实例

请使用 [官方指南](https://www.digitalocean.com/docs/droplets/how-to/connect-with-ssh/){:target="_blank"} 和我们在 [步骤 1.4](/docs/user-guide/install/pe/digital-ocean/#step-14-authentication) 中创建的 SSH 密钥。