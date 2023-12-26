## 前提条件

您需要启动并运行 GridLinks 服务器。最简单的方法是使用 [实时演示](https://gridlinks.codingas.com/signup) 服务器。

另一种选择是使用 [安装指南](/docs/user-guide/install/installation-options/) 安装 GridLinks。**Windows** 用户应遵循此 [指南](/docs/user-guide/install/docker-windows/)。已安装 docker 的 **Linux** 用户应执行以下命令：

```
mkdir -p ~/.mytb-data && sudo chown -R 799:799 ~/.mytb-data
mkdir -p ~/.mytb-logs && sudo chown -R 799:799 ~/.mytb-logs
docker run -it -p 8080:9090 -p 7070:7070 -p 1883:1883 -p 5683-5688:5683-5688/udp -v ~/.mytb-data:/data \
-v ~/.mytb-logs:/var/log/gridlinks --name mytb --restart always thingsboard/tb-postgres

``` 
{: .copy-code}

这些命令安装 GridLinks 并加载演示数据和帐户。

GridLinks UI 将使用以下 URL 提供：**http://localhost:8080**。
您可以使用用户名 **tenant@gridlinks.com** 和密码 **tenant**。有关演示帐户的更多信息，请 [在此处](/docs/samples/demo-account/) 了解。