
# 1秒钟关闭AI道德限制 —— 这就是当今最强的abliterated大模型 和 prompt

https://zhuanlan.zhihu.com/p/1907104753776825186



1. [FiditeNemini](https://zhida.zhihu.com/search?content_id=257856126&content_type=Article&match_order=1&q=FiditeNemini&zhida_source=entity)/Llama-3.1-Unhinged-Vision-8B-GGUF：第一个坑。
2. [amarck](https://zhida.zhihu.com/search?content_id=257856126&content_type=Article&match_order=1&q=amarck&zhida_source=entity)/Qwen3-30B-A3B-abliterated：第二个坑。
3. [zetasepic](https://zhida.zhihu.com/search?content_id=257856126&content_type=Article&match_order=1&q=zetasepic&zhida_source=entity)/Qwen2.5-32B-Instruct-abliterated-pass2：整个系列都是坑。
4. huihui_ai/deepseek-r1-abliterated：最靠谱的，不强但很稳定。
5. huihui_ai/deepseek-r1-abliterated:8b：内容相对简单，贵在适配性好，低性能主机也能跑
6. huihui_ai/deepseek-r1-abliterated:14b：在我设备上跑的很好，
7. huihui_ai/deepseek-r1-abliterated:32b：比较吃力，并没有比14b强太多（可能是设备算力不够）
8. wizardlm-uncensored：最坑的，越狱程度堪称背着贞操带的老修女。
9. dfebrero/Llama-3.2-8X3B-MOE-Dark-Champion-Instruct-uncensored-abliterated-18.4B-Q4XS:latest：胡说八道、不停重复、答非所问，总纠结前边的问题，但他很快，很快，堪称越狱界的猫，处于越狱与不越狱的量子态。
10. mradermacher/phi-4-abliterated-Orion-18B-GGUF：最强的，强的有些意外。
11. phi-4-abliterated-Orion-18B.IQ4_XS.gguf
12. phi-4-abliterated-Orion-18B.Q3_K_S.gguf
13. phi-4-abliterated-Orion-18B.Q6_K.gguf
14. phi-4-abliterated-Orion-18B.Q2_K.gguf：能耗低，速度快，低性能主机的首选
15. phi-4-abliterated-Orion-18B.Q4_K_M.gguf
16. phi-4-abliterated-Orion-18B.Q8_0.gguf：最慢的，甚至会卡死，算力不够的可以不用下载
17. phi-4-abliterated-Orion-18B.Q3_K_L.gguf
18. phi-4-abliterated-Orion-18B.Q5_K_M.gguf
19. phi-4-abliterated-Orion-18B.Q3_K_M.gguf
20. phi-4-abliterated-Orion-18B.Q5_K_S.gguf



# codex 调用本地模型

```
codex --oss -m huihui_ai/gpt-oss-abliterated:20b
```

## 方案 1：直接用 `--oss`

这是最省事的。Codex 官方文档说明，`--oss` 会让 Codex 走本地开源模型 provider，并且会检查 Ollama 是否在运行；如果你没有额外指定 provider，Codex 会使用 `oss_provider` 作为默认本地 provider。Codex CLI 本身可通过 `npm i -g @openai/codex` 或 `brew install codex` 安装，配置文件默认在 `~/.codex/config.toml`，也支持项目级 `.codex/config.toml`。

先把基础环境准备好：

```
# 1) 安装 Codex CLI
npm i -g @openai/codex

# 2) 启动 Ollama
ollama serve
```

如果你打算先用 OpenAI 官方的本地开源模型，OpenAI 的 cookbook 给的是：

```
ollama pull gpt-oss:20b
```

OpenAI 的本地 Ollama 指南里给出的示例模型名就是 `gpt-oss:20b` / `gpt-oss:120b`。

然后给 Codex 配一个默认本地 provider：

```
# ~/.codex/config.toml
oss_provider = "ollama"
```

## 切 abliterated 本地 - ollama

```
codex --oss -m huihui_ai/gpt-oss-abliterated:20b
```