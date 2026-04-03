# initial

+ 项目不能放在移动盘 懂了吗

  典型的 Postgres 在容器里尝试 chmod 700 失败：你的 /var/lib/postgresql/data/pgdata 映射到了宿主机的 NTFS/exFAT 之类不支持 Unix 权限的文件系统，或者绑定的是个不允许 chmod 的路径，所以报

+ 使用项目专属 venv

  uv 的设计理念是：每个项目独立、可复现、不污染系统环境。所以：它会为每个项目创建一个 .venv/（或者你配置的虚拟环境目录）。依赖全部安装到这个虚拟环境的 lib/pythonX.Y/site-packages 下。激活该虚拟环境后，Python / pip / uv 都只看到项目自己的依赖。这样：不会和系统 Python 冲突；不同项目可以用不同版本的 Flask、Django、Numpy 等；项目可复现（别人 uv sync 一下就能复现环境）。

+ dify source编译应有两个项目, dify-dev 仅拉取; dify-prod 用于提交, 每次提交前 rollback

## middleware

+ init

  ```
  cp .env.example .env
  cp middleware.env.example middleware.env
  cp docker-compose.middleware.yaml docker-compose.middleware.copy.yaml
  ```

+ modify config `.env & middleware.env`

  ```
  PIP_MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple
  ```

+ shell

  ```
  
  cd docker
  
  # sandbox: https://github.com/langgenius/dify/issues/23365
  docker compose -f docker-compose.middleware.copy.yaml  down
  sudo find ./volumes -mindepth 1 ! -path "*/sandbox*" -exec rm -rf {} + && \
  sudo find ../api/storage -mindepth 1 ! -path "*/sandbox*" -exec rm -rf {} +
  
  ps aux | grep celery | grep -v grep | awk '{print $2}' | xargs kill -9
  docker compose -f docker-compose.middleware.copy.yaml  up -d
  ```

  

### sandbox error: open conf/config.yaml: no such file or directory panic:   

```
docker logs  docker-sandbox-1
2025/11/07 13:02:19 server.go:18: [PANIC]failed to init config: open conf/config.yaml: no such file or directory panic:   
```

https://github.com/langgenius/dify/issues/23365

## web

+ ```
  cd web
  cp .env.example .env.local
  ```

+ Modify the values of these environment variables according to your requirements

  ```
  NEXT_PUBLIC_CSP_WHITELIST=https://marketplace.dify.ai localhost
  ```

+ shell

  ```shell
  cd ../web
  brew install node@22
  brew unlink node@16
  brew link --overwrite node@22
  echo 'export PATH="/opt/homebrew/opt/node@22/bin:$PATH"' >> ~/.zshrc
  source ~/.zshrc
  sudo fuser -k 3000/tcp #kill port
  # apt install nodejs
  
  rm -rf node_modules pnpm-lock.yaml package-lock.json
  pnpm install
  pnpm run build
  pnpm start
  
  
  # don't use proxy
  # install plugin from local & wait to install
  ```

## api-repo

+ api 单独作为项目打开

+ init

  ```
  cd api
  cp .env.example .env
  awk -v key="$(openssl rand -base64 42)" '/^SECRET_KEY=/ {sub(/=.*/, "=" key)} 1' .env > temp_env && mv temp_env .env
  ```

+ modify config

  ```sh
  sublime .env
  ENABLE_REQUEST_LOGGING=True
  SQLALCHEMY_ECHO=true # sql log
  ```

+ repo

  ```
  pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && pip config set global.proxy http://127.0.0.1:7897
  pip install uv
  
  uv sync --group storage --group tools --group vdb --group dev \
    --index-url https://pypi.tuna.tsinghua.edu.cn/simple
  #pip install poetry
  #poetry install
  
  flask db upgrade
  celery -A app.celery worker -P gevent -c 1 --loglevel INFO -Q dataset,generation,mail,ops_trace
  flask run --host 0.0.0.0 --port=5001 --debug
  ```

## Pycharm 运行

### Pycharm web

package.json -> show npm scripts -> start -> run  

### PyCharm 运行 Celery worker

1. api 作为单独项目打开

2. **点开右上角的小三角旁边的下拉 → Edit Configurations…**

3. 点左上角的“+”新建一个**Python**类型的配置。

