{% capture debug_note %}
虽然 **调试** 模式对于开发和故障排除非常有用，但在生产模式下启用它会显著增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在调试完成后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md content=debug_note %}