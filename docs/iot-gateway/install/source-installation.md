---
layout: docwithnav-gw
title: 从源代码安装物联网网关。

---

### 从源代码安装

要从源代码安装 GridLinks 网关，您应按照以下步骤操作：    

**1. 使用 apt 在系统中安装所需的库：**  
```bash
sudo apt install python3-dev python3-pip libglib2.0-dev git 
```
{: .copy-code}

**2. 从 GitHub 下载存储库：**
```bash
git clone --recurse-submodules https://github.com/thingsboard/thingsboard-gateway.git --depth 1
```
{: .copy-code}

**3. 移至下载的目录：**
```bash
cd thingsboard-gateway
```
{: .copy-code}

**4. 安装 python 要求：**  
```bash
pip3 install -r requirements.txt
```
{: .copy-code}

**5. 创建“logs”文件夹：**  
```bash
mkdir logs
```
{: .copy-code}

**6. 使用 [本指南](/docs/iot-gateway/configuration/) 配置网关以使其与您的 GridLinks 平台实例配合使用** *或仅运行以测试安装结果，如下一步所示。*
   
**7. 运行网关，以检查安装结果：**
```bash
python3 ./thingsboard_gateway/tb_gateway.py
```
{: .copy-code}

### 热重载器

如果您将网关用于开发，则可以启用热重载器，以便在您编辑任何项目文件时重新启动网关。

要使用热重载器运行网关，请使用以下命令：
```bash
python3 ./thingsboard_gateway/tb_gateway.py true
```
{: .copy-code}