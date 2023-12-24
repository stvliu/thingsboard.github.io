## 升级

如果需要数据库升级，编辑 .env 文件将“TB_VERSION”设置为目标版本（例如，如果您要升级到最新版本，请将其设置为 {{ site.release.ce_full_ver }}）。然后，执行以下命令：

```bash
./docker-stop-services.sh
./docker-upgrade-tb.sh --fromVersion=[FROM_VERSION]
./docker-start-services.sh
```
{: .copy-code}

其中 `FROM_VERSION` - 从哪个版本开始升级。有关有效的 `fromVersion` 值，请参阅 [升级说明](/docs/user-guide/install/{{docsPrefix}}upgrade-instructions)。