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

## models 

https://ollama.com/library/qwen3.5/tags?utm_source=chatgpt.com

So:

- **Definitely MLX-looking by name:** `*-mlx-bf16`
- **Strong MLX-era Apple-Silicon variants:** `nvfp4`, `mxfp8`
- **Do not infer from name alone:** `int4`, `q4_K_M` 

## how run

on Apple Silicon, **the reliable way to confirm MLX is the server log**, not `ollama ps`. `ollama ps` only tells you whether the model is resident in **GPU memory, CPU memory, or both**; it does **not** identify the execution engine. Ollama’s docs explicitly describe `ollama ps` as a GPU/CPU residency check, and on macOS the logs live in `~/.ollama/logs/server.log`. 

Use this:

```

check_mlx() {
  local model="$1"
  local log="$HOME/.ollama/logs/server.log"
  local start

  start=$(wc -l < "$log")
  echo "=== running: $model ==="

  # ollama run "$model" "hello" >/dev/null
   ollama run "$model" "hello"

  echo "=== new log lines for: $model ==="
  sed -n "$((start+1)),\$p" "$log" \
    | grep -F 'starting mlx runner subprocess' \
    | grep -F "model=$model"
}

check_mlx qwen3.5:27b-nvfp4
check_mlx qwen3.5:35b-a3b
check_mlx qwen3.5:35b-a3b-nvfp4

```

# benchmark


```

benchmark_mlx(){
    local MODEL="$1"
    curl -s http://localhost:11434/api/generate -d "{
    \"model\": \"$MODEL\",
    \"prompt\": \"Write a 400-word explanation of how DNS works.\",
    \"stream\": false,
    \"options\": {
        \"temperature\": 0,
        \"seed\": 42,
        \"num_predict\": 512
    }
    }" | jq '
    {
    model,
    prompt_tokens: .prompt_eval_count,
    output_tokens: .eval_count,
    prefill_tps: ((.prompt_eval_count * 1000000000) / .prompt_eval_duration),
    decode_tps: ((.eval_count * 1000000000) / .eval_duration),
    end_to_end_tps: ((.eval_count * 1000000000) / .total_duration),
    load_ms: (.load_duration / 1000000),
    total_ms: (.total_duration / 1000000)
    }'
}

```

##  qwen3.5:35b-a3b-q4_K_M  vs  qwen3.5:35b-a3b-nvfp4 

benchmark_mlx qwen3.5:35b-a3b

benchmark_mlx qwen3.5:35b-a3b-nvfp4 

```

vjf:~/ $ benchmark_mlx qwen3.5:35b-a3b-nvfp4                                                                  [9:25:20]
{
  "model": "qwen3.5:35b-a3b-nvfp4",
  "prompt_tokens": 23,
  "output_tokens": 512,
  "prefill_tps": 39.46702074143974,
  "decode_tps": 37.32180886415558,
  "end_to_end_tps": 35.664877484729644,
  "load_ms": 52.41725,
  "total_ms": 14355.860334
}

```


## qwen3.5:27b-q4_K_M vs qwen3.5:27b-nvfp4

