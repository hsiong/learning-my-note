#!/bin/sh
set -e

############################################
# 基本配置
############################################
IMAGE_NAME="dify-web"
CONTAINER_NAME="dify-web"
DOCKERFILE_DIR="."           # Dockerfile 所在目录
PORT="3000"
COMMIT_SHA=$(git rev-parse HEAD 2>/dev/null || echo "local")

############################################
# 代理 & 国内源配置
############################################
ENABLE_PROXY=true

# !!! 注意：容器内的 127.0.0.1 是“容器自己”
# 如果你的代理跑在宿主机上，Linux 下常用 172.17.0.1 或 host.docker.internal
# 你现在指定 127.0.0.1:7897，我按你要求先写死，你需要的话可以自己改 PROXY_HOST
PROXY_HOST="127.0.0.1"
PROXY_PORT="7897"
PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"

# npm / pnpm 国内源
NPM_REGISTRY="https://registry.npmmirror.com"

echo ">>> IMAGE_NAME     = ${IMAGE_NAME}"
echo ">>> CONTAINER_NAME = ${CONTAINER_NAME}"
echo ">>> DOCKERFILE_DIR = ${DOCKERFILE_DIR}"
echo ">>> PORT           = ${PORT}"
echo ">>> COMMIT_SHA     = ${COMMIT_SHA}"
echo ">>> ENABLE_PROXY   = ${ENABLE_PROXY}"
if [ "${ENABLE_PROXY}" = "true" ]; then
  echo ">>> PROXY_URL      = ${PROXY_URL}"
  echo ">>> NPM_REGISTRY   = ${NPM_REGISTRY}"
fi
echo

############################################
# 删除旧容器
############################################
echo ">>> Removing old container if exists..."
if docker ps -a --format '{{.Names}}' | grep -w "${CONTAINER_NAME}" >/dev/null 2>&1; then
  docker stop "${CONTAINER_NAME}" >/dev/null 2>&1 || true
  docker rm   "${CONTAINER_NAME}" >/dev/null 2>&1 || true
  echo "--- Old container removed."
else
  echo "--- No container to remove."
fi
echo

############################################
# 删除旧镜像
############################################
echo ">>> Removing old image if exists..."
if docker images --format '{{.Repository}}' | grep -w "${IMAGE_NAME}" >/dev/null 2>&1; then
  docker rmi -f "${IMAGE_NAME}" >/dev/null 2>&1 || true
  echo "--- Old image removed."
else
  echo "--- No image to remove."
fi
echo

############################################
# 构造 build 参数（带代理 & 国内源）
############################################
BUILD_ARGS="-t ${IMAGE_NAME} --build-arg COMMIT_SHA=${COMMIT_SHA}"

if [ "${ENABLE_PROXY}" = "true" ]; then
  BUILD_ARGS="${BUILD_ARGS} \
    --build-arg HTTP_PROXY=${PROXY_URL} \
    --build-arg HTTPS_PROXY=${PROXY_URL} \
    --build-arg http_proxy=${PROXY_URL} \
    --build-arg https_proxy=${PROXY_URL} \
    --build-arg NPM_REGISTRY=${NPM_REGISTRY}"
fi

echo ">>> docker build 参数:"
echo "${BUILD_ARGS}"
echo

############################################
# 构建镜像
############################################
echo ">>> Building new image..."
eval docker build --network=host   ${BUILD_ARGS} "${DOCKERFILE_DIR}"
echo "--- Build completed."
echo

############################################
# 运行时代理环境变量
############################################
RUN_PROXY_ENV=""
if [ "${ENABLE_PROXY}" = "true" ]; then
  RUN_PROXY_ENV="${RUN_PROXY_ENV} -e HTTP_PROXY=${PROXY_URL}"
  RUN_PROXY_ENV="${RUN_PROXY_ENV} -e HTTPS_PROXY=${PROXY_URL}"
  RUN_PROXY_ENV="${RUN_PROXY_ENV} -e http_proxy=${PROXY_URL}"
  RUN_PROXY_ENV="${RUN_PROXY_ENV} -e https_proxy=${PROXY_URL}"
fi

############################################
# 启动容器
############################################
echo ">>> Running container (detach + restart always)..."

# 用 eval 展开 RUN_PROXY_ENV 里的多个 -e
# 加载本地环境变量 .env.local
eval docker run -d \
  --name "${CONTAINER_NAME}" \
  --restart=always \
  -p "${PORT}:3000" \
  --network=host  \
  -e CONSOLE_API_URL="http://172.16.69.222:5001" \
  -e APP_API_URL="http://172.16.69.222:5001" \
  --env-file .env.local \
  ${RUN_PROXY_ENV} \
  "${IMAGE_NAME}"

echo ">>> Container started."
echo "🌍 Visit: http://172.16.69.222:${PORT}"
