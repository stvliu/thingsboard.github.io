---
layout: docwithnav
assignees:
- ashvayka
title: 升级说明
description: GridLinks物联网平台升级说明
---

<!-- <h3>In order to update GridLinks PE please follow <a style="pointer-events: all;" href="/docs/user-guide/install/pe/upgrade-instructions/">these instructions</a></h3> -->

<ul id="markdown-toc">
    <li>
      <a href="#upgrading-to-361" id="markdown-toc-upgrading-to-361">升级到 3.6.1</a>
      <ul>
          <li>
              <a href="#ubuntucentos-361" id="markdown-toc-ubuntucentos-361">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-361" id="markdown-toc-windows-361">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-36" id="markdown-toc-upgrading-to-36">升级到 3.6</a>
      <ul>
          <li>
              <a href="#ubuntucentos-36" id="markdown-toc-ubuntucentos-36">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-36" id="markdown-toc-windows-36">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-351" id="markdown-toc-upgrading-to-351">升级到 3.5.1</a>
      <ul>
          <li>
              <a href="#ubuntucentos-351" id="markdown-toc-ubuntucentos-351">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-351" id="markdown-toc-windows-351">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-35" id="markdown-toc-upgrading-to-35">升级到 3.5</a>
      <ul>
          <li>
              <a href="#ubuntucentos-35" id="markdown-toc-ubuntucentos-35">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-35" id="markdown-toc-windows-35">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-344" id="markdown-toc-upgrading-to-344">升级到 3.4.4</a>
      <ul>
          <li>
              <a href="#ubuntucentos-344" id="markdown-toc-ubuntucentos-344">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-344" id="markdown-toc-windows-344">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-343" id="markdown-toc-upgrading-to-343">升级到 3.4.3</a>
      <ul>
          <li>
              <a href="#ubuntucentos-343" id="markdown-toc-ubuntucentos-343">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-343" id="markdown-toc-windows-343">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-342" id="markdown-toc-upgrading-to-342">升级到 3.4.2</a>
      <ul>
          <li>
              <a href="#ubuntucentos-342" id="markdown-toc-ubuntucentos-342">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-342" id="markdown-toc-windows-342">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-341" id="markdown-toc-upgrading-to-341">升级到 3.4.1</a>
      <ul>
          <li>
              <a href="#ubuntucentos-341" id="markdown-toc-ubuntucentos-341">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-341" id="markdown-toc-windows-341">Windows</a>
          </li>
      </ul>
    </li>
    <li>
      <a href="#upgrading-to-34" id="markdown-toc-upgrading-to-34">升级到 3.4</a>
      <ul>
          <li>
              <a href="#ubuntucentos-34" id="markdown-toc-ubuntucentos-34">Ubuntu/CentOS</a>
          </li>
          <li>
              <a href="#windows-34" id="markdown-toc-windows-34">Windows</a>
          </li>
      </ul>
    </li>
</ul>

## 升级到 3.6.1 {#upgrading-to-361}

### Ubuntu/CentOS {#ubuntucentos-361}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.6. In order to upgrade to 3.6.1 you need to [**upgrade to 3.6 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-36).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks安装包下载