4. 配置如下内容：

   - **Python interpreter**：

     - 选择你的虚拟环境 Python

   - **Name**：随便，比如 `Celery worker`

   - **Script path**：填入 celery 可执行文件路径（通常是你的 venv 里的 celery 脚本，推荐用绝对路径，如果用 pyenv/poetry/uv 也要选 venv 下的 celery）

     - 你可以 `which celery` 找到路径，比如 `/Users/vjf/Projects/python/dify-prod/api/.venv/bin/celery`

   - **Parameters**：

     ```sh
     -A app.celery worker -P gevent -c 1 --loglevel INFO -Q dataset,generation,mail,ops_trace
     ```

   - **Working directory**：

     - 你的项目根目录，比如 `/Users/vjf/Projects/python/dify-prod/api`

#### 用 “Python” 配置跑 `python -m flask …`（不需要 run.py）

1. 打开：**Run → Edit Configurations…**
2. 左上角 **➕** → 选 **Python**
3. 在右侧按下面填：

- **Name**：`Flask (python -m)`
- **Module name**：`flask`  ← 勾选 *Module name*（不是 Script path）
- **Parameters**：`run --host=0.0.0.0 --port=5001 --debug`
- **Working directory**：你的项目根目录（包含 `app/` 目录的那层）
- **Python interpreter**：选择项目的虚拟环境（`.venv`）
- **Environment variables**（关键）：
  - `FLASK_APP=app`  或 `FLASK_APP=app:create_app`（看你项目结构）
  - `FLASK_ENV=development`
  - （可选）`PYTHONPATH=.`

点 **Apply → OK**，然后 ▶️ 运行。

> 这等价于在终端执行：
>  `python -m flask run --host=0.0.0.0 --port=5001 --debug`

+ api 作为单独项目打开

# docker 部署

## web - Build Docker Image from Source Code

https://docs.dify.ai/en/getting-started/install-self-hosted/start-the-frontend-docker-container

### Dockerfile

```
# base image
FROM node:22-alpine3.21 AS base
LABEL maintainer="takatost@gmail.com"

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG http_proxy
ARG https_proxy
ARG NPM_REGISTRY

ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV http_proxy=${http_proxy}
ENV https_proxy=${https_proxy}
ENV NPM_CONFIG_REGISTRY=${NPM_REGISTRY}

ENV HOSTNAME=0.0.0.0


# if you located in China, you can use aliyun mirror to speed up
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# if you located in China, you can use taobao registry to speed up
RUN npm config set registry https://registry.npmmirror.com

RUN apk add --no-cache tzdata
RUN corepack enable
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV NEXT_PUBLIC_BASE_PATH=


# install packages
FROM base AS packages

WORKDIR /app/web

COPY package.json .
COPY pnpm-lock.yaml .

# Use packageManager from package.json
RUN corepack install

RUN pnpm install --frozen-lockfile

# build resources
FROM base AS builder
WORKDIR /app/web
COPY --from=packages /app/web/ .
COPY . .

ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN pnpm build:docker


# production stage
FROM base AS production

ENV NODE_ENV=production
ENV EDITION=SELF_HOSTED
ENV DEPLOY_ENV=PRODUCTION
ENV CONSOLE_API_URL=http://127.0.0.1:5001
ENV APP_API_URL=http://127.0.0.1:5001
ENV MARKETPLACE_API_URL=https://marketplace.dify.ai
ENV MARKETPLACE_URL=https://marketplace.dify.ai
ENV PORT=3000
ENV NEXT_TELEMETRY_DISABLED=1
ENV PM2_INSTANCES=2

# set timezone
ENV TZ=UTC
RUN ln -s /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone


WORKDIR /app/web
COPY --from=builder /app/web/public ./public
COPY --from=builder /app/web/.next/standalone ./
COPY --from=builder /app/web/.next/static ./.next/static

COPY docker/entrypoint.sh ./entrypoint.sh


# global runtime packages
RUN pnpm add -g pm2 \
    && mkdir /.pm2 \
    && chown -R 1001:0 /.pm2 /app/web \
    && chmod -R g=u /.pm2 /app/web

ARG COMMIT_SHA
ENV COMMIT_SHA=${COMMIT_SHA}

USER 1001
EXPOSE 3000
ENTRYPOINT ["/bin/sh", "./entrypoint.sh"]

```

### shell

```
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

# 用 eval 展开 RUN_PROXY_ENV 里的多个 -e  登录状态固定到指定url, 
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

```

