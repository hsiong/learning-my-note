

docker login ccr.ccs.tencentyun.com --username="${USERNAME}"

echo "==> 停止并删除旧容器（如果存在）"
docker rm -f "${APP_NAME}" 2>/dev/null || true

echo "==> 拉取当前版本镜像"
docker pull "${OPENCLAW_IMAGE}"

echo "==> 启动容器"
docker run -d \
  --name "${APP_NAME}" \
  --restart unless-stopped \
  --network host \
  --user root \
  -v "${CONFIG_DIR}:/root/.openclaw" \
  -v "${LOG_DIR}:/var/log/openclaw" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e DOCKER_HOST=unix:///var/run/docker.sock \
  "${OPENCLAW_IMAGE}"

echo "==> 当前运行中的容器"
docker ps --filter "name=${APP_NAME}"