---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 RPC 功能
description: 使用 RPC 功能从 GridLinks IoT 云端远程控制 IoT 设备

tenant-profile-rpc:
    0:
        image: /images/user-guide/persistent-rpc/tenant-rpc-pe.png
        title: '单击屏幕右上角的橙色铅笔图标以进入仪表板编辑模式。'
    1:
        image: /images/user-guide/persistent-rpc/tenant-rpc-1-pe.png
        title: '在 RPC TTL 天数行中设置天数。单击页面右上角的橙色复选标记图标应用更改。'

rule-chain:
    0:
        image: /images/user-guide/persistent-rpc/rule-chain-pe.png

rpc-test:
    0:
        image: /images/user-guide/persistent-rpc/rpc-test-pe.png
        title: '单击屏幕右下角的橙色铅笔图标以进入仪表板编辑模式。'
    1:
        image: /images/user-guide/persistent-rpc/rpc-test-1-pe.png
        title: '单击 RPC 调试终端右上角的铅笔图标以进入小部件编辑模式。'
    3:
        image: /images/user-guide/persistent-rpc/rpc-test-2-pe.png
        title: '转到高级选项卡，增加 RPC 的请求超时时间，并选中“RPC 请求持久”复选框以启用它。单击窗口右上角的橙色复选标记图标应用更改。'
    4:
        image: /images/user-guide/persistent-rpc/rpc-test-3-pe.png
        title: '单击屏幕右下角的橙色复选标记图标保存所有应用的更改。'
    5:
        image: /images/user-guide/persistent-rpc/rpc-test-4-pe.png
        title: '在本教程中，我们将使用命令“test”。如您所见，响应包含 RPC ID。'

client-side-rpc-rule-chain:
    0:
        image: /images/user-guide/rpc/client-side-rpc-rule-chain-pe-1.png
        title: '编辑根规则链。用“脚本”转换节点替换“日志”操作节点。添加具有默认配置的“RPC 调用回复”操作节点。'
    1:
        image: /images/user-guide/rpc/client-side-rpc-rule-chain-pe-2.png
        title: '从文档中复制粘贴 JS 代码。'

server-side-rpc-rule-chain:
    0:
        image: /images/user-guide/rpc/server-side-rpc-rule-chain-pe-1.png
        title: '编辑根规则链。添加生成器节点并将其连接到“RPC 调用请求”规则节点。'
    1:
        image: /images/user-guide/rpc/server-side-rpc-rule-chain-pe-2.png
        title: '从文档中复制粘贴 JS 代码。'

---

{% assign docsPrefix = "pe/" %}
{% include docs/user-guide/rpc.md %}