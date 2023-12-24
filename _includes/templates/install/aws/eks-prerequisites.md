### 安装和配置工具

要在 EKS 集群上部署 ThingsBoard，您需要安装 [`kubectl`](https://kubernetes.io/docs/tasks/tools/)、[`eksctl`](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) 和 [`awscli`](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) 工具。

之后，您需要配置访问密钥、秘密密钥和默认区域。要获取访问密钥和秘密密钥，请按照 [此](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) 指南进行操作。默认区域应该是您想要在其中部署集群的区域的 ID。

```
aws configure
```
{: .copy-code}