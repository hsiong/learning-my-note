#!/usr/bin/env bash
set -eu
# 只要有命令失败，立刻退出脚本
# 使用未定义变量直接报错

# ====== 可按需修改 ======
IMAGE_NAME="custom-pipeline"          # 镜像名
CONTAINER_NAME="custom-pipeline"      # 容器名
CONFIG_FILE_PATH=".env.prod"
HOST_PORT="8001"            # 宿主机端口
CONTAINER_PORT="8001"       # 容器端口（Dockerfile EXPOSE 的）
PROXY_URL="http://172.16.69.222:7897"
CONTAINER_LOG_PATH="/media/hsiong/JF-Disk/code/config/log/${CONTAINER_NAME}/prod"

# ======================== proxy
echo "==> [0/5] 设置代理 ${PROXY_URL}"
PYPI_MIRROR="https://pypi.tuna.tsinghua.edu.cn/simple"
BUILD_ARGS="-t ${IMAGE_NAME} \
  --build-arg HTTP_PROXY=${PROXY_URL} \
  --build-arg HTTPS_PROXY=${PROXY_URL} \
  --build-arg http_proxy=${PROXY_URL} \
  --build-arg https_proxy=${PROXY_URL} \
  --build-arg UV_INDEX_URL=${PYPI_MIRROR} \
  --build-arg PIP_INDEX_URL=${PYPI_MIRROR}"
RUN_PROXY_ENV=" -e HTTP_PROXY=${PROXY_URL}"
RUN_PROXY_ENV="$RUN_PROXY_ENV -e HTTPS_PROXY=${PROXY_URL}"
RUN_PROXY_ENV="$RUN_PROXY_ENV -e http_proxy=${PROXY_URL}"
RUN_PROXY_ENV="$RUN_PROXY_ENV -e https_proxy=${PROXY_URL}"

echo "==> [1/5] 停止并删除旧容器（如果存在）: ${CONTAINER_NAME}"
if docker ps -a --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
  docker rm -f "${CONTAINER_NAME}" >/dev/null
  echo "    已删除旧容器: ${CONTAINER_NAME}"
else
  echo "    未发现旧容器: ${CONTAINER_NAME}（跳过）"
fi

echo "==> [2/5] 删除旧镜像（如果存在）: ${IMAGE_NAME}"
if docker images --format '{{.Repository}}:{{.Tag}}' | grep -qx "${IMAGE_NAME}"; then
  # 若镜像被其他容器占用，会删不掉；上一步已 rm 容器，一般没问题
  docker rmi -f "${IMAGE_NAME}" >/dev/null || true
  echo "    已删除旧镜像: ${IMAGE_NAME}"
else
  echo "    未发现旧镜像: ${IMAGE_NAME}（跳过）"
fi

echo "==> [3/5] 重新构建镜像: ${IMAGE_NAME}"
eval docker build --network=host  $BUILD_ARGS .

echo "==> [4/5] 运行新容器: ${CONTAINER_NAME}"
# ls -a 看是否挂载
WORKER_RUN_CMD="docker run -d \
  --name ${CONTAINER_NAME} \
  --restart=always \
  -p ${HOST_PORT}:${CONTAINER_PORT} \
  -e CONFIG_FILE_PATH=${CONFIG_FILE_PATH} \
  -v "$(pwd)/config/${CONFIG_FILE_PATH}:/app/config/${CONFIG_FILE_PATH}" \
  -v "${CONTAINER_LOG_PATH}:/app/logs" \
  ${RUN_PROXY_ENV} \
  ${IMAGE_NAME}"
eval ${WORKER_RUN_CMD}
echo ">>> ${CONTAINER_NAME} 已启动。"
