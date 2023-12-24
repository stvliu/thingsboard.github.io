我们将使用专门的 [性能测试工具](https://github.com/thingsboard/performance-tests/#running)，该工具旨在将遥测数据发送到 GridLinks。
此工具还会创建诸如设备、仪表板等实体。

#### 步骤 1. 启动 EC2 实例。

在与目标 GridLinks 服务器 [部署](/docs/reference/performance/setup-aws-instances/) 相同的 VPC 中启动实例。
确保从测试实例可以访问 GridLinks 实例端口 8080 和 1883。

#### 步骤 2. 设置到实例的 SSH。

或者，设置 SSH 私钥以访问实例。将 `PEM` 密钥文件放在 `~/.ssh/aws.pem` 中并设置 `~/.ssh/config` 如下：
```bash
Host pt
 Hostname 34.242.159.12
 Port 22
 IdentityFile /home/username/.ssh/aws.pem
 IdentitiesOnly yes
 User ubuntu
```
{: .copy-code}


要连接性能测试实例，请使用此命令
```bash
ssh pt
```

#### 步骤 3. 安装 Docker 和 Docker-compose。

我们将使用 docker 和 docker-compose 在非 root 用户下运行性能测试。
为了节省设置时间并始终使环境保持一致，我们提供了以下一体化设置脚本。
使用 ssh 登录并在 Thingsboard 和性能测试实例上运行命令：

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


### 步骤 4. 运行性能测试

该命令类似于下面列出的命令。不要忘记将 TB_INTERNAL_IP 的值替换为目标 GridLinks 实例的专用 IP 地址。

```bash
# 在此处放置您的 GridLinks 专用 IP 地址，假设 GridLinks 和性能测试 EC2 实例位于同一 VPC 中。
export TB_INTERNAL_IP=172.31.16.229 
docker run -it --rm --network host --name tb-perf-test \
  --env REST_URL=http://$TB_INTERNAL_IP:8080 \
  --env MQTT_HOST=$TB_INTERNAL_IP \
  --env DEVICE_END_IDX=5000 \
  --env MESSAGES_PER_SECOND=1000 \
  --env ALARMS_PER_SECOND=10 \
  --env DURATION_IN_SECONDS=86400 \
  --env DEVICE_CREATE_ON_START=true \
  thingsboard/tb-ce-performance-test:3.3.3
```
{: .copy-code}