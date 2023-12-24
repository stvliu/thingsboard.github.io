执行以下命令以部署资源：

```
./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，您可以调用 `kubectl get pods`。如果一切顺利，您应该能够在 `READY` 状态下看到 `tb-node-0` pod。