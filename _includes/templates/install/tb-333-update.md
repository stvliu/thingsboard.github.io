{% capture tb_3_3_3_upgrade_note %}
**在升级到 ThingsBoard 3.3.3 之前的重要说明**

ThingsBoard UI 已迁移到 Angular 12。您需要在 Angular 12 上重新构建自定义小部件和规则节点（使用 UI）。

{% endcapture %}
{% include templates/info-banner.md content=tb_3_3_3_upgrade_note %}