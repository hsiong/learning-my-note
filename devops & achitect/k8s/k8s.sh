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

## k8s  imagePullPolicy 有哪些
Kubernetes (k8s) 中的 imagePullPolicy 用于指定容器镜像的拉取策略。这是一个重要的设置，因为它决定了 Kubernetes 如何从镜像仓库获取镜像。以下是可用的 imagePullPolicy 选项：
> Always: 总是尝试从远程仓库拉取镜像，不论本地是否已有镜像缓存。这确保了每次都使用最新的镜像，但可能会增加拉取时间和网络流量。
> Never: 总是使用本地镜像，从不从远程仓库拉取。如果本地没有相应的镜像，容器启动会失败。这种策略适用于已经确信本地镜像存在且不需要更新的情况。
> IfNotPresent: 如果本地不存在镜像，则从远程仓库拉取。如果本地已有镜像缓存，则使用本地镜像。这是默认的拉取策略，平衡了性能和保证镜像最新的需求。
选择哪种 imagePullPolicy 取决于你的特定需求。例如，对于生产环境，可能更倾向于使用 Always 策略以确保总是运行最新版本的镜像。而在开发或测试环境中，可能会选择 IfNotPresent 或 Never 以减少拉取镜像的时间和网络带宽消耗。

## k8s readinessProbe
在 Kubernetes (k8s) 中，readinessProbe 是一种检查机制，用于确定 Pod 中的容器是否已准备好开始接收流量。当容器启动后，它可能需要一段时间来加载应用程序和数据。readinessProbe 确保流量只有在容器准备好后才会被路由到该容器。如果 readinessProbe 失败，Kubernetes 不会向该 Pod 发送请求。

## ServiceMonitor
ServiceMonitor 是 Kubernetes 环境中与 Prometheus 监控系统相关的概念，主要用于在 Prometheus Operator 框架下自动发现和配置目标服务的监控。Prometheus Operator 是一个 Kubernetes Operator，用于在 Kubernetes 上更容易地部署和管理 Prometheus 监控实例。

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

# Security

## Content Security Policy
> 如果遇到报错: because it violates the following Content Security Policy directive:
> 考虑 ingress 中 add_ header Content-Security-Policy "default-src 'self' *.domain.com"

## 生成只能访问对应namespace 的kubeconfig
> chatgpt

## k8s 添加 ssl 证书 secret
+ 创建 Kubernetes Secret
kubectl create secret tls your-ssl-secret --cert=path/to/yourdomain.crt --key=path/to/yourdomain.key -n your-namespace

+ 使用 Secret
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: your-ingress
  namespace: your-namespace
spec:
  tls:
  - hosts:
    - yourdomain.com
    secretName: your-ssl-secret
  rules:
  - host: yourdomain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: your-service-name
            port:
              number: 80

+ 检查 Secret
kubectl get secret your-ssl-secret -n your-namespace -o yaml

