#  install

More specifically, recent discussion in the official Ollama repo says the minimum became **macOS 14 starting with Ollama 0.12.5**. That means on **Ventura 13.4.1**, current releases may fail to install, fail to launch, or break after update. 

 The default model location is `~/.ollama/models`, and the override variable is `OLLAMA_MODELS`

```
curl -fsSL https://ollama.com/install.sh | sh
```

On **macOS**, the **default model storage path** is:

```
~/.ollama/models
```





# mlx

on Apple Silicon, **the reliable way to confirm MLX is the server log**, not `ollama ps`. `ollama ps` only tells you whether the model is resident in **GPU memory, CPU memory, or both**; it does **not** identify the execution engine. Ollama’s docs explicitly describe `ollama ps` as a GPU/CPU residency check, and on macOS the logs live in `~/.ollama/logs/server.log`. 

Use this:

```
# terminal 1
tail -f ~/.ollama/logs/server.log | grep -i mlx

# terminal 2
ollama run qwen3.5:27b-mlx-bf16
# or
ollama run qwen3.5:35b-a3b-mlx-bf16

# terminal 3
ollama ps
```

If it is really taking the MLX path, the log should contain markers like:

```
starting mlx runner subprocess
MLX engine initialized
mlx runner is ready
```