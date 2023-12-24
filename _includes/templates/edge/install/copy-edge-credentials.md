在边缘详细信息部分点击 **复制边缘密钥** 和 **复制边缘密钥**。
这会将您的边缘凭据复制到剪贴板。
务必将它们存储在安全的位置，因为在后续步骤中需要这些值。

{% if docsPrefix == 'pe/edge/' %}
{% assign copyEdgeCredentials = '
    ===
        image: /images/pe/edge/installation-copy-edge-credentials-item-1.png
'%}
{% else %}
{% assign copyEdgeCredentials = '
    ===
        image: /images/edge/installation-copy-edge-credentials-item-1.png
'%}
{% endif %}

{% include images-gallery.liquid imageCollection=copyEdgeCredentials %}