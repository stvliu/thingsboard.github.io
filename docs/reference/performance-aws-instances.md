---
layout: docwithnav
title: ThingsBoard 不同 AWS 实例上的性能
description: ThingsBoard 不同 AWS 实例上的性能结果

postgres-only-1000:
    0:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/queue-stats.png  
        title: 'Thingsboard 队列统计'
    1:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/api-usage.png
        title: 'Thingsboard API 使用情况'
    2:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/htop.png
        title: 'htop'
    3:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/jmx-visualvm-monitoring.png
        title: 'JMX VisualVM 监控'
    4:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/postgresql-pgadmin-dashboard.png
        title: 'Postgresql PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/aws-instance-monitoring.png
        title: 'AWS 实例监控'
    6:
        image: /images/reference/performance-aws-instances/method/t3-medium/postgres/aws-storage-monitoring.png
        title: 'AWS 存储监控'

postgres-only-1000-arm:
    0:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/queue-stats.png  
        title: 'ARM 架构上的 Thingsboard 队列统计'
    1:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/api-usage.png
        title: 'ARM 架构上的 Thingsboard API 使用情况'
    2:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/htop.png
        title: 'ARM 架构上的 htop'
    3:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/jmx-visualvm-monitoring.png
        title: 'ARM 架构上的 JMX VisualVM 监控'
    4:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/postgresql-pgadmin-dashboard.png
        title: 'ARM 架构上的 Postgresql PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/aws-instance-monitoring.png
        title: 'ARM 架构上的 AWS 实例监控'
    6:
        image: /images/reference/performance-aws-instances/method/arm/t4g-medium/postgres/aws-storage-monitoring.png
        title: 'ARM 架构上的 AWS 存储监控'

postgres-only-x3-stress:
    0:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-queue-stats.png  
        title: 'Thingsboard 队列统计'
    1:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-api-usage.png
        title: 'Thingsboard API 使用情况'
    2:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-htop.png
        title: 'htop'
    3:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-jmx-visualvm-monitoring.png
        title: 'JMX VisualVM 监控'
    4:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-postgresql-pgadmin-dashboard.png
        title: 'Postgresql PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-aws-instance-monitoring.png
        title: 'AWS 实例监控'
    6:
        image: /images/reference/performance-aws-instances/method/t3-medium/burst-x3/burst-x3-aws-storage-monitoring.png
        title: 'AWS 存储监控'

postgres-only-x10-stress:
    0:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/beginning-htop.png  
        title: '开始时 100% CPU 负载 x10 压力测试'
    1:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/beginning-queue-stats.png
        title: '队列统计 - 性能下降'
    2:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/beginning-jmx-visualvm-monitoring.png
        title: 'JMX 监视器上的堆内存使用量不断增长'
    3:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/queue-stats.png
        title: '队列统计降至零，不再响应'
    4:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/htop.png
        title: 'CPU 仍然是 100% 负载，但主要用于垃圾回收器'
    5:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/jmx-visualvm-monitoring.png
        title: '由于内存不足，系统正在死亡时进行 JMX VusialVM 监控'
    6:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/out-of-memory.png
        title: '内存不足日志消息'
    7:
        image: /images/reference/performance-aws-instances/method/t3-medium/flood-x10/aws-instance-monitoring.png
        title: 'x10 压力测试期间的 AWS 实例监控'

postgres-only-6000:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-queue-stats-dashboard.png  
        title: '队列统计仪表板'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-api-usage-dashboard.png
        title: 'Thingsboard API 使用情况仪表板'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-htop-cpu-memory-io-monitoring.png
        title: 'htop：CPU、内存、IO 读/写'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-jmx-visualvm-monitoring.png
        title: '使用 JMX VisualVM 进行 Java CPU 和堆监控'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-postgresql-pgadmin-dashboard.png
        title: 'Postgres PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-cpu-network-monitoring.png
        title: 'AWS CPU 和网络监控'
    6:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-disk-monitoring.png
        title: 'AWS 存储监控'
    7:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres/thingsboard-aws-m6a-large-disk-type.png
        title: '存储类型 GP3，3000 IOPS，125 MB/s'

postgres-kafka-5000:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/queue-stats.png  
        title: 'Thingsboard 队列统计'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/api-usage.png
        title: 'Thingsboard API 使用情况'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/htop.png
        title: 'htop'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/jmx-visualvm-monitoring.png
        title: 'JMX VisualVM 监控'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/postgresql-pgadmin-dashboard.png
        title: 'Postgresql PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/aws-instance-monitoring.png
        title: 'AWS 实例监控'
    6:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/aws-storage-monitoring.png
        title: 'AWS 存储监控'

postgres-kafka-5000-long-running:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/long-running/queue-stats-long-running.png  
        title: 'Thingsboard 队列统计'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/long-running/api-usage-long-running.png
        title: 'Thingsboard API 使用情况'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/long-running/jmx-visualvm-monitoring-long-running.png
        title: 'JMX VisualVM 监控'

