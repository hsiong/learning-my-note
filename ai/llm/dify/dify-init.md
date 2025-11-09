## initial

+ 项目不能放在移动盘 懂了吗

  典型的 Postgres 在容器里尝试 chmod 700 失败：你的 /var/lib/postgresql/data/pgdata 映射到了宿主机的 NTFS/exFAT 之类不支持 Unix 权限的文件系统，或者绑定的是个不允许 chmod 的路径，所以报

+ 使用项目专属 venv

  uv 的设计理念是：每个项目独立、可复现、不污染系统环境。所以：它会为每个项目创建一个 .venv/（或者你配置的虚拟环境目录）。依赖全部安装到这个虚拟环境的 lib/pythonX.Y/site-packages 下。激活该虚拟环境后，Python / pip / uv 都只看到项目自己的依赖。这样：不会和系统 Python 冲突；不同项目可以用不同版本的 Flask、Django、Numpy 等；项目可复现（别人 uv sync 一下就能复现环境）。

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

## 相关问题

### 装不上plugin

+ TONGYIinit environment for plugin langgenius/tongyi:0.1.0 failed too many times, you should consider the package is corrupted or your network is unstable

  pip 没走国内源

#### ./middleware.env 修改值不生效

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
