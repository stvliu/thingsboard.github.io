{% if page.cards %}<!-- check for this before going any further; if not present, skip to else at bottom -->
<style>
h2, h3, h4 {
  border-bottom: 0px !important;
  font-size: 22px !important;
  padding-bottom: 20px !important;
}
.colContainer {
  padding-top:2px;
  padding-left: 2px;
  overflow: auto;
}
#samples a {
  color: #000;
}
.col3rd {
  display: block;
  float: left;
  margin-right: 30px;
  margin-bottom: 30px;
  overflow: hidden;
}
.col3rd h3, .col2nd h3 {
  margin-bottom: 0px !important;
}
.col3rd .button, .col2nd .button {
  margin-top: 20px;
  border-radius: 2px;
}
.col3rd p, .col2nd p {
  margin-left: 2px;
}
.col2nd {
  display: block;
  width: 400px;
  float: left;
  margin-right: 30px;
  margin-bottom: 30px;
  overflow: hidden;
}
.shadowbox {
  width: 250px;
  display: inline;
  float: left;
  text-transform: none;
  font-weight: bold;
  text-overflow: ellipsis;
  overflow: hidden;
  line-height: 24px;
  position: relative;
  display: block;
  cursor: pointer;
  box-shadow: 0 2px 2px rgba(0,0,0,.24),0 0 2px rgba(0,0,0,.12);
  border-radius: 5px;
  background: #fff;
  transition: all .3s;
  padding: 16px;
  margin: 0 16px 16px 0;
  text-decoration: none;
  letter-spacing: .01em;
  height: 220px;
}
.shadowbox img {
    min-width: 100px;
    max-width: 100px;
    max-height: 50px;
    margin-right: 5px;
    margin-bottom: 5px;
    float: left;
}
</style>

<div class="colContainer">
{% for card in page.cards %}{% if card.title %}
  <div class="col3rd shadowbox">
    <h3>{{card.title}}</h3>
    <p>{% if card.image %}<img src="{{card.image}}" alt="card image">{% endif %}{{card.description}}</p>
  </div>
{% endif %}{% endfor %}
</div>

{% else %}

### 错误：您必须定义“cards”前端 YAML
{: style="color:red" }

此模板要求您在文档顶部插入 YAML，以定义您希望在页面上显示的“卡片”。卡片将在可点击的框中呈现。

要摆脱此消息并利用此模板，请定义 `cards`：

```yaml
---
cards:
- progression: no
- card:
  title: Mean Stack
  image: /docs/meanstack/image_0.png
  description:
- card:
  title: Guestbook + Redis
  image: /images/docs/redis.svg
  description:
- card:
  title: Cloud Native Cassandra
  image: /images/docs/cassandra.svg
  description:
- card:
  title: WordPress + MySQL
  image: /images/docs/wordpress.svg
  description:
---
```

**注意：**如果 `progression` 设置为 `yes`，则第一个卡片上将放置一个“从这里开始！”图标，并且在其他卡片之间会覆盖箭头，表明线性阅读，告诉读者他们应该按一定顺序浏览内容。

{% endif %}