{% capture tabspec %}gridlinks-download-3-6-1
gridlinks-download-3-6-1-ubuntu,Ubuntu,shell,resources/3.6.1/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.6.1/gridlinks-ubuntu-download.sh
gridlinks-download-3-6-1-centos,CentOS,shell,resources/3.6.1/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.6.1/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-6-1
gridlinks-installation-3-6-1-ubuntu,Ubuntu,shell,resources/3.6.1/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.6.1/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-6-1-centos,CentOS,shell,resources/3.6.1/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.6.1/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.6.0
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-361}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.6. In order to upgrade to 3.6.1 you need to [**upgrade to 3.6 first**](/docs/user-guide/install/upgrade-instructions/#windows-36).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.6.1.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.6.1/gridlinks-windows-3.6.1.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.6.0
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.6 {#upgrading-to-36}

### Ubuntu/CentOS {#ubuntucentos-36}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.5.1. In order to upgrade to 3.6 you need to [**upgrade to 3.5.1 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-351).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-6
gridlinks-download-3-6-ubuntu,Ubuntu,shell,resources/3.6/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.6/gridlinks-ubuntu-download.sh
gridlinks-download-3-6-centos,CentOS,shell,resources/3.6/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.6/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-5
gridlinks-installation-3-6-ubuntu,Ubuntu,shell,resources/3.6/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.6/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-6-centos,CentOS,shell,resources/3.6/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.6/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.5.1
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-36}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.5.1. In order to upgrade to 3.6 you need to [**upgrade to 3.5.1 first**](/docs/user-guide/install/upgrade-instructions/#windows-351).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.6.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.6/gridlinks-windows-3.6.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.5.1
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.5.1 {#upgrading-to-351}

### Ubuntu/CentOS {#ubuntucentos-351}

{% capture difference %}
**NOTE**:
<br>
These upgrade steps are applicable for GridLinks version 3.5. In order to upgrade to 3.5.1 you need to [**upgrade to 3.5 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-35).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-5-1
gridlinks-download-3-5-1-ubuntu,Ubuntu,shell,resources/3.5.1/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.5.1/gridlinks-ubuntu-download.sh
gridlinks-download-3-5-1-centos,CentOS,shell,resources/3.5.1/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.5.1/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-5-1
gridlinks-installation-3-5-1-ubuntu,Ubuntu,shell,resources/3.5.1/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.5.1/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-5-1-centos,CentOS,shell,resources/3.5.1/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.5.1/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.5.0
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-351}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.5. In order to upgrade to 3.5.1 you need to [**upgrade to 3.5 first**](/docs/user-guide/install/upgrade-instructions/#windows-35).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.5.1.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.5.1/gridlinks-windows-3.5.1.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.5.0
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.5 {#upgrading-to-35}

### Ubuntu/CentOS {#ubuntucentos-35}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.4. In order to upgrade to 3.5 you need to [**upgrade to 3.4.4 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-344).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include templates/install/tb-350-update.md %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-5
gridlinks-download-3-5-ubuntu,Ubuntu,shell,resources/3.5/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.5/gridlinks-ubuntu-download.sh
gridlinks-download-3-5-centos,CentOS,shell,resources/3.5/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.5/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-5
gridlinks-installation-3-5-ubuntu,Ubuntu,shell,resources/3.5/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.5/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-5-centos,CentOS,shell,resources/3.5/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.5/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.4.4
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-35}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.4. In order to upgrade to 3.5 you need to [**upgrade to 3.4.4 first**](/docs/user-guide/install/upgrade-instructions/#windows-344).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include templates/install/tb-350-update.md %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.5.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.5/gridlinks-windows-3.5.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.4.4
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.4.4 {#upgrading-to-344}

### Ubuntu/CentOS {#ubuntucentos-344}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.3. In order to upgrade to 3.4.4 you need to [**upgrade to 3.4.3 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-343).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-4-4
gridlinks-download-3-4-4-ubuntu,Ubuntu,shell,resources/3.4.4/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.4.4/gridlinks-ubuntu-download.sh
gridlinks-download-3-4-4-centos,CentOS,shell,resources/3.4.4/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.4.4/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-4-4
gridlinks-installation-3-4-4-ubuntu,Ubuntu,shell,resources/3.4.4/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.4.4/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-4-4-centos,CentOS,shell,resources/3.4.4/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.4.4/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-344}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.3. In order to upgrade to 3.4.4 you need to [**upgrade to 3.4.3 first**](/docs/user-guide/install/upgrade-instructions/#windows-343).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.4.4.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.4.4/gridlinks-windows-3.4.4.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.4.3 {#upgrading-to-343}

### Ubuntu/CentOS {#ubuntucentos-343}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.2. In order to upgrade to 3.4.3 you need to [**upgrade to 3.4.2 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-342).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-4-3
gridlinks-download-3-4-3-ubuntu,Ubuntu,shell,resources/3.4.3/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.4.3/gridlinks-ubuntu-download.sh
gridlinks-download-3-4-3-centos,CentOS,shell,resources/3.4.3/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.4.3/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-4-3
gridlinks-installation-3-4-3-ubuntu,Ubuntu,shell,resources/3.4.3/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.4.3/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-4-3-centos,CentOS,shell,resources/3.4.3/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.4.3/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-343}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.2. In order to upgrade to 3.4.3 you need to [**upgrade to 3.4.2 first**](/docs/user-guide/install/upgrade-instructions/#windows-342).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.4.3.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.4.3/gridlinks-windows-3.4.3.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.4.2 {#upgrading-to-342}

### Ubuntu/CentOS {#ubuntucentos-342}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.1. In order to upgrade to 3.4.2 you need to [**upgrade to 3.4.1 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-341).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-4-2
gridlinks-download-3-4-2-ubuntu,Ubuntu,shell,resources/3.4.2/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.4.2/gridlinks-ubuntu-download.sh
gridlinks-download-3-4-2-centos,CentOS,shell,resources/3.4.2/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.4.2/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-4-2
gridlinks-installation-3-4-2-ubuntu,Ubuntu,shell,resources/3.4.2/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.4.2/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-4-2-centos,CentOS,shell,resources/3.4.2/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.4.2/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.4.1
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

{% capture default-jwt %}
Update the JWT signing key if you use the default one "gridlinksDefaultSigningKey" on production environments. See [JWT security settings](/docs/user-guide/ui/jwt-security-settings/) for details. 
{% endcapture %}
{% include templates/info-banner.md content=default-jwt %}

### Windows {#windows-342}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4.1. In order to upgrade to 3.4.2 you need to [**upgrade to 3.4.1 first**](/docs/user-guide/install/upgrade-instructions/#windows-341).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.4.2.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.4.2/gridlinks-windows-3.4.2.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.4.1
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

{% capture default-jwt %}
Update the JWT signing key if you use the default one "gridlinksDefaultSigningKey" on production environments. See [JWT security settings](/docs/user-guide/ui/jwt-security-settings/) for details. 
{% endcapture %}
{% include templates/info-banner.md content=default-jwt %}

## 升级到 3.4.1 {#upgrading-to-341}

### Ubuntu/CentOS {#ubuntucentos-341}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4. In order to upgrade to 3.4.1 you need to [**upgrade to 3.4 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-34).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-4-1
gridlinks-download-3-4-1-ubuntu,Ubuntu,shell,resources/3.4.1/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.4.1/gridlinks-ubuntu-download.sh
gridlinks-download-3-4-1-centos,CentOS,shell,resources/3.4.1/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.4.1/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-4-1
gridlinks-installation-3-4-1-ubuntu,Ubuntu,shell,resources/3.4.1/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.4.1/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-4-1-centos,CentOS,shell,resources/3.4.1/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.4.1/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.4.0
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-341}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.4. In order to upgrade to 3.4.1 you need to [**upgrade to 3.4 first**](/docs/user-guide/install/upgrade-instructions/#windows-34).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.4.1.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.4.1/gridlinks-windows-3.4.1.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.4.0
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## 升级到 3.4 {#upgrading-to-34}

### Ubuntu/CentOS {#ubuntucentos-34}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.3.4.1. In order to upgrade to 3.4 you need to [**upgrade to 3.3.4.1 first**](/docs/user-guide/install/upgrade-instructions/#ubuntucentos-3341).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

{% capture tabspec %}gridlinks-download-3-4
gridlinks-download-3-4-ubuntu,Ubuntu,shell,resources/3.4/gridlinks-ubuntu-download.sh,/docs/user-guide/install/resources/3.4/gridlinks-ubuntu-download.sh
gridlinks-download-3-4-centos,CentOS,shell,resources/3.4/gridlinks-centos-download.sh,/docs/user-guide/install/resources/3.4/gridlinks-centos-download.sh{% endcapture %}
{% include tabs.html %}

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```bash
sudo service gridlinks stop
```
{: .copy-code}

{% capture tabspec %}gridlinks-installation-3-4
gridlinks-installation-3-4-ubuntu,Ubuntu,shell,resources/3.4/gridlinks-ubuntu-installation.sh,/docs/user-guide/install/resources/3.4/gridlinks-ubuntu-installation.sh
gridlinks-installation-3-4-centos,CentOS,shell,resources/3.4/gridlinks-centos-installation.sh,/docs/user-guide/install/resources/3.4/gridlinks-centos-installation.sh{% endcapture %}
{% include tabs.html %}

{% capture difference %}
**NOTE:**
<br>
Package installer may ask you to merge your gridlinks configuration. It is preferred to use **merge option** to make sure that all your previous parameters will not be overwritten.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```bash
sudo /usr/share/gridlinks/bin/install/upgrade.sh --fromVersion=3.3.4
```
{: .copy-code}

#### Start the service

```bash
sudo service gridlinks start
```
{: .copy-code}

### Windows {#windows-34}

{% capture difference %}
**NOTE:**
<br>
These upgrade steps are applicable for GridLinks version 3.3.4.1. In order to upgrade to 3.4 you need to [**upgrade to 3.3.4.1 first**](/docs/user-guide/install/upgrade-instructions/#windows-3341).
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### GridLinks package download

Download GridLinks installation archive for Windows: [gridlinks-windows-3.4.zip](https://github.com/gridlinks/gridlinks/releases/download/v3.4/gridlinks-windows-3.4.zip).

#### GridLinks service upgrade

* Stop GridLinks service if it is running.

```text
net stop gridlinks
```
{: .copy-code}

* Make a backup of previous GridLinks configuration located in \<GridLinks install dir\>\conf (for ex. C:\gridlinks\conf).
* Remove GridLinks install dir.
* Unzip installation archive to GridLinks install dir.
* Compare and merge your old GridLinks configuration files (from the backup you made in the first step) with new ones.
* Finally, run **upgrade.bat** script to upgrade GridLinks to the new version.

{% capture difference %}
**NOTE:**
<br>
Scripts listed above should be executed using Administrator Role.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Execute regular upgrade script:

```text
C:\gridlinks>upgrade.bat --fromVersion=3.3.4
```
{: .copy-code}

#### Start the service

```text
net start gridlinks
```
{: .copy-code}

## Next steps

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}

