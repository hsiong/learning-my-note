> 原因: ollama 不支持 rerank

使用 llama-server 来部署, https://github.com/ggml-org/llama.cpp/releases

https://www.modelscope.cn/models/dengcao/Qwen3-Reranker-8B-GGUF

https://chatgpt.com/c/695788f2-58f0-8322-9171-e4f3f12401cb



# 编译 cuda 版本 llama

```sh
lsb_release -a

curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/3bf863cc.pub | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-cuda-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nvidia-cuda-archive-keyring.gpg] https://mirrors.tuna.tsinghua.edu.cn/nvidia-cuda/ubuntu2404/x86_64/ /" | sudo tee /etc/apt/sources.list.d/nvidia-cuda.list
sudo apt update
sudo apt install -y cuda-toolkit-12-8
export PATH=/usr/local/cuda-12.8/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH

sudo apt install libcurl4-openssl-dev
cd llama.cpp
rm -rf build  
cmake -B build \
-DGGML_CUDA=ON \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CUDA_ARCHITECTURES=89 \
-DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc
cmake --build build -j"$(nproc)"


# test /media/hsiong/JF-Disk/code/model/Qwen3-Reranker-8B-GGUF
./build/bin/llama-server \
  -m /media/hsiong/JF-Disk/code/model/Qwen3-Reranker-8B-GGUF/Qwen3-Reranker-8B-q4_k_m.gguf \
  --port 11440 \
  -ngl 99 \
  --reranking \
  --host 0.0.0.0


```

## 2) curl 本地测试 `/v1/rerank`

`llama-server` 文档给的示例就是 `/v1/rerank` 这个格式。[GitHub](https://raw.githubusercontent.com/ggml-org/llama.cpp/master/tools/server/README.md)

```
curl http://127.0.0.1:11440/v1/rerank \
  -H "Content-Type: application/json" \
  -d '{
    "model": "bge-reranker-v2-m3",
    "query": "什么是熊猫？",
    "top_n": 3,
    "documents": [
      "hi",
      "它是一种熊",
      "大熊猫是一种原产于中国的熊科动物。"
    ]
  }'
```

能返回排序/分数就说明 rerank 服务没问题。

# llama 随 Fastapi 启动

> 由 Fastapi 管理子进程

```
import logging
import os
import signal
import subprocess
from contextlib import asynccontextmanager

from fastapi import FastAPI

from config.settings import LLAMA_RANK_GGUF, LLAMA_PATH, LLAMA_PORT

LLAMA_ARGS = [
	LLAMA_PATH,
	"-m", LLAMA_RANK_GGUF,
	"--host", "0.0.0.0",
	"--port", str(LLAMA_PORT),
	"-ngl", "99", # 尽可能多地把 encoder 层放到 GPU
	"--reranking",          # 如果你版本只有 --reranking，就改成 "--reranking"
	"--embedding",
	"--pooling", "rank", # 决定 encoder 输出 token 如何聚合
	"-a", "bge-reranker-v2-m3", # 与 dify-OpenAI-API-compatible 一致
]

proc: subprocess.Popen | None = None

# 把一个 async def 写成异步上下文管理器。
@asynccontextmanager
async def lifespan(app: FastAPI):
	global proc
	# Popen 可以用来检查进程是否还活着、等待退出、杀掉等。
	proc = subprocess.Popen(
		LLAMA_ARGS,
		preexec_fn=os.setsid,          # 独立进程组，方便整体 kill
		stdout=subprocess.DEVNULL,
		stderr=subprocess.STDOUT,
	)
	# yield 之前：应用启动时执行（startup）
	# yield 之后：应用关闭时执行（shutdown）
	yield
	if proc and proc.poll() is None:
		os.killpg(proc.pid, signal.SIGTERM)
		try:
			proc.wait(timeout=10)
			logging.info("LLAMA 进程退出")
		except subprocess.TimeoutExpired:
			os.killpg(proc.pid, signal.SIGKILL)
			logging.info("LLAMA 进程强制退出")
```

在 `main.py`

```
def create_app() -> FastAPI: 
	app = FastAPI(title="Aesthetic Customer Value Engine", lifespan=lifespan) # 生命周期启动 llama
	
```

# Dify OpenAI-API-compatible

## Dify 怎么接（推荐方案：OpenAI-API-compatible）

在 Dify 后台 **Model Providers → OpenAI-API-compatible**：

- **Base URL / Endpoint**：`http://<你的机器IP>:11440/v1`
- **Model Type**：Rerank
- **Model Name**：`bge-reranker-v2-m3`（要和你 `-a` 对上）
- **API Key**：如果你没给 llama-server 配 `--api-key`，这里一般填任意非空字符串即可（避免某些校验把空当错）
