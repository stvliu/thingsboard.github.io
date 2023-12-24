{% capture tb_3_5_0_upgrade_note %}
**在升级到 ThingsBoard 3.5 之前的重要说明**

ThingsBoard UI 已迁移到 Angular 15。您需要在 Angular 15 上重新构建自定义小部件和规则节点（使用 UI）。

我们建议查阅 [**此指南**](https://v15.material.angular.io/guide/mdc-migration)。

{% endcapture %}
{% include templates/warn-banner.md content=tb_3_5_0_upgrade_note %}