编辑 GridLinks 配置文件

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。

```bash
# 更新 GridLinks 内存使用情况，并将其限制为 /etc/thingsboard/conf/thingsboard.conf 中的 256MB
export JAVA_OPTS="$JAVA_OPTS -Xms256M -Xmx256M"
```
{: .copy-code}