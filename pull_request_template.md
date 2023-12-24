## PR 描述

已更新 ... 的文档

## 链接检查器

一旦你创建或更新你的 PR，链接将由构建代理自动检查。

你可以使用以下命令在本地检查损坏的链接。

```bash
docker run --rm -it --network=host --name=linkchecker ghcr.io/linkchecker/linkchecker --check-extern --no-warnings http://0.0.0.0:4000/
```