## api & worker

https://legacy-docs.dify.ai/zh-hans/learn-more/faq/install-faq?utm_source=chatgpt.com

### dockerfile

```
# base image
FROM python:3.12-slim-bookworm AS base

# ===== 接收外部 build-arg（代理 + 国内源） =====
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG http_proxy
ARG https_proxy
ARG UV_INDEX_URL       # uv 的国内源
ARG PIP_INDEX_URL      # pip 的国内源（备用）

# ===== 环境变量：让 apt / uv / pip 都走代理 & 国内源 =====
ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV http_proxy=${http_proxy}
ENV https_proxy=${https_proxy}

# uv 使用国内源（等价于 --index-url）
ENV UV_INDEX_URL=${UV_INDEX_URL}
# pip 如果后面用到，也会用国内源
ENV PIP_INDEX_URL=${PIP_INDEX_URL}


WORKDIR /app/api

# Install uv

RUN pip install --no-cache-dir uv


FROM base AS packages

# if you located in China, you can use aliyun mirror to speed up
RUN sed -i 's@deb.debian.org@mirrors.aliyun.com@g' /etc/apt/sources.list.d/debian.sources

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
          # basic environment
          g++ \
          # for building gmpy2
          libmpfr-dev libmpc-dev

# Install Python dependencies
COPY pyproject.toml uv.lock ./
RUN uv sync --locked --no-dev

# production stage
FROM base AS production

ENV FLASK_APP=app.py
ENV EDITION=SELF_HOSTED
ENV DEPLOY_ENV=PRODUCTION
ENV CONSOLE_API_URL=http://127.0.0.1:5001
ENV CONSOLE_WEB_URL=http://127.0.0.1:3000
ENV SERVICE_API_URL=http://127.0.0.1:5001
ENV APP_WEB_URL=http://127.0.0.1:3000

EXPOSE 5001

# set timezone
ENV TZ=UTC

# Set UTF-8 locale
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV PYTHONIOENCODING=utf-8

WORKDIR /app/api

RUN \
    apt-get update \
    # Install dependencies
    && apt-get install -y --no-install-recommends \
        # basic environment
        curl nodejs \
        # for gmpy2 \
        libgmp-dev libmpfr-dev libmpc-dev \
        # For Security
        expat libldap-2.5-0 perl libsqlite3-0 zlib1g \
        # install fonts to support the use of tools like pypdfium2
        fonts-noto-cjk \
        # install a package to improve the accuracy of guessing mime type and file extension
        media-types \
        # install libmagic to support the use of python-magic guess MIMETYPE
        libmagic1 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Copy Python environment and packages
ENV VIRTUAL_ENV=/app/api/.venv
COPY --from=packages ${VIRTUAL_ENV} ${VIRTUAL_ENV}
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

# Download nltk data
RUN python -c "import nltk; nltk.download('punkt'); nltk.download('averaged_perceptron_tagger')"

ENV TIKTOKEN_CACHE_DIR=/app/api/.tiktoken_cache

RUN python -c "import tiktoken; tiktoken.encoding_for_model('gpt2')"

# Copy source code
COPY . /app/api/

# Copy entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ARG COMMIT_SHA
ENV COMMIT_SHA=${COMMIT_SHA}

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

```



✅ **在用这个 Dockerfile 时，`docker run` 里根本不需要写 `uv run ...`**
 真正启动 Flask / Celery 的逻辑都已经写在 `api/docker/entrypoint.sh` 里了，它会根据 `MODE` 环境变量自动决定跑 API 还是 Worker。

现在的设计：一个镜像，多种模式

从 `entrypoint.sh` 可以看出，**同一个镜像**支持 3 种 MODE：

- `MODE=api`  👉 跑 Flask / Gunicorn（对外提供 http 服务）
- `MODE=worker` 👉 跑 Celery worker
- `MODE=beat` 👉 跑 Celery beat 定时任务

也就是说：**镜像是一个**，只是通过 `MODE` 决定容器里到底跑啥。

### sh

```
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
  --env-file .env \
  -v "$(pwd)/storage:/data/storage"
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
  ${RUN_PROXY_ENV} \
  ${IMAGE_NAME}"
eval ${WORKER_RUN_CMD}

echo ">>> Worker 已启动。"
```

# 常用组件

## Code

+ code 解析长文要使用 json.dumps(xxx), 否则会导致异常

## Variable Aggregator

