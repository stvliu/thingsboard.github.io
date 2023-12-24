安装和连接 Edge 到服务器的最直接方法是利用 GridLinks Server 提供的已准备好的安装说明。
对于每个 Edge 实体，服务器已准备了说明，其中已填充了字段，例如 Edge 密钥、Edge 路由密钥、Edge RPC 主机 URI 等。
请按照以下步骤使用这些已准备好的说明：


{% if docsPrefix == 'pe/edge/' %}

{% assign preparedInstructionsInstall = '
    ===
        image: /images/pe/edge/installation/prepared-instructions-install-item-1.png,
        title: 通过单击 Edge 行打开 Edge 实体详细信息页面；
    ===
        image: /images/pe/edge/installation/prepared-instructions-install-item-2.png,
        title: 单击安装和连接说明；
    ===
        image: /images/pe/edge/installation/prepared-instructions-install-item-3.png,
        title: 按照说明安装 Edge 并连接到服务器。
'%}

{% else %}

{% assign preparedInstructionsInstall = '
    ===
        image: /images/edge/installation/prepared-instructions-install-item-1.png,
        title: 通过单击 Edge 行打开 Edge 实体详细信息页面；
    ===
        image: /images/edge/installation/prepared-instructions-install-item-2.png,
        title: 单击安装和连接说明；
    ===
        image: /images/edge/installation/prepared-instructions-install-item-3.png,
        title: 按照说明安装 Edge 并连接到服务器。
'%}

{% endif %}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=preparedInstructionsInstall %}