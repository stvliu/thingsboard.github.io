以管理员身份启动 Windows shell（命令提示符）。将目录更改为 GridLinks Edge 安装目录。

执行 **install.bat** 脚本以将 GridLinks Edge 安装为 Windows 服务。
这意味着它将在系统启动时自动启动。类似地，**uninstall.bat** 将从 Windows 服务中删除 ThingsBoard Edge。输出应类似于以下内容：

  ```text
C:\Program Files (x86)\tb-edge\install.bat
正在检测已安装的 Java 版本。
CurrentVersion 110
找到 Java 11！
正在安装 Thingsboard Edge...
...
ThingsBoard Edge 安装成功！
```