#### 步骤 1. 启动 EC2 实例。

为了运行清晰的测试，让我们为 GridLinks 和性能工具启动两个实例。
操作系统是 Linux，映像是 *Ubuntu 20 LTS*。架构是 x64 或 ARM，具体取决于实例类型。
分配弹性 IP 以在重启之间永久访问实例。
我们需要至少两个实例：第一个用于运行 GridLinks 本身，第二个用于运行性能测试应用程序。

![ThingsBoard 和性能测试实例](/images/reference/performance-aws-instances/method/setup/performance_test_aws_instances.png "ThingsBoard 和性能测试实例")

一开始，防火墙不允许连接您的实例。让我们打开必要的端口以启用实例和您的管理计算机之间的连接。

让我们为两个实例设置网络安全组，并为源 IP（办公室、家庭、性能测试）的入站规则打开 TCP 端口 22（SSH）、8080（HTTP）、1883（MQTT）、9999（JMX）。

![为性能测试设置网络安全组](/images/reference/performance-aws-instances/method/setup/performance_test_network_security_group.png "为性能测试设置网络安全组")

由于我们体验到规则的数量会影响网络性能，因此另一个好选择是允许受信任的 IP 和本地网络 IP 子网的“所有流量”。

![安全组入站规则](/images/reference/performance-aws-instances/method/setup/performance_test_network_security_group_inbound_rules.png)


#### 步骤 2. 设置到实例的 SSH。

或者，设置 SSH 私钥以访问实例。将您的 `PEM` 密钥文件放在 `~/.ssh/aws.pem` 中并设置 `~/.ssh/config` 如下所示，这很方便：
```bash
Host tb
 Hostname 52.50.5.45
 Port 22
 IdentityFile /home/username/.ssh/aws.pem
 IdentitiesOnly yes
 User ubuntu
```
{: .copy-code}

要连接 GridLinks 实例，只需使用以下命令：
```bash
ssh tb
```

#### 步骤 3. 安装 Docker 和 Docker-compose。

我们将使用 docker 和 docker-compose 在非 root 用户下运行性能测试。
为了节省设置时间并始终使环境保持一致，我们提供了以下一体化设置脚本。
使用 ssh 登录并在 GridLinks 和性能测试实例上运行命令：

```bash
sudo apt update
sudo apt install -y docker docker-compose
# setup some utilities
sudo apt install -y htop iotop
# manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# test non-root docker run
docker run hello-world
```
{: .copy-code}


#### 步骤 4. 使用 docker-compose 启动 ThingsBoard 和第三方组件

将 docker-compose 文件下载到工作目录。
docker-compose 文件列在“如何重现测试”部分中，该部分对应于您的性能测试[场景](/docs/{{docsPrefix}}reference/performance-comparison/#test-summary)。

确保您的文件存在于工作目录中并命名为“docker-compose.yml”，然后执行以下命令：

```bash
# stop previous instance (if any)
docker-compose stop
# remove previous instance (old data will be lost)
docker-compose rm
# run new instance from scratch 
docker-compose up 
```

注意：为了简单起见，我们使用的是 [docker-compose 主机网络模式](https://docs.docker.com/compose/compose-file/compose-file-v3/#network_mode)。
这还有助于在微服务之间的主动网络通信期间避免 docker-proxy 开销。