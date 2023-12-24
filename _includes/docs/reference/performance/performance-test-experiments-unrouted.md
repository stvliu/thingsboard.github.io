## 实验

Postgres + Kafka + Cassandra

### Cassandra 4.0 与 3.11 版本在 AMD 和 Intel 实例上的比较

Cassandra 4.0 m6a.xlarge（4 个 vCPU，16 GiB）

![](/images/reference/performance-aws-instances/method/experiments/img_0.png)

Cassandra 3.11 m6a.xlarge（4 个 vCPU，16 GiB）

![](/images/reference/performance-aws-instances/method/experiments/img_1.png)

Cassandra 4.0 c6i.xlarge（4 个 vCPU，8 GiB）

![](/images/reference/performance-aws-instances/method/experiments/img_2.png)

### 最大消息速率实验 Cassandra 4.0 m6a.4xlarge（16 个 vCPU，32 GiB）

Cassandra 4.0 m6a.4xlarge（16 个 vCPU，32 GiB）

5k 个设备，15k 条消息/秒，45k 个数据点/秒 -- 100% 处理

![](/images/reference/performance-aws-instances/method/experiments/img_4.png)

![](/images/reference/performance-aws-instances/method/experiments/img_3.png)

5k 个设备，25k 条消息/秒，75k 个数据点/秒 -- 100% 处理

![](/images/reference/performance-aws-instances/method/experiments/img_5.png)

![](/images/reference/performance-aws-instances/method/experiments/img_6.png)

5k 个设备，40k 条消息/秒，120k 个数据点/秒 - 瓶颈

![](/images/reference/performance-aws-instances/method/experiments/img_8.png)

CPU 约为 60%，因此出现了瓶颈。

![](/images/reference/performance-aws-instances/method/experiments/img_7.png)

我们尝试将时间序列写入而不将最新值持久化到 PostgreSQL - 无效果

![](/images/reference/performance-aws-instances/method/experiments/img_9.png)