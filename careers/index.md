---
layout: careers
title: 职业生涯
notitle: "true"
description: ThingsBoard 职业生涯
---

## 职业生涯
## 我们欢迎聪明且善于沟通的人才加入我们在基辅的团队。

<hr>
<div id="carsGrid">
{% for career in site.careers %}
  <a class="cars-box" href="{{ career.url }}">
  <div><h3>{{ career.position }}</h3>
  <h5>{{ career.tag }}</h5></div>
  <h5 class="secondPriority">{{ career.location }}</h5>
  </a>
{% endfor %}
</div>

<div id="technology">
<object data="/images/careers/angular.svg"></object>
<object data="/images/careers/spring.svg"></object>
<object data="/images/careers/java.svg"></object>
<object data="/images/careers/typescript.svg"></object>
<object data="/images/careers/kafka.svg"></object>
<object data="/images/careers/redis.svg"></object>
<object data="/images/careers/cassandra.svg"></object>
<object data="/images/careers/postgresql.svg"></object>
<object data="/images/careers/docker.svg"></object>
<object data="/images/careers/kubernets.svg"></object>
<object data="/images/careers/github.svg"></object>
<object data="/images/careers/aws.svg"></object>
<object data="/images/careers/azure.svg"></object>
<object data="/images/careers/google-cloud.svg"></object>
</div>

<div id="about">
<p class="title">关于我们：</p>
<h5>ThingsBoard, Inc. 是一家成立于 2016 年的美国公司，在乌克兰基辅设有研发中心。我们是 ThingsBoard 开源物联网平台的主要贡献者和维护者。<br>
<br>我们提供并不断改进可扩展、强大且价格合理的物联网平台，可大幅缩短改变生活的物联网解决方案的上市时间。我们还帮助公司基于 ThingsBoard 提供出色的物联网产品。</h5>
</div>

<h2>我们的工作方式：</h2>
<div id="advanGrid">
    <div>
      <img class="advanImg" src="/images/careers/schedule_icon.svg" alt="schedule icon">
      <h5>舒适且灵活的工作时间</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/support_icon.svg" alt="support icon">
      <h5>一支没有官僚主义的高专业团队</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/target_icon.svg" alt="target icon">
      <h5>职业发展机会和定期薪酬审查</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/vacation_icon.svg" alt="vacation icon">
      <h5>团队建设、公司活动、带薪休假和病假</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/sweet_icon.svg" alt="sweet icon">
      <h5>无限量饮料、水果和甜点</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/english_icon.svg" alt="english icon">
      <h5>免费英语课程</h5>
    </div>
    <div>
      <img class="advanImg" src="/images/careers/medical_icon.svg" alt="medical icon">
      <h5>医疗保险</h5>
    </div>
</div>