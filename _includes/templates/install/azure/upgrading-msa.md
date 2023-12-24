如果需要数据库升级，请执行以下命令：

```
 ./k8s-delete-resources.sh
 ./k8s-upgrade-tb.sh --fromVersion=[FROM_VERSION]
 ./k8s-deploy-resources.sh
```

其中：

- `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/user-guide/install/upgrade-instructions)。