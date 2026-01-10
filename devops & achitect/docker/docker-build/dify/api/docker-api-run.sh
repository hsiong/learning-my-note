#!/bin/bash
set -e

############################################
# 基本配置
############################################
IMAGE_NAME="dify-api"          # 镜像名
API_CONTAINER="dify-api"       # API 容器名
WORKER_CONTAINER="dify-worker" # Worker 容器名
DOCKERFILE_DIR="./"         # Dockerfile 所在目录
API_PORT=5001                  # 对外暴露 API 端口

cp .env .env.prod
sed -i "s/\${REDIS_PORT}/${REDIS_PORT}/g" .env.prod


# 取当前 git 提交，找不到就用 "local"
############################################
# 代理 & 国内源配置
############################################

# 是否启用代理（true/false）
ENABLE_PROXY=true

# ===== 代理地址，根据你的系统修改 =====
# Linux 通常用 Docker 网关 172.17.0.1 或宿主机局域网 IP
PROXY_HOST="127.0.0.1"
PROXY_PORT="7897"
PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"

# ===== 国内 PyPI 镜像（uv / pip 使用）=====
# 任选其一：
#PYPI_MIRROR="https://mirrors.aliyun.com/pypi/simple"
PYPI_MIRROR="https://pypi.tuna.tsinghua.edu.cn/simple"

############################################
# 打印配置
############################################
echo ">>> IMAGE_NAME      = ${IMAGE_NAME}"
echo ">>> API_CONTAINER   = ${API_CONTAINER}"
echo ">>> WORKER_CONTAINER= ${WORKER_CONTAINER}"
echo ">>> DOCKERFILE_DIR  = ${DOCKERFILE_DIR}"
echo ">>> API_PORT        = ${API_PORT}"
echo ">>> ENABLE_PROXY    = ${ENABLE_PROXY}"
if [ "${ENABLE_PROXY}" = "true" ]; then
  echo ">>> PROXY_URL       = ${PROXY_URL}"
  echo ">>> PYPI_MIRROR     = ${PYPI_MIRROR}"
fi
echo

############################################
# 删除旧容器
############################################
remove_container() {
  local NAME="$1"
  echo ">>> 检查旧容器: ${NAME}"
  if docker ps -a --format '{{.Names}}' | grep -w "$NAME" >/dev/null 2>&1; then
    echo "    停止 ${NAME} ..."
    docker stop "$NAME" >/dev/null 2>&1 || true
    echo "    删除 ${NAME} ..."
    docker rm "$NAME" >/dev/null 2>&1 || true
  else
    echo "    未找到旧容器。"
  fi
}

remove_container "${API_CONTAINER}"
remove_container "${WORKER_CONTAINER}"
echo

############################################
# 删除旧镜像
############################################
echo ">>> 检查旧镜像: ${IMAGE_NAME}"
if docker images --format '{{.Repository}}' | grep -w "${IMAGE_NAME}" >/dev/null 2>&1; then
  echo "    删除旧镜像 ..."
  docker rmi -f "${IMAGE_NAME}" >/dev/null 2>&1 || true
else
  echo "    未找到旧镜像。"
fi
echo

############################################
# 构造 build 参数（包含代理 & 国内源）
############################################
BUILD_ARGS="-t ${IMAGE_NAME}"

if [ "${ENABLE_PROXY}" = "true" ]; then
    BUILD_ARGS="$BUILD_ARGS \
      --build-arg HTTP_PROXY=${PROXY_URL} \
      --build-arg HTTPS_PROXY=${PROXY_URL} \
      --build-arg http_proxy=${PROXY_URL} \
      --build-arg https_proxy=${PROXY_URL} \
      --build-arg UV_INDEX_URL=${PYPI_MIRROR} \
      --build-arg PIP_INDEX_URL=${PYPI_MIRROR}"
fi

############################################
# 构造 run 时的代理环境变量
############################################
RUN_PROXY_ENV=""

if [ "${ENABLE_PROXY}" = "true" ]; then
    RUN_PROXY_ENV="$RUN_PROXY_ENV -e HTTP_PROXY=${PROXY_URL}"
    RUN_PROXY_ENV="$RUN_PROXY_ENV -e HTTPS_PROXY=${PROXY_URL}"
    RUN_PROXY_ENV="$RUN_PROXY_ENV -e http_proxy=${PROXY_URL}"
    RUN_PROXY_ENV="$RUN_PROXY_ENV -e https_proxy=${PROXY_URL}"
fi


############################################
# 构建镜像
############################################
echo ">>> 开始构建镜像（带代理 & 国内源）..."
eval docker build --network=host  $BUILD_ARGS "$DOCKERFILE_DIR"

echo ">>> 镜像构建完成: ${IMAGE_NAME}_"

############################################
# 启动 API 容器 (MODE=api)
############################################
echo ">>> 启动 API 容器: ${API_CONTAINER}"

API_RUN_CMD="docker run -d \
  --name ${API_CONTAINER} \
  --restart=always \
  --network=host \
  -e MODE=api \
  -e EDITION=SELF_HOSTED \
  -e DEPLOY_ENV=PRODUCTION \
  --env-file .env.prod \
  -v "$(pwd)/storage_prod:/app/api/storage" \
  ${RUN_PROXY_ENV} \
  ${IMAGE_NAME}"
eval ${API_RUN_CMD}

echo ">>> API 已启动: http://127.0.0.1:${API_PORT}"
echo

echo ">>> 启动 Worker 容器: ${WORKER_CONTAINER}"

WORKER_RUN_CMD="docker run -d \
  --name ${WORKER_CONTAINER} \
  --restart=always \
  --network=host \
  -e MODE=worker \
  -e EDITION=SELF_HOSTED \
  -e DEPLOY_ENV=PRODUCTION \
  --env-file .env.prod \
  -v "$(pwd)/storage_prod:/app/api/storage" \
  ${RUN_PROXY_ENV} \
  ${IMAGE_NAME}"
eval ${WORKER_RUN_CMD}
echo ">>> Worker 已启动。"

# 可改为定时任务
API_CLEAN_API="docker exec ${API_CONTAINER} flask clear-orphaned-file-records -f && docker exec ${API_CONTAINER} flask remove-orphaned-files-on-storage -f"
eval ${API_CLEAN_API} 
echo ">>> 清理垃圾文件"

