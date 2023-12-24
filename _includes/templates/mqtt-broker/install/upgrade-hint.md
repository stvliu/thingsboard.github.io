如果您在合并过程中遇到与您的更改无关的冲突，我们建议您接受远程分支的所有新更改。

您可以通过执行以下操作来还原合并过程：
```bash
git merge --abort
```
{: .copy-code}

并通过接受**theirs**更改来重复合并。

```bash
git pull origin {{ site.release.broker_branch }} -X theirs
```
{: .copy-code}

默认合并策略有几个有用的选项：
* **-X ours** - 此选项强制将冲突的块干净地自动解决，方法是支持我们的版本。
* **-X theirs** - 这是**ours**的反义词。有关更多详细信息，请参阅[此处](https://git-scm.com/docs/merge-strategies#_merge_strategies)。