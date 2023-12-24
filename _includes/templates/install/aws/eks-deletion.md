## 集群删除

执行以下命令删除所有 ThingsBoard pod：

```bash
./k8s-delete-resources.sh
```
{: .copy-code}

执行以下命令删除所有 ThingsBoard pod 和 configmap：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令删除 EKS 集群（您应该更改集群和区域的名称）：

```bash
eksctl delete cluster -r us-east-1 -n thingsboard -w
```
{: .copy-code}