
docker login ccr.ccs.tencentyun.com --username="${USERNAME}"

REGISTRY="ccr.ccs.tencentyun.com/openclaw-jf"
DST_IMAGE_DOCKERCLI="${REGISTRY}/${imagename}:${VERSION}"

echo "==> 删除本地旧的 ghcr.io/openclaw/openclaw:* tag（排除当前版本 ${VERSION}）"
docker images "ghcr.io/openclaw/openclaw" --format "{{.Repository}}:{{.Tag}}" \
| grep -v ":${VERSION}$" \
| xargs -r docker rmi || true


docker images "ccr.ccs.tencentyun.com/openclaw-jf/openclaw" --format "{{.Repository}}:{{.Tag}}" \
| grep -v ":${VERSION}$" \
| xargs -r docker rmi || true

docker build -t "${DST_IMAGE_DOCKERCLI}" -f Dockerfile.gateway-dockercli .

docker push "${DST_IMAGE_DOCKERCLI}"