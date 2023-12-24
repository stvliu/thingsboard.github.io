{% capture install_docker_user_to_group %}
**别忘了将你的 Linux 用户添加到 docker 组。请参阅 [以非 root 用户管理 Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)。**
{% endcapture %}
{% include templates/warn-banner.md content=install_docker_user_to_group %}