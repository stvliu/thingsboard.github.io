---
layout: docwithnav
assignees:
- ashvayka
title: GridLinks 安装选项
description: GridLinks 安装说明，适用于各种操作系统和云平台
notitle: "true"
---

<div class="installation-options">
    <div class="install-options-header">
       <div class="install-options-hero">
          <div class="container">
            <div class="install-options-hero-content">
                <h1>GridLinks 安装选项</h1>
                <div class="install-options-description">
                    <p>
                        GridLinks 旨在运行并利用大多数硬件，从本地 Raspberry PI 到云中的强大服务器
                    </p>
                </div>
            </div>
            <div class="deployment-container">
               <nav id="install-navigation" class="install-navigation">
                 <ul id="menu-install-navigation-1" class="menu">
                    <li id="menu-item-liveDemo" class="menu-item tb-live-demo">
                        <a href="javascript:void(0);" onClick="activateInstallSection('liveDemo')">实时演示</a>
                    </li>
                    <li id="menu-item-onPremise" class="menu-item tb-on-premise active">
                        <a href="javascript:void(0);" onClick="activateInstallSection('onPremise')">本地</a>
                    </li>
                    <li id="menu-item-cloud" class="menu-item tb-cloud">
                        <a href="javascript:void(0);" onClick="activateInstallSection('cloud')">云</a>
                    </li>
                 </ul>
               </nav>
                <div class="deployment-div">
                    <div class="container">
                        <div class="deployment-section deployment-live-demo" id="liveDemo">
                            <div class="deployment-cards">
                                <div class="deployment-cards-container">
                                    <div class="deployment-card-block">
                                        <a href="https://demo.thingsboard.io/signup">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/sign-ce-img.svg" title="实时演示" alt="实时演示">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="deployment-section deployment-on-premise active" id="onPremise">
                           <div class="deployment-cards">
                                <div class="deployment-cards-container">
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/ubuntu/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/ubuntu.svg" title="Ubuntu" alt="Ubuntu">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/rhel/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/centos-redhat.svg" title="CentOS/RHEL" alt="CentOS/RHEL">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/windows/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/windows.svg" title="Windows" alt="Windows">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/rpi/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/rpi3.svg" title="Raspberry Pi 3" alt="Raspberry Pi 3">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/docker-windows/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/docker-windows.svg" title="Docker (Windows)" alt="Docker (Windows)">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/docker/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/docker-linux-macos.svg" title="Docker (Linux 或 Mac OS)" alt="Docker (Linux 或 Mac OS)">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/building-from-source/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/sources.svg" title="从源代码构建" alt="从源代码构建">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/cluster-setup/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/platform/cluster-ce.svg" title="使用 Kubernetes 进行集群设置" alt="使用 Kubernetes 进行集群设置">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                               </div>
                            </div>
                        </div>
                        <div class="deployment-section deployment-cloud" id="cloud">
                            <div class="deployment-cards">
                                <div class="deployment-cards-container">
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/aws/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cloud/aws.svg" title="AWS" alt="AWS">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/azure/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cloud/azure.svg" title="Microsoft Azure" alt="Microsoft Azure">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/digital-ocean/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cloud/digitalocean.svg" title="Digital Ocean" alt="Digital Ocean">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/gcp/">
                                            <span>
                                                <div class="deployment-logo">
                                                    <img width="" src="/images/install/cloud/gcp.svg" title="Google Cloud Platform" alt="Google Cloud Platform">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/ibm-cloud/">
                                            <span>
                                                <div class="deployment-logo coming-soon">
                                                    <img width="" src="/images/install/cloud/ibm-cloud.png" title="IBM Cloud" alt="IBM Cloud">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="deployment-card-block">
                                        <a href="/docs/user-guide/install/alibaba-cloud/">
                                            <span>
                                                <div class="deployment-logo coming-soon">
                                                    <img width="" src="/images/install/cloud/alibaba-cloud.jpg" title="Alibaba Cloud" alt="Alibaba Cloud">
                                                 </div>
                                            </span>
                                        </a>
                                    </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
       </div>
    </div>
</div>


<script type="text/javascript">

    jqueryDefer(function () {
        window.addEventListener('popstate', onPopStateCeInstallOptions);
        onPopStateCeInstallOptions();
    });

    function activateInstallSection(id) {
        var param = 'ceInstallType';
        var params = Qs.parse(window.location.search, { ignoreQueryPrefix: true });
        params[param] = id;
        var newurl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + Qs.stringify(params);
        if (window.location.hash) {
            newurl += window.location.hash;
        }
        window.history.pushState({ path: newurl }, '', newurl);
        selectTargetCeInstallOption(id);
    }
    
    function onPopStateCeInstallOptions() {
            var params = Qs.parse(window.location.search, { ignoreQueryPrefix: true });
            var targetId = params['ceInstallType'];
            if (!targetId) {
                targetId = 'onPremise';
            }
            selectTargetCeInstallOption(targetId);
    }
        
    function selectTargetCeInstallOption(targetId) {
         $("li.menu-item").removeClass("active");
         $("li.menu-item#menu-item-"+targetId).addClass("active");
         $('.deployment-div .deployment-section').removeClass("active");
         $('.deployment-div .deployment-section#'+targetId).addClass("active");
    }

</script>