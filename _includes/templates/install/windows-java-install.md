ThingsBoard 服务在 Java 11 上运行。请按照以下说明安装 OpenJDK 11。

* 访问 [Open JDK 下载页面](https://adoptopenjdk.net/index.html) 下载最新的 **OpenJDK 11 (LTS)** MSI 软件包。
* 运行下载的 MSI 软件包并按照说明进行操作。确保已选择“**添加到路径**”和“**设置 JAVA_HOME 变量**”选项为“将安装到本地硬盘”状态。
* 访问 [PostgreSQL JDBC 下载页面](https://jdbc.postgresql.org/download/) 下载 PostgreSQL JDBC 驱动程序
* 将下载的文件复制到 **C:\Program Files\AdoptOpenJDK\jdk-11.0.10.9-hotspot\jre\lib\ext** 并添加一个名为 **CLASSPATH** 的全局变量，其值为 **.;"C:\Program Files\AdoptOpenJDK\jdk-11.0.10.9-hotspot\jre\lib\ext\postgresql-42.2.18.jar"** 到您的系统（右键单击“我的电脑”，向下滚动，“高级系统设置”，“高级”，“环境变量...”，在“系统变量”下单击“创建...”）。
* 如果 **jre** 文件夹不存在于 **"C:\Program Files\AdoptOpenJDK\jdk-11.0.10.9-hotspot"** 路径下，请创建此文件夹和所有必需的子文件夹

您可以使用以下命令（使用命令提示符）检查安装情况：

```bash
java -version
```
{: .copy-code}

预期的命令输出是：

```text
C:\Users\User>java -version
openjdk version "11.0.xx"
OpenJDK Runtime Environment (AdoptOpenJDK)(...)
OpenJDK 64-Bit Server VM (AdoptOpenJDK)(...)
```