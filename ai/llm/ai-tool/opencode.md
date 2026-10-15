## Install OpenCode on Linux

You can install it without `sudo`.

Recommended installation:

```
curl -fsSL https://opencode.ai/v2/install | bash
```



## OpenCode & Ollama

### 一、OpenCode 与 llama-server、Ollama 的关系

- **OpenCode 调用的确实是本地 Ollama** OpenCode 配置连接的是 `http://127.0.0.1:11434/v1`（Ollama 提供的 OpenAI 兼容接口）。
- **Ollama 底层的真正引擎就是 llama-server** Ollama 本身是用 Go 语言编写的系统守护进程与 API 网关，它没有自己重写模型推理内核，而是将深度优化的 llama.cpp 编译打包为子进程 `/usr/local/lib/ollama/llama-server`。
- **动态拉起机制** 当 OpenCode 发送补全或对话请求给 Ollama 后，Ollama 守护进程会自动按照模型规格与系统参数，启动并管理后台的 llama-server 进程来进行实际的 GPU 矩阵推理。

------

### 二、为什么 ollama show 显示 262144，实际却变成了 65536

- **ollama show 显示的是模型元数据**`context length: 262144（256k）` 是阿里千问模型 GGUF 文件中内置的原生最大理论支持上限。

- **系统环境变量强行覆盖了默认值** 排查了你本机的 systemd 配置，发现在文件 `/etc/systemd/system/ollama.service.d/override.conf` 中，明确配置了全局上下文限制：

  ```
  Environment="OLLAMA_CONTEXT_LENGTH=65536"
  ```

- **参数传递链路** Ollama 读取了该环境变量，因此每次在后台拉起 llama-server 时，都会强制追加 `-c 65536`，把模型运行时的最大上下文截死在 64k。

------

### 三、如何修改最大上下文限制

#### 步骤 1：编辑 systemd 配置文件

使用 root 权限打开覆盖配置文件：

```
sudo vim /etc/systemd/system/ollama.service.d/override.conf
```

#### 步骤 2：修改 OLLAMA_CONTEXT_LENGTH

将 65536 改为你期望的值（例如翻倍至 128k 即 131072）：

```
[Service]
Environment="OLLAMA_MODELS=/usr/model/ollama_model"
Environment="OLLAMA_HF_MIRROR=https://modelscope.cn"

Environment="OLLAMA_CONTEXT_LENGTH=131072"
Environment="OLLAMA_FLASH_ATTENTION=1"
Environment="OLLAMA_KV_CACHE_TYPE=q8_0"
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

#### 步骤 3：重载并重启服务

```
sudo systemctl daemon-reload
sudo systemctl restart ollama
```