{% capture remote_note %}
{{integrationName}} 集成只能作为 [远程集成](/docs/pe/edge/user-guide/integrations/remote-integrations) 启动。它可以在运行 TB Edge 实例的同一台机器上启动，或者你可以在另一台机器上启动，该机器可以通过网络访问 TB Edge 实例。
{% endcapture %}
{% include templates/info-banner.md content=remote_note %}