postgres-kafka-x3-stress:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/htop-stress-x3.png  
        title: '100% CPU 利用率。系统超载'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/queue-stats-stress-x3.png
        title: 'x3 压力测试下的 Thingsboard 队列统计'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/jmx-visualvm-monitoring-long-running-stress-x3.png
        title: 'Java 机器感觉良好。堆内存有足够的空间运行'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/kafka-producer-jmx-mbean-stress-x3.png
        title: '具有 JMX MBean 的 Kafka 生产者状态'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/kafka-lag-stress-x3.png
        title: 'Kafka Lag 正在累积'
   
postgres-kafka-x3-stress-back-to-x1:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/queue-stats--x1--stress-x3--x1.png
        title: 'x1、x3 和返回 x1 负载的规则引擎统计信息'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/api-usage--x1--stress-x3--x1.png
        title: '以下是显示传输速率（传入消息和数据点）和规则引擎性能的 API 使用情况统计信息'
    2:
       image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/kafka-lag-stress-x3-after.png  
       title: 'Kafka 延迟正在下降'

cassandra-25k-10k-30k:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/queue-stats.png  
        title: '队列统计仪表板'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/api-usage.png
        title: 'Thingsboard API 使用情况仪表板'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/htop.png
        title: 'htop：CPU、内存、IO 读/写'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/postgresql-pgadmin-dashboard.png
        title: 'Postgres PgAdmin 仪表板'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/aws-instance-monitoring.png
        title: 'AWS CPU 和网络监控'
    5:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/aws-storage-monitoring.png
        title: 'AWS 存储监控'

cassandra-25k-10k-30k-disk:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/cassandra-disk-size.png
        title: 'Cassandra 磁盘大小使用情况'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/telemetry-persisted-chart.png
        title: '遥测持久化图表'

cassandra-25k-10k-30k-jmx:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/visualvm-forwarded-applications.png
        title: 'VisualVM Java 应用程序列表'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/jmx-thingsboard.png
        title: 'Thingsboard 的 JMX 监控。系统稳定'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/jmx-kafka.png
        title: 'Kafka 的 JMX 监控。系统稳定'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/jmx-zookeeper.png
        title: 'Zookeeper 的 JMX 监控。系统稳定'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/25k-10k-30k/jmx-cassandra.png
        title: 'Cassandra 的 JMX 监控。系统稳定'

cassandra-100k-5k-15k:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/queue-stats.png  
        title: '队列统计仪表板'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/api-usage.png
        title: 'Thingsboard API 使用情况仪表板'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/htop.png
        title: 'htop：CPU、内存、IO 读/写'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/jmx-visualvm-monitoring.png
        title: 'JMX VisualVM 监控'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/postgresql-pgadmin-dashboard.png
        title: 'Postgres PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/aws-instance-monitoring.png
        title: 'AWS CPU 和网络监控'
    6:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/aws-storage-monitoring.png
        title: 'AWS 存储监控'
    7:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/disk-usage-cassandra.png
        title: 'Cassandra 磁盘使用情况'

cassandra-100k-10k-30k:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/queue-stats.png  
        title: '队列统计仪表板'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/api-usage.png
        title: 'Thingsboard API 使用情况仪表板'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/htop.png
        title: 'htop：CPU、内存、IO 读/写'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/jmx-visualvm-monitoring.png
        title: 'JMX VisualVM 监控'
    4:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/postgresql-pgadmin-dashboard.png
        title: 'Postgres PgAdmin 仪表板'
    5:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/aws-instance-monitoring.png
        title: 'AWS CPU 和网络监控'
    6:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/aws-storage-monitoring.png
        title: 'AWS 存储监控'

cassandra-100k-10k-30k-24h:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/24h-run/queue-stats.png  
        title: '队列统计仪表板'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/24h-run/api-usage.png
        title: 'Thingsboard API 使用情况仪表板'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/24h-run/aws-instance-monitoring.png
        title: 'AWS CPU 和网络监控'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-10k-30k/24h-run/aws-storage-monitoring.png
        title: 'AWS 存储监控'

thingsboard-100k-devices-connected:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-is-connected/devices-list-100k-thingsboard.png  
        title: '100k+ 行的设备列表'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-is-connected/jmx-mbeans-java-lang-operating-system-open-file-descriptor-count.png
        title: 'Jmx MBeans java.lang.operating_system open_file_descriptor_count'

postgres-kafka-disk-usage:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/postgresql-disk-usage-total.png  
        title: 'Postgres 磁盘使用情况总计'
    1:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/postgresql-disk-usage-by-table.png
        title: 'Postgres 磁盘使用情况按表'
    2:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/kafka-disk-usage-total.png
        title: 'Kafka 磁盘使用情况总计'
    3:
        image: /images/reference/performance-aws-instances/method/m6a-large/postgres-kafka/stress-x3/kafka-disk-usage-by-topic.png
        title: 'Kafka 磁盘使用情况按主题'

cassandra-disk-usage:
    0:
        image: /images/reference/performance-aws-instances/method/m6a-2xlarge/100k-5k-15k/disk-usage-cassandra.png  
        title: 'Cassandra 磁盘使用情况约为 20 GiB，每 1.3B 个数据点'