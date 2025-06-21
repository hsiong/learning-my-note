
initial

```shell
cd docker
cp middleware.env.example middleware.env
cp docker-compose.middleware.yaml docker-compose.middleware.copy.yaml
sudo docker compose -f docker-compose.middleware.copy.yaml  down
sudo rm -rf ./volumes/* && sudo rm -rf ../api/storage

ps aux | grep celery | grep -v grep | awk '{print $2}' | xargs kill -9
sudo docker compose -f docker-compose.middleware.copy.yaml  up -d

pip install uv
uv pip install -r pyproject.toml  --group storage --group tools --group vdb --group dev
#pip install poetry
#poetry install

cd  ../api
# cp .env.example .env
# lask db upgrade
flask db upgrade
celery -A app.celery worker -P gevent -c 1 --loglevel INFO -Q dataset,generation,mail,ops_trace
flask run --host 0.0.0.0 --port=5001 --debug

cd ../web
brew install node@22
brew unlink node@16
brew link --overwrite node@22
echo 'export PATH="/opt/homebrew/opt/node@22/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

rm -rf node_modules pnpm-lock.yaml package-lock.json
pnpm config set proxy http://127.0.0.1:7890
pnpm config set https-proxy http://127.0.0.1:7890
pnpm config set registry https://registry.npmmirror.com/
pnpm install
pnpm run build
pnpm start



# don't use proxy
# install plugin from local & wait to install
````



## PyCharm 运行 Celery worker

1. **点开右上角的小三角旁边的下拉 → Edit Configurations…**

2. 点左上角的“+”新建一个**Python**类型的配置。

3. 配置如下内容：

   - **Name**：随便，比如 `Celery worker`

   - **Script path**：填入 celery 可执行文件路径（通常是你的 venv 里的 celery 脚本，推荐用绝对路径，如果用 pyenv/poetry/uv 也要选 venv 下的 celery）

     - 你可以 `which celery` 找到路径，比如 `/Users/vjf/Projects/python/dify-prod/api/.venv/bin/celery`

   - **Parameters**：

     ```sh
     -A app.celery worker -P gevent -c 1 --loglevel INFO -Q dataset,generation,mail,ops_trace
     ```

   - **Working directory**：

     - 你的项目根目录，比如 `/Users/vjf/Projects/python/dify-prod/api`

   - **Python interpreter**：

     - 选择你的虚拟环境 Python