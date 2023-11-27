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