+ 多变量混合, 用于多流程合并一个值

+ 支持多租字段合并

+ 支持直接选取输出值, 注意点外侧的值作为入口可能是 `object`

+ 不适用于 if-else 分支, 会有异常; 只适用于 fail branch

## Variable Assigner￼  & Conversation Variables

这两个组件必须一起才能使用, 只能用于 `chatflow`

+ 用于实现多轮对话上下文

> workflow 新增变量无需 Variable Assigner
>
> 用 code 组件即可

## User input

Dify 的工作流支持在流程中暂停，并向用户请求输入。当你需要让用户选择某个选项时，

只需：`添加 User Input 节点`

## LLM

一定要勾选 `Enable Reasoning Tag Separation`, 这样才会自动把 `thinking` 内容放到 `reasoning_content` 中



## Retrieval Knowledge

+ `Retrieval Setting` => Multi Knowledge
+ `Edit` => Single Knowledge

需要配置单数据库的召回, 多数据库使用权重



## Http Request

一定要记着设置

+ `Timeout`
+ `Verify SSL Certifacate`
+ `Retry on failure`

# 相关问题

## web 部署正常,  localhost:3000不能访问?

+ `docker logs -f dify-web`

  ```
  Starting server on hsiong-Z790-AORUS-PRO-X:3000
  - Local:   http://hsiong-Z790-AORUS-PRO-X:3000
  ```

+ 修改 Dockerfile

  ```
  ENV HOSTNAME=0.0.0.0
  ```

## 登录闪退

+ localhost: 3000 或 127.0.0.1:3000 只有一个能正常登录

直接删掉 Dockerfile 里的那几行 ENV

如果你愿意改镜像构建逻辑，也可以在 `api` 的 Dockerfile 里把这几行删掉：

```
ENV CONSOLE_API_URL=http://127.0.0.1:5001
ENV CONSOLE_WEB_URL=http://127.0.0.1:3000
ENV SERVICE_API_URL=http://127.0.0.1:5001
ENV APP_WEB_URL=http://127.0.0.1:3000
ENV APP_API_URL=http://127.0.0.1:5001
```

让所有这些 URL 全部**只从 `.env`** 来控制。

## worker 启动失败

+ docker logs -f dify-worker

```
File "/app/api/extensions/storage/opendal_storage.py", line 39, in __init__ self.op = Operator(scheme=scheme, **kwargs).layer(retry_layer) ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ opendal.exceptions.ConfigInvalid: ConfigInvalid (permanent) at => root is not specified ； #!/bin/bash set -e
```

+ docker run 加上

```
  --env-file .env \
  -v "$(pwd)/storage:/data/storage"
```

## worker: ValueError: Port could not be cast to integer value as '${REDIS_PORT}

+ docker logs -f dify-worker

```
File "/app/api/.venv/lib/python3.12/site-packages/kombu/utils/url.py", line 72, in url_to_parts parts.port, ^^^^^^^^^^ File "/usr/local/lib/python3.12/urllib/parse.py", line 182, in port raise ValueError(f"Port could not be cast to integer value as {port!r}") ValueError: Port could not be cast to integer value as '${REDIS_PORT}'
```

+ sh 

```
cp .env .env.prod
sed -i "s/\${REDIS_PORT}/${REDIS_PORT}/g" .env.prod

docker run -> -e .env.prod
```

## PrivkeyNotFoundError

+ docker logs -f dify-api

```
get_decrypt_decoding raise PrivkeyNotFoundError(f"Private key not found, tenant_id: {tenant_id}") libs.rsa.PrivkeyNotFoundError: Private key not found,
```

How to fix the “File not found” error in local deployment logs?

```
ERROR:root:Unknown Error in completion
Traceback (most recent call last):
  File "/www/wwwroot/dify/dify/api/libs/rsa.py", line 45, in decrypt
    private_key = storage.load(filepath)
  File "/www/wwwroot/dify/dify/api/extensions/ext_storage.py", line 65, in load
    raise FileNotFoundError("File not found")
FileNotFoundError: File not found
```

This error might be due to changing the deployment method or deleting the `api/storage/privkeys` directory. This file is used to encrypt the large model keys, so its loss is irreversible. You can reset the encryption key pair with the following commands:

- Docker Compose deployment

  ```
  docker exec -it docker-api-1 flask reset-encrypt-key-pair
  ```

