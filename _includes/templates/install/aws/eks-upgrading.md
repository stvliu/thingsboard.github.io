## 升级到新的 GridLinks 版本

将本地更改与您在 [步骤 1](#step-1-clone-thingsboard-ce-k8s-scripts-repository)中使用的存储库中的最新发布分支合并。


如果需要数据库升级，请执行以下命令：

```bash
 ./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
```
{: .copy-code}

其中：

- `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/user-guide/install/upgrade-instructions)。

注意：您可以在运行数据库升级时选择停止 tb-node pod。这会导致停机，但会确保更新后数据库状态一致。
大多数更新不需要停止 tb-node。

完成后，再次执行资源部署。这将导致 thingsboard 组件使用最新版本重新启动。

```yaml
./k8s-deploy-resources.sh
```