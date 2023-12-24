## thingsboard.io 简介

我们的网站是开源的。您可以在此 [repo](https://github.com/thingsboard/thingsboard.github.io) 中找到代码。每个人都可以为网站做出贡献。流程如下...

* TOC
{:toc}

## 什么是 fork

如果您不熟悉 GitHub，请在继续之前阅读其文档或询问具有专业知识的同事。
如果您有足够的知识，那么请继续执行以下步骤。确保您已经拥有一个 [GitHub](https://github.com/) 帐户，并且您已成功登录。

* [步骤 1. 可选] 在您的计算机上安装 Git，请参阅 [设置 Git](https://docs.github.com/en/github/getting-started-with-github/set-up-git) 指南。
* [步骤 2. 可选] [使用 SSH 连接到 GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)。
* [步骤 3] 打开 [thingsboard.github.io](https://github.com/thingsboard/thingsboard.github.io) 文档（网站）存储库。
* [步骤 4] Fork 一个 repo（参考 [Fork 一个 repo](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) 指南）[thingsboard.github.io](https://github.com/thingsboard/thingsboard.github.io) 项目。

  ![image](/images/user-guide/fork_button.jpg)

哇！从现在开始，您在您的私有 GitHub 存储库中拥有我们网站的副本。

## ThingsBoard 文档 repo（网站）的本地部署

现在您可以在本地计算机上启动网站以查看最新版本。
thingsboard.io 使用 jekyll 网站生成器。因此，要在本地主机上运行网站，您需要安装一个 jekyll 服务器。

以下命令为在本地运行 GitHub 页面设置您的环境。
您所做的任何编辑都可以在本地计算机上运行的轻量级 Web 服务器上查看。

安装 Ruby 2.2 或更高版本。如果您使用的是 Ubuntu 20.04.1 LTS，请运行以下命令：

	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:brightbox/ruby-ng
	sudo apt-get update
	sudo apt-get install make ruby ruby-dev libffi-dev g++ zlib1g-dev
	sudo gem install github-pages
	sudo gem install jekyll bundler

* 如果您使用的是 Mac，请按照 [这些说明](https://gorails.com/setup/osx/) 进行操作。
* 如果您使用的是 Windows 机器，则可以使用 [Ruby 安装程序](https://rubyinstaller.org/downloads/)。在安装过程中，请务必选中 *将 Ruby 可执行文件添加到您的 PATH* 选项。

克隆我们的网站：

	git clone https://github.com/thingsboard/thingsboard.github.io.git

进行您想要的任何更改。然后，要在本地查看您的更改：

	cd thingsboard.github.io
	bundle install
	bundle exec jekyll serve --host 0.0.0.0

如果您更改了布局或网站结构，您可能需要执行以下命令：

    rm -rf _site .jekyll-metadata && bundle exec jekyll serve --host 0.0.0.0

或从项目根目录执行以下脚本：

    ./restart.sh

您的网站副本随后将在以下位置可见：**http://localhost:4000**
（或 Jekyll 告诉您的任何位置）。

## 集成指南模式

使用此 [示例](/docs/samples/sample/sample) 作为指南的基础。此页面位于路径 "/docs/samples/sample/sample.md" 中

打开 .md 文件后，执行以下必要步骤

* [步骤 1] 将新目录添加到网站结构 "/docs/samples/YOUR_INTEGRATION_NAME/"。
* [步骤 2] 将新目录添加到网站结构 "/images/samples/YOUR_INTEGRATION_NAME/"。
* [步骤 3] 使用 [示例](/docs/samples/sample/sample) 作为基础，在您从 [步骤 1] 创建的新目录中创建一个 "YOUR_INTEGRATION_NAME.md" 文件。
* [步骤 4] 将您指南的所有图像存储在路径 "/images/samples/YOUR_INTEGRATION_NAME/" 中。
* [步骤 5] 将您的公司徽标添加到路径 "/images/partners/"。
* [步骤 6] 将您的名片添加到位于路径 "/_includes/" 的 "partners.json" 中，并将您的公司徽标文件 ([步骤 5]) 的名称插入到下面的代码中的 "logo" 中。

        {
          "type": "hardware",
          "program": "",
          "name": "YOUR_INTEGRATION_NAME",
          "logo": "YOUR_LOGO.png",
          "links": {
            "Site": {
              "href": "https://www.YOUR_SITE.com/",
              "target": "_blank"
            },
            "Integration guide": {
              "href": "/docs/samples/PATH_TO_YOUR_GUIDE-FILE_FROM_STEP_3/GUIDE-FILE/"
            }
          },
          "blurb": "YOUR_INTEGRATION_DESCRIPTION."
        }

其中：

    "YOUR_INTEGRATION_NAME" - 您的集成指南的名称
    "YOUR_LOGO.png" - 您从 [步骤 5] 中的公司/集成徽标文件
    "https://www.YOUR_SITE.com/" - 您公司/集成的网站。
    "/docs/samples/PATH_TO_YOUR_GUIDE-FILE_FROM_STEP_3/GUIDE-FILE/" - 存储库根目录的完整路径和文件名。

## 推送更改并创建 Pull Request

* [步骤 1] [将更改推送到您的 fork](/docs/user-guide/contribution/how-to-contribute/#push-changes-to-your-fork)。
* [步骤 2] [创建 Pull Request](/docs/user-guide/contribution/how-to-contribute/#create-pull-request)。

## 可选步骤

您可以通过 [联系我们](/docs/contact-us/) 表单或任何其他方式通知我们您的 Pull Request（带有 Pull Request #）。