- Source code startupNavigate to the `api` directory

  ```
  flask reset-encrypt-key-pair
  ```

  Follow the prompts to reset.

## dify Client error '404 Not Found' for url 'http://127.0.0.1:5002/plugin

+ dify plugin 使用最新版本

```
  # plugin daemon
  plugin_daemon:
    security_opt:
      - seccomp:unconfined
    privileged: true
    image: langgenius/dify-plugin-daemon:main-local-linux-amd64
```

## Bad Request 400: Incorrect decryption

+ rsa 加密异常,  从数据库中删除 secret-key
+ apps -> 根据 name 找到  app_id
+ workflows -> app_id 找到最新的 workflowid,  将`environment_variables` 中删除

## xxx app is disabled

app -> 编辑信息 -> Backend Service API 

## 更换 api 文档的地址

> api -> .env

+ api 调用地址

```
#Service API base URL

SERVICE_API_URL=http://127.0.0.1:5001
```

+ app run 地址

```
# Web APP base URL
APP_WEB_URL=http://172.16.69.222:3000
```



## 装不上plugin

+ TONGYIinit environment for plugin langgenius/tongyi:0.1.0 failed too many times, you should consider the package is corrupted or your network is unstable

  pip 没走国内源

+ ./middleware.env 修改值不生效

因为 environment 优先级 大于 env_file: - ./middleware.env

你**确实有写 `middleware.env`**，但它“不生效”的原因是这行把它覆盖掉了：

```
environment:
  PIP_MIRROR_URL: ${PIP_MIRROR_URL:-}
```

要点两条（很容易忽略）：

1. **变量插值（${…}）只读取宿主机环境变量和项目根目录的 `.env`**，**不读取** `env_file`（如 `middleware.env`）。
2. **同名键以 `environment:` 为准覆盖 `env_file:`**。你这行把值解析成空字符串（因为宿主机/`.env` 没这个变量），从而覆盖了 `middleware.env` 里的值。

所以看起来就像“没读到 `middleware.env`”。

## workflow - batch run app 并发数

`GROUP_SIZE`

- app/components/share/text-generation/index.tsx:45 把 GROUP_SIZE 常量写死为 5，并备注 “to avoid RPM limit”。所有批量执行的逻辑都会用   这个常量来决定同一时间能有多少任务处在 running 状态。 
- app/components/share/text-generation/index.tsx:282-323 的 handleRunBatch 会从上传的 CSV 生成任务列表：前 GROUP_SIZE 条任务被标记为    running，其余标记为 pending。紧接着调用 setControlSend(Date.now())，这样当前处于 running 的任务对应的 Result 组件都会收到同一个 “开始      发送” 事件。  
- app/components/share/text-generation/index.tsx:151-154 把 showTaskList 限制为 “非 pending” 的任务，因此初始只渲染 5 个 Result 组件；    额外的任务要等状态切成 running 才会渲染，从而不会触发更多并发调用。 
-  app/components/share/text-generation/index.tsx:324-357 的 handleCompleted 在某个任务结束后统计已完成数量。如果完成数量正好是    GROUP_SIZE 的倍数，或剩余任务数量不足一个分组，则把下一批（最多 5 条）pending 任务切换成 running，从而以 5 个为一组推进。这里也更新      batchCompletionRes 以便导出。  
-  app/components/share/text-generation/result/index.tsx:413-437 渲染时将 controlSend、taskId 等参数传给 Result。Result 内部的    useEffect（app/components/share/text-generation/result/index.tsx:415-421）监听 controlSend，一旦变化就调用 handleSend，因此只有当前渲      染出来的 running 任务才会真正发起请求。  
-  app/components/share/text-generation/result/index.tsx:221-411 的 handleSend 当 isWorkflow=true 时会调用 sendWorkflowMessage，把 SSE    事件回调（节点开始/结束、循环、文本块等）绑定到具体任务。  
-  service/share.ts:95-147 定义的 sendWorkflowMessage 通过 ssePost(getUrl('workflows/run', …)) 向 workflows/run 发起流式请求。也就是    说，每个 running 任务都会开启一个 SSE 连接；因为上层最多只让 5 个任务同时处于 running，最终就实现了 “Batch run app 每次只并发 5 个接口      调用”。  如果需要修改并发数，只要调整 `GROUP_SIZE`，并确保相应的状态推进逻辑仍然正确即可。

## workflow timeout

