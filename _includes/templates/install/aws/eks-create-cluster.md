在 `cluster.yml` 文件中，您可以找到建议的集群配置。
以下是可以根据您的需求更改的字段：
- `region` - 应该是您希望集群所在的 AWS 区域（默认值为 `us-east-1`）
- `availabilityZones` - 应该指定该区域可用区的确切 ID（默认值为 `[us-east-1a,us-east-1b,us-east-1c]`）
- `instanceType` - 带有 TB 节点的实例类型（默认值为 `m5.xlarge`）

**注意**：如果您不对 `instanceType` 和 `desiredCapacity` 字段进行任何更改，EKS 将部署 {{eksNote}}。

{% capture aws-eks-vpc %}

以下命令将为您的 ThingsBoard 集群创建新的 VPC。本指南假设您将创建新的 VPC。
尽管也可以使用现有的 VPC 和子网。
您可以在 [此处](https://eksctl.io/usage/vpc-networking/) 找到有关为 `eksctl` 配置 VPC 的更多信息。

{% endcapture %}
{% include templates/info-banner.md content=aws-eks-vpc %}

创建 AWS 集群的命令：

```
eksctl create cluster -f cluster.yml
```
{: .copy-code}