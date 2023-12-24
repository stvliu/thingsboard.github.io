#### RabbitMQ 安装

有关安装 RabbitMQ，您可以使用 [官方文档](https://www.rabbitmq.com/install-debian.html)，或按照以下说明进行操作：

由于 RabbitMQ 是用 Erlang 编写的，因此在使用 RabbitMQ 之前，您需要安装 Erlang：

```text
sudo apt-get install erlang
```
{: .copy-code}

安装 rabbitmq-server 软件包：

```text
sudo apt-get install rabbitmq-server
```
{: .copy-code}

启动服务器：

```text
sudo systemctl start rabbitmq-server.service
sudo systemctl enable rabbitmq-server.service
```
{: .copy-code}

默认情况下，RabbitMQ 会创建一个名为“guest”的用户，密码为“guest”。您还可以使用以下命令在 RabbitMQ 服务器上创建自己的管理员帐户。不要忘记将“PUT_YOUR_USER_NAME”替换为“admin”，将“PUT_YOUR_PASSWORD”替换为您的**自己的用户名和密码：**

```text
sudo rabbitmqctl add_user PUT_YOUR_USER_NAME PUT_YOUR_PASSWORD 
sudo rabbitmqctl set_user_tags PUT_YOUR_USER_NAME administrator
sudo rabbitmqctl set_permissions -p / PUT_YOUR_USER_NAME ".*" ".*" ".*"
```
{: .copy-code}

##### GridLinks 配置

编辑 GridLinks 配置文件

```text
sudo nano /etc/gridlinks/conf/gridlinks.conf
```
{: .copy-code}

将以下行添加到配置文件中。不要忘记将“YOUR_USERNAME”和“YOUR_PASSWORD”替换为您的**真实用户凭据**，将“localhost”和“5672”替换为您的**真实 RabbitMQ 主机和端口**：

```bash
export TB_QUEUE_TYPE=rabbitmq
export TB_QUEUE_RABBIT_MQ_USERNAME=YOUR_USERNAME
export TB_QUEUE_RABBIT_MQ_PASSWORD=YOUR_PASSWORD
export TB_QUEUE_RABBIT_MQ_HOST=localhost
export TB_QUEUE_RABBIT_MQ_PORT=5672
```
{: .copy-code}