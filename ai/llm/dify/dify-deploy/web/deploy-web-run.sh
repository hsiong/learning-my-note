#!/bin/sh
set -e

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "${SCRIPT_DIR}/.." && pwd)
WEB_DIR="web"

############################################
# 基本配置
############################################
IMAGE_NAME="dify-web"
CONTAINER_NAME="dify-web"
DOCKERFILE_PATH="${WEB_DIR}/Dockerfile"
BUILD_CONTEXT="."
PORT="3000"
COMMIT_SHA=$(git -C "${REPO_ROOT}" rev-parse HEAD 2>/dev/null || echo "local")

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

#rm -rf node_modules pnpm-lock.yaml package-lock.json
#pnpm install
#pnpm run build
#pnpm start

echo ">>> IMAGE_NAME     = ${IMAGE_NAME}"
echo ">>> CONTAINER_NAME = ${CONTAINER_NAME}"
echo ">>> DOCKERFILE_PATH= ${DOCKERFILE_PATH}"
echo ">>> BUILD_CONTEXT  = ${BUILD_CONTEXT}"
echo ">>> PORT           = ${PORT}"
echo ">>> COMMIT_SHA     = ${COMMIT_SHA}"
echo ">>> ENABLE_PROXY   = ${ENABLE_PROXY}"
echo ">>> REPO_ROOT      = ${REPO_ROOT}"
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
# 构建镜像
############################################
echo ">>> Building new image..."
cd "${REPO_ROOT}"
if [ "${ENABLE_PROXY}" = "true" ]; then
  docker build \
    --network=host \
    -f "${DOCKERFILE_PATH}" \
    -t "${IMAGE_NAME}" \
    --build-arg "COMMIT_SHA=${COMMIT_SHA}" \
    --build-arg "HTTP_PROXY=${PROXY_URL}" \
    --build-arg "HTTPS_PROXY=${PROXY_URL}" \
    --build-arg "http_proxy=${PROXY_URL}" \
    --build-arg "https_proxy=${PROXY_URL}" \
    --build-arg "NPM_REGISTRY=${NPM_REGISTRY}" \
    "${BUILD_CONTEXT}"
else
  docker build \
    --network=host \
    -f "${DOCKERFILE_PATH}" \
    -t "${IMAGE_NAME}" \
    --build-arg "COMMIT_SHA=${COMMIT_SHA}" \
    "${BUILD_CONTEXT}"
fi
echo "--- Build completed."
echo

############################################
# 启动容器
############################################
echo ">>> Running container (detach + restart always)..."

# 加载本地环境变量 .env.local
if [ "${ENABLE_PROXY}" = "true" ]; then
  docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart=always \
    -p "${PORT}:3000" \
    --network=host \
    -e CONSOLE_API_URL="http://172.16.69.222:5001" \
    -e APP_API_URL="http://172.16.69.222:5001" \
    -e "HTTP_PROXY=${PROXY_URL}" \
    -e "HTTPS_PROXY=${PROXY_URL}" \
    -e "http_proxy=${PROXY_URL}" \
    -e "https_proxy=${PROXY_URL}" \
    --env-file "${SCRIPT_DIR}/.env.local" \
    "${IMAGE_NAME}"
else
  docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart=always \
    -p "${PORT}:3000" \
    --network=host \
    -e CONSOLE_API_URL="http://172.16.69.222:5001" \
    -e APP_API_URL="http://172.16.69.222:5001" \
    --env-file "${SCRIPT_DIR}/.env.local" \
    "${IMAGE_NAME}"
fi

echo ">>> Container started."
echo "🌍 Visit: http://172.16.69.222:${PORT}"

docker logs -f "${CONTAINER_NAME}"
