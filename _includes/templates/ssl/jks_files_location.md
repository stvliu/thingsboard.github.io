{% capture jks_files_location %}
**确保 ThingsBoard 进程可以访问证书文件：**

* Linux：使用 */etc/thingsboard/conf* 文件夹。确保文件具有与 *thingsboard.conf* 相同的权限；使用相对文件路径，例如 *keystore.p12*；
* Docker Compose：挂载或使用现有卷到容器的 */config* 文件夹；使用完整文件路径，例如 */config/keystore.p12*；
* K8S：将单独的卷挂载到 */https-config* 或类似文件夹。使用完整文件路径，例如 */https-config/keystore.p12*；
* Windows：使用 *C:\Program Files (x86)\thingsboard\conf\\* 文件夹。确保文件具有与 *thingsboard.conf* 相同的权限；使用相对文件路径，例如 *keystore.p12*；

{% endcapture %}
{% include templates/warn-banner.md content=jks_files_location %}