**注意：**确保允许在您的系统上运行下载的 PowerShell 脚本。

* **打开 PowerShell**（以管理员身份运行）。
* **（可选）获取当前执行策略**。它确定在系统上运行脚本的安全级别。例如，如果返回“受限”，则表示 PowerShell 不执行任何脚本。

```bash
Get-ExecutionPolicy
```
{: .copy-code}

* **（可选）根据需要更改当前执行策略**。将其设置为允许您运行 PowerShell 脚本且符合您的安全要求的策略。例如，“不受限”是最不严格的设置，允许执行所有脚本。

```bash
Set-ExecutionPolicy Unrestricted
```
{: .copy-code}

* **安装 TBMQ**

```bash
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/thingsboard/tbmq/{{ site.release.broker_branch }}/msa/tbmq/configs/windows/tbmq-install-and-run.ps1" `
-OutFile ".\tbmq-install-and-run.ps1"; .\tbmq-install-and-run.ps1
```
{: .copy-code}