`NEXT_PUBLIC_TEXT_GENERATION_TIMEOUT_MS`

- app/components/share/text-generation/result/index.tsx:210 起，组件在发送请求时启动一个 sleep(TEXT_GENERATION_TIMEOUT_MS) 的定时器；若在此时间内流程还未结束，就把 isTimeout 置为 true 并在完成回调里弹出 “Results are not displayed due to timeout…” 的 warning。  

- TEXT_GENERATION_TIMEOUT_MS 定义在 config/index.ts:339，通过 getNumberConfig 读取。它优先取环境变量    NEXT_PUBLIC_TEXT_GENERATION_TIMEOUT_MS，其次取后端暴露的配置项 data-public-text-generation-timeout-ms（参见 types/feature.ts:113 的    DatasetAttr.DATA_PUBLIC_TEXT_GENERATION_TIMEOUT_MS），若都缺失则回退到默认值 60000 毫秒。  
- 因此，这个 timeout 可以在部署时通过设置 `NEXT_PUBLIC_TEXT_GENERATION_TIMEOUT_MS`（或相应的 dataset 属性）来控制；不设置时默认 60 秒后前端停止等待并显示该提示。

## 开启 数据管理员 权限

`api .env` =>  `DATASET_OPERATOR_ENABLED=true`

## Knowledge upload file failed

```
Context:

   service: fs

   path: upload_files/2dca92d0-9529-4f10-b39f-08c42ee94d83/896c8ecf-b576-45e0-9226-c7eb4676b5fc.md



Source:

   Permission denied (os error 13)



2026-01-02 07:06:22,862 INFO [ext_request_logging.py:73] 7223dc8cb1 POST /console/api/files/upload 500 9.918 
```

将 `upload_files` 权限修改

```
hsiong:storage_prod/ (main*) $ sudo chmod -R 777 upload_files                                                                                                    [15:21:02]
[sudo] password for hsiong:         
```

即可



## Ollama 暂不支持 rerank

使用 `Xinference` 替代

```
根据你提供的信息以及目前 Dify 和 Ollama 的架构机制，Dify 目前无法直接通过 Ollama 插件调用 Rerank（重排）模型。

这是因为 Ollama 目前主要暴露的是 Generate (对话) 和 Embeddings (嵌入) 接口，没有原生的 Rerank 接口标准，而 Dify 的 Rerank 模块需要特定的 JSON 数组输入和打分输出格式。

要解决这个问题，你需要采用**“曲线救国”**的方案。以下是三种可行的解决办法，按照推荐程度排序：

方案一：使用 Xinference 部署（最推荐，Dify 原生支持）
Xinference 是 Dify 官方推荐的本地模型推理后端，它完美支持 Rerank 模型，并且 Dify 界面里直接有 Xinference 的配置入口。

安装 Xinference:

Bash

pip install "xinference[all]"
启动 Rerank 模型: 使用 Xinference 启动你想要的 Qwen3-Reranker 或 bge-reranker 模型。

Bash

xinference launch --model-name qwen3-reranker-8b --model-type rerank
(注：如果 Xinference 库中还没更新 Qwen3，可以用通用的 bge-reranker-v2-m3 代替，效果也很稳)

在 Dify 中配置:

进入 Dify -> 设置 -> 模型供应商 -> Xinference。

模型类型选择 Rerank。

输入 Xinference 的地址（例如 http://127.0.0.1:9997）。

Dify 会自动识别已加载的 Rerank 模型。
```



## dify 有时候没有反应

+ 查看是不是 web端的 `CONSOLE_API_URL` 和 `APP_API_URL` 写了内网地址



## 清理孤儿/无用文件

> https://github.com/langgenius/dify/pull/18835

方案 A（官方、相对安全）：定时清理 orphaned files

