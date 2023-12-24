---
layout: docwithnav-mqtt-broker
title: 使用 AWS 基础设施的集群设置
description: 在 AWS EKS 中使用 Kubernetes 设置 TBMQ 微服务

tbmq-rds-set-up:
  0:
    image: /images/mqtt-broker/install/aws-rds-vpc.png
    title: 'AWS RDS 连接 - 选择与集群名称相同的 VPC'
  1:
    image: /images/mqtt-broker/install/aws-rds-vpc-sg.png
    title: 'AWS RDS SG - 选择“eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*”安全组'
  2:
    image: /images/mqtt-broker/install/aws-rds-default-database.png
    title: 'AWS RDS 其他配置 - 为初始数据库名称输入“thingsboard_mqtt_broker”'

tbmq-msk-set-up:
  0:
    image: /images/mqtt-broker/install/aws-msk-creation.png
    title: 'AWS MSK - 创建集群'

tbmq-msk-configuration:
  0:
    image: /images/mqtt-broker/install/aws-msk-vpc.png
    title: 'AWS MSK - 选择 TBMQ 集群的 VPC'
  1:
    image: /images/mqtt-broker/install/aws-msk-vpc-sg.png
    title: 'AWS MSK - 选择“eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*”安全组'
  2:
    image: /images/mqtt-broker/install/aws-msk-security.png
    title: 'AWS MSK - 启用客户端和代理之间的明文通信'

tbmq-redis-set-up:
  0:
    image: /images/mqtt-broker/install/aws-redis-create.png
    title: 'AWS ElastiCache - 创建 Redis 集群'
  1:
    image: /images/mqtt-broker/install/aws-redis-cluster-settings.png
    title: 'AWS ElastiCache - 选择 7.x 引擎版本和适当的节点类型'
  2:
    image: /images/mqtt-broker/install/aws-redis-connectivity.png
    title: 'AWS ElastiCache - 选择 TBMQ VPC 和专用子网'  
  3:
    image: /images/mqtt-broker/install/aws-redis-advanced.png
    title: 'AWS ElastiCache - 选择“eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*”安全组'

tbmq-rds-link-configure:
  0:
    image: /images/mqtt-broker/install/aws-rds-endpoint.png
    title: 'AWS RDS 详细信息'

tbmq-msk-link-configure:
  0:
    image: /images/mqtt-broker/install/aws-msk-arn.png
    title: 'AWS MSK 详细信息'
    
tbmq-redis-link-configure:
  0:
    image: /images/mqtt-broker/install/aws-redis-result.png
    title: 'AWS ElastiCache 详细信息'

---

{% include docs/mqtt-broker/install/aws-cluster-setup.md %}