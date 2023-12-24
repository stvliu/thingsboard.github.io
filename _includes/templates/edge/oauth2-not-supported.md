{% capture oauth2-not-supported %}
目前，Edge 不支持 OAuth 2.0 用于登录目的。如果您希望使用 OAuth 2.0 用户凭据访问 Edge，则需要为此用户在 ThingsBoard 服务器上分配一个密码。
{% endcapture %}
{% include templates/warn-banner.md content=oauth2-not-supported %}