Dify 官方文档提供了两条管理命令：先清理数据库里的孤儿记录，再删存储里的孤儿文件，并提示要先备份、在维护窗口执行；另外“删存储里的孤儿文件”目前只对 OpenDAL 存储生效（`STORAGE_TYPE=opendal`）。[Dify Docs](https://docs.dify.ai/en/self-host/troubleshooting/storage-and-migration)

**手动执行：**

- 清理孤儿记录：
  - `docker exec -it docker-api-1 flask clear-orphaned-file-records`
- 删除存储孤儿文件：
  - `docker exec -it docker-api-1 flask remove-orphaned-files-on-storage`

**定时执行（cron 示例，每天 03:10 跑一次）：**

```
10 3 * * * docker exec -t docker-api-1 flask clear-orphaned-file-records -f && docker exec -t docker-api-1 flask remove-orphaned-files-on-storage -f
```

> `-f` 用于跳过确认。



### 查看有用的文件

```
WITH files AS (
			  SELECT id::text AS file_id, key FROM upload_files
			  UNION ALL
			  SELECT id::text AS file_id, file_key AS key FROM tool_files
			  ),
	 usage AS (
			  -- 直接等值
			  SELECT 'message_files.upload_file_id' AS src, mf.id::text AS record_id, mf.upload_file_id::text AS file_id
			  FROM message_files mf

			  -- 正则提取
			  UNION ALL SELECT 'documents.data_source_info', d.id::text, m[1]
			  FROM documents d CROSS JOIN LATERAL regexp_matches(d.data_source_info::text,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'document_segments.content', ds.id::text, m[1]
			  FROM document_segments ds CROSS JOIN LATERAL regexp_matches(ds.content,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'messages.answer', msg.id::text, m[1]
			  FROM messages msg CROSS JOIN LATERAL regexp_matches(msg.answer,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'messages.inputs', msg.id::text, m[1]
			  FROM messages msg CROSS JOIN LATERAL regexp_matches(msg.inputs::text,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'messages.message', msg.id::text, m[1]
			  FROM messages msg CROSS JOIN LATERAL regexp_matches(msg.message::text,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'workflow_node_executions.process_data', w.id::text, m[1]
			  FROM workflow_node_executions w CROSS JOIN LATERAL regexp_matches(w.process_data::text,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'workflow_node_executions.outputs', w.id::text, m[1]
			  FROM workflow_node_executions w CROSS JOIN LATERAL regexp_matches(w.outputs::text,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'conversations.introduction', c.id::text, m[1]
			  FROM conversations c CROSS JOIN LATERAL regexp_matches(c.introduction,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'conversations.system_instruction', c.id::text, m[1]
			  FROM conversations c CROSS JOIN LATERAL regexp_matches(c.system_instruction,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'accounts.avatar', a.id::text, m[1]
			  FROM accounts a CROSS JOIN LATERAL regexp_matches(a.avatar,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'apps.icon', a.id::text, m[1]
			  FROM apps a CROSS JOIN LATERAL regexp_matches(a.icon,'[0-9a-fA-F-]{36}','g') m

			  UNION ALL SELECT 'sites.icon', s.id::text, m[1]
			  FROM sites s CROSS JOIN LATERAL regexp_matches(s.icon,'[0-9a-fA-F-]{36}','g') m
			  )
SELECT DISTINCT u.src, u.record_id, u.file_id, f.key
FROM usage u
		 JOIN files f ON f.file_id = u.file_id
ORDER BY u.src, u.record_id;
```



### 日志文件

> 注意: 日志文件引用了上传文件, 也会认为是引用状态 , `workflow_node_executions`

配置日志文件历史  `.env.*` :

```
# Enable automatic cleanup of workflow run logs to manage database size
WORKFLOW_LOG_CLEANUP_ENABLED=true
# Number of days to retain workflow run logs (default: 30 days)
WORKFLOW_LOG_RETENTION_DAYS=30
# Batch size for workflow log cleanup operations (default: 100)
WORKFLOW_LOG_CLEANUP_BATCH_SIZE=100
```

### 单元测试

```
uv run pytest \
  --timeout "${PYTEST_TIMEOUT:-180}" \
  tests/integration_tests/workflow \
  tests/integration_tests/tools \
  tests/test_containers_integration_tests \
  tests/unit_tests
```

工作目录里有 .env，DifyConfig 默认会读取它（env_file=.env），即便在测试里用 os.environ.clear()，.env 里的值仍会覆盖默认值。你本地 .env 设置了：

  - SQLALCHEMY_POOL_PRE_PING=true，导致预期的 pool_pre_ping=False 断言失败。
  - HTTP_REQUEST_MAX_CONNECT_TIMEOUT=300（以及 read/write 6000），导致期望的默认 10/600/600 断言失败

而在线上环境, 是没有 .env 文件的;  所以不应该用 .env 而是应该用 `.env.test`; 所以无法兼顾线上和线下



### File upload is disabled

`Features` -> `File Upload`
