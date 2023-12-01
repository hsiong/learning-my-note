https://github.com/hsiong/learning-kubernetes

# mac 安装 kubectl  并导入 config
+ 安装
brew install kubectl
+ 验证
kubectl version --client
+ 创建 config 文件
mkdir -p ~/.kube
touch ~/.kube/config
+ 导入 config 文件
vim ~/.kube/config
chmod 600 ~/.kube/config

# 检查所有命名空间
kubectl get pods --all-namespaces

# 检查特定命名空间：
kubectl get pods -n <namespace>

# 检查特定 pod
kubectl describe pod <pod-name> -n <namespace>

# 检查Kubernetes Pod的Spec
kubectl get pod <pod-name> -o yaml



# 一些问题
> kubectl get pod, No resources found in default namespace.
如果您在使用 kubectl get pod 命令时收到了 “No resources found in default namespace.” 的消息，这意味着在默认命名空间中没有正在运行的Pod。

+ 确保Kubernetes集群状态良好
kubectl cluster-info

+ 检查特定命名空间：
kubectl get pods -n <namespace>

> k8s 容器运行额外命令
```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: your-image
    command: ["/bin/sh"]
    args: ["-c", "echo Hello, Kubernetes! && exec your-original-command"]
```

> k8s 如何查看原有的入口点(ENTRYPOINT)
docker inspect xxx 






