# 初始化

## 安装 **Ollama**

```
curl -fsSL https://ollama.com/install.sh | sh
```

## 配置国内源

1. 支持的“国内镜像源”示例

文章里列的是几家可用的镜像 / 中转源：

- 阿里云：`https://registry.ollama.ai`（看起来是走了国内加速线路的同域名）
- DeepSeek 官方镜像：`https://ollama.deepseek.com`
- 浙江大学镜像站：`https://ollama.zju.edu.cn`
- 魔搭社区：`https://ollama.modelscope.cn`

> 实际上就是让 Ollama 在访问 `registry.ollama.ai` 时，转到这些镜像站去拉模型。

------

2. Linux / macOS 配置 `config.json`

```
mkdir -p ~/.ollama

cat << 'EOF' > ~/.ollama/config.json
{
  "registry": {
    "mirrors": {
      "registry.ollama.ai": "https://ollama.modelscope.cn"
    }
  }
}
EOF
```

如果你想用别的镜像，替换成例如：

```
{
  "registry": {
    "mirrors": {
      "registry.ollama.ai": "https://ollama.deepseek.com"
    }
  }
}
```

然后重启 Ollama 服务让配置生效：

```
sudo systemctl restart ollama
```

## 配置权重文件路径

```
sudo EDITOR=vim systemctl edit ollama
```

修改目录

```
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
Restart=always
User=root
Group=root

# ← 你现在已有的 PATH 配置
Environment="PATH=/home/hsiong/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

# ← 在这里新增 OLLAMA_MODELS（这一行就是你要加的）
Environment="OLLAMA_MODELS=/mnt/bigdisk/ollama-models"

[Install]
WantedBy=multi-user.target
```

+ 注意: 同时修改 User 和 Group ⭐️⭐️⭐️
+ 你可以这样确认一下：

```
sudo systemctl daemon-reload
sudo systemctl restart ollama
systemctl show ollama | grep OLLAMA_MODELS

```

## 基本操作

### 启动

```
ollama serve
```

启动 **Ollama 服务端**，提供 `http://localhost:11434` API。

> 调用
>
> curl http://localhost:11434/api/generate \
>   -H "Content-Type: application/json" \
>   -d '{
>     "model": "qwen2.5:7b-instruct-q4_0",
>     "prompt": "写一段 50 字左右的中文自我介绍：",
>     "stream": false
>   }'
>
> 在 Ollama 里：
>
> - **`模型名` 可以带 tag，也可以不带 tag**
>    例子（官方文档里的 CodeLlama）：
>   - 有 tag：`codellama:latest`
>   - 直接用：`"model": "codellama"` 一样能用默认版本（实际就是 latest）

### 拉取

```
ollama pull xxx
```

你 `ollama pull xxx` 下来的所有模型，主要是占 **硬盘空间**。

就算你拉了 10 个 7B / 14B 模型，只要不同时加载，它们只占硬盘，不吃显存。

### 运行

```
ollama run qwen2.5:7b-instruct-q4_0 "你好"
```

只有当你 **实际运行** 某个模型（`ollama run` 或 API 请求）时，这个模型才会被加载到内存/显存里。

运行完一段时间不再用，Ollama 会在一段空闲时间后自动把它卸载（默认大约几分钟，可通过 `OLLAMA_KEEP_ALIVE` 或 `keep_alive` 参数调整）。

Ollama 的行为是：

- **首次调用该模型（run / API 调用）时加载进内存/显存**
- 加载完成后：
  - 模型 **常驻（cached）** 一段时间
  - 不会每次 API 调用都重新加载
  - 后续调用基本是 **即时响应**

也就是说，你只要 **第一次触发一次 run 或 API 调用，就等于让它“预热”了**。

### 关闭

1. 显式把这个模型从内存里“关掉”：

```
ollama stop qwen2.5:7b-instruct-q4_0
```

### 常驻

```
ollama run qwen2.5:7b-instruct-q4_0 --keepalive -1
```

含义：

- `--keepalive -1`：告诉 Ollama **这次加载的模型无限期常驻**，直到你手动关掉进程 / 重启服务。
- 不加参数时，默认是“空闲几分钟后自动卸载”。
- 不建议使用

# 监控

## 日志

Ollama 默认把日志写到：

### **📍 Linux / Ubuntu**

```
/usr/share/ollama/.ollama/logs/ollama.log
```

如果你用 systemd（大部分服务器都是），其实也可以用：

```
journalctl -u ollama -f
```

`-f` = 跟踪日志（实时刷新）

## **实时监控系统资源（GPU/CPU/内存）**

使用以下工具：

------

### 🔥 **(1) GPU 实时监控**

```
watch -n 1 nvidia-smi
```

可看到：

- GPU 利用率
- 显存占用
- GPU 温度
- 显存泄漏情况（非常关键）

### 想看每个进程的显存占用（最常用）

```
nvidia-smi pmon -s um
```

------

### 🔥 **(2) CPU & 内存监控**

```
htop
```

或

```
top
```

------

### 🔥 (3) 结合 GPU + CPU + 内存监控（推荐）

**nvtop**（多 GPU 可视化）

安装：

```
sudo apt install nvtop
```

运行：

```
nvtop
```

------

## 🟦 5. **监控 Ollama Qwen 模型的 QPS / 请求信息（API 层）**

如果你是用 API 调用：

### 查看 access log（请求日志）

位置通常在：

```
/usr/share/ollama/.ollama/logs/access.log
```

可以实时查看：

```
tail -f /usr/share/ollama/.ollama/logs/access.log
```

能看到：

- 请求时间
- endpoint
- Model name（例如：qwen2.5-14b-q4）
- 耗时
- token 数
- 客户端 IP

------

## 🟩 6. **开启 Ollama 调试模式（高级）**

可以让 Ollama 输出更详细日志。

临时开启：

```
OLLAMA_DEBUG=1 ollama serve
```

或修改 service：

```
sudo systemctl edit ollama
```

加入：

```
[Service]
Environment="OLLAMA_DEBUG=1"
```

重启：

```
sudo systemctl restart ollama
```

------

## 🟧 7. **如果你希望更专业监控（推荐）**

可以加上 Prometheus + Grafana：

### 导出 Ollama 统计信息

目前需要借助社区 exporter，例如：

```
https://github.com/ollama/ollama-prometheus-exporter
```

支持监控：

- 每秒请求数（QPS）
- token/s 推理速度
- 模型加载时间
- 一个模型占多少 GPU 内存
- 每个请求的延迟统计
- Errors 统计

Grafana 可以直接展示可视化图表。

------

# 🟦 8. **最佳监控组合（我推荐）**

| 监控内容               | 工具                     |
| ---------------------- | ------------------------ |
| GPU 使用率 / 显存占用  | nvidia-smi / nvtop       |
| CPU / 内存占用         | htop                     |
| Ollama 日志            | journalctl 或 ollama.log |
| API 调用日志           | access.log               |
| 高级监控               | Prometheus + Grafana     |
| 实时模型状态与载入情况 | OLLAMA_DEBUG=1           |

# 部署 Embadding

## 模型选型

以下是几款在中文语义任务上表现不错的模型：

| 模型名称                                                   | 概要                                                         | 特点 & 适用场景                                              |
| ---------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| BGE‑M3                                                     | 中国团队开源的多语言嵌入模型，专注于中文表现。[53AI+2arXiv+2](https://www.53ai.com/news/RAG/2025031609253.html?utm_source=chatgpt.com) | 向量维度 1024，支持最大序列长度较长（8192 tokens）[53AI+1](https://www.53ai.com/news/RAG/2025031609253.html?utm_source=chatgpt.com) 。适合中文检索、跨语言应用。 |
| Qwen3‑Embedding 系列                                       | Alibaba 提供的 “Qwen3 Embedding” 模型系列，以多语言和大规模量化著称。[Hugging Face+1](https://huggingface.co/Qwen/Qwen3-Embedding-8B?utm_source=chatgpt.com) | 不仅中文，也支持多语言。可选模型规模有 0.6B / 4B / 8B 等参数量。适合需要强语义、长文本或跨语言场景。 |
| Seed1.5‑Embedding                                          | ByteDance 出品的 embedding 模型，在中英文任务上都有 SOTA 表现。[ByteDance Seed](https://seed.bytedance.com/en/blog/bytedance-s-seed1-5-embedding-model-achieves-sota-in-retrieval-training-details-unveiled?utm_source=chatgpt.com) | 如果你需要最新、效果较好的模型，这个值得考虑。               |
| text‑embedding‑3‑large（英文模型，但在中文场景也有被使用） | 来自 OpenAI 的 embedding 系列。虽主要为英文，但有不少中文使用案例。[飘逝的风+1](https://gameapp.club/post/2025-04-02-embedding-compare/?utm_source=chatgpt.com) | 如果你的场景为中英混合或偏英文内容，这款也可以作为备选。     |

>  🛠 选型时推荐考虑的维度
>
> 在选 embedding 模型时，建议从下面这些维度来评估：
>
> 1. **语义效果（Quality）**
>    - 模型是否能较好地捕捉中文语义、区分细微差别。
>    - 看 benchmark 表现，例如中文专门的 C-MTEB 数据集中成绩如何。[arXiv+1](https://arxiv.org/pdf/2309.07597?utm_source=chatgpt.com)
> 2. **支持文本长度 / 向量维度 /多语言支持**
>    - 如果你的场景包含长文本（如长文档、报告、合同）——就需要模型支持较长序列（如 8k tokens）。
>    - 向量维度越大，一般能表示更多信息，但计算成本也会更高。比如 BGE-M3 向量维度 1024。[53AI](https://www.53ai.com/news/RAG/2025031609253.html?utm_source=chatgpt.com)
>    - 是否仅中文、还是支持多语言/中英混合，这取决于你的需求。
> 3. **部署及成本**
>    - 是开源模型还是闭源 API？开源模型自部署可能更灵活、成本可控，但维护也更复杂。
>    - 模型的参数量、推理速度、内存／GPU 消耗等也要考虑。[BentoML+1](https://www.bentoml.com/blog/a-guide-to-open-source-embedding-models?utm_source=chatgpt.com)
> 4. **场景匹配**
>    - 是做短文本语义匹配？还是做文档检索、聚合？还是做多模态（文本＋图片）？不同模型适用不同场景。
>    - 例如，如果是做“问答中的语义搜索”，你可能优先关注召回率和语义相关性。
> 5. **是否需要本地化 or 自定义微调**
>    - 如果你的语料非常垂直（如法律、金融、医药中文语料），可能还需要模型能支持在该领域微调。
>    - 是否需要本地化部署以保证数据隐私与合规。

#### 📘 **向量维度 384 / 768 / 1536 全面对比表**

| 项目                     | **384 维**                   | **768 维**                          | **1536 维**                                 |
| ------------------------ | ---------------------------- | ----------------------------------- | ------------------------------------------- |
| **表达能力**             | 较低（粗语义）               | 中高（主流能力）                    | 最强（细粒度语义）                          |
| **适用场景**             | 简单 FAQ、小知识库、轻量搜索 | 企业级搜索、RAG、推荐系统、技术文档 | 高精度 RAG、科研/法律文档、复杂语义、多语言 |
| **搜索精度（Recall）**   | 中                           | 高                                  | 最高                                        |
| **长文本理解能力**       | 弱                           | 中                                  | 强                                          |
| **多语言能力**           | 中                           | 中上                                | 强                                          |
| **噪声鲁棒性**           | 中                           | 高                                  | 高                                          |
| **查询速度**             | ★★★★★ 最快                   | ★★★★☆ 快                            | ★★☆☆☆ 较慢                                  |
| **存储成本**             | ★★★★★ 最低                   | ★★★★☆ 中等                          | ★☆☆☆☆ 最高                                  |
| **单条向量大小（FP32）** | ~1.5 KB                      | ~3 KB                               | ~6 KB                                       |
| **1000 万条占用容量**    | ~15 GB                       | ~30 GB                              | ~60 GB                                      |
| **成本/性能平衡**        | 成本优先                     | 最均衡                              | 精度优先                                    |
| **是否适合大规模向量库** | 非常适合                     | 适合                                | 需较高成本                                  |
| **典型用途**             | FAQ 检索、意图分类、小系统   | 企业搜索、电商推荐、技术资料分析    | 专业领域信息检索、深度 RAG、复杂跨语义任务  |
| **推荐理由**             | 性价比最高、速度快           | 综合表现最佳                        | 精度最强、适合严苛任务                      |

## 文本处理

### 使用 “Overlap 重叠策略”切分

为了避免切分点把句子、概念、定义 分开，我们会使用：

**🔁 重叠 100～150 字**

例子：

chunk1：内容A + 内容B + **部分重叠C**
 chunk2：**部分重叠C** + 内容D + 内容E

这样保证：

- 上下文不丢
- 逻辑可以在 chunk 之间连续传递
- RAG、聚类、召回效果更稳定

### 标题

#### **题必须是中文语义化标题，不能乱写、不用太深层级。**

下面我把最佳实践给你讲清楚。

------

🟩 一、为什么 `## / ###` 多级标题适合 embedding？

因为 embedding 模型（如 BGE、Qwen、Seed）其实是**语言模型**，它们会理解：

- `## 基础信息` 代表一个语义段落开始
- `## 消费记录` 下面是消费相关内容
- `### 医美项目消费` 是更细粒度分类

标题 → 是强语义信号，会让 embedding 更清晰。

**不像表格那样会破坏向量质量**。

所以 **标题 + 列表** 是最佳组合。

------

🟧 二、最推荐的结构（你直接照这个用）

例如一个用户的完整行为，可以这样组织：

```
## 基础信息
- 年龄：28
- 城市：北京
- 性别：女

## 消费记录
### 医美项目消费
- 项目：全切双眼皮；金额：7800 元；日期：2023-09-12
- 项目：祛眼袋；金额：5200 元；日期：2024-01-03

### 皮肤项目消费
- 项目：皮肤管理；金额：398 元；日期：2024-01-28

## 浏览行为
- 浏览文章：《开眼角需不需要全麻？》
- 浏览视频：《双眼皮修复案例解释》
- 查看医生主页：张三（眼整形）

## 用户发言
- “上次做眼袋恢复得有点慢”
- “双眼皮有没有自然一点的方案？”
```

这是 embedding、聚类、搜索、画像的 **黄金结构**。

------

🟦 三、为什么建议最多只用两级标题（`##` 和 `###`）？

因为：

✔ embedding 模型能很好理解两级层级结构

（比如 一级类别 / 二级类别）

⚠️ 但三级以上（`####`、`#####`）

模型的注意力可能会降低，不如一级标题清晰。

#### 最不推荐的标题写法（避免）

下面这些会破坏 embedding：

❌ 英文标题（embedding 会偏移向量空间）

```
## Basic info
## Transactions
```

❌ 太技术化标题

```
## key:value data
## structured table
```

❌ 太深层级（超过三级）

```
######
```

❌ 标题不统一、随意乱写

embedding 不稳定。

### 列表

#### 最推荐的格式（你直接照做 → embedding 最稳定 + 聚类最准确）

✅ 一、顶层用 Markdown 列表

✅ 二、多条记录用“嵌套列表 / 连续列表”即可

✅ 三、最多用两级（一级/二级）即可，千万不要超过三级。

❗ 不要合并成一行，不要用表格，也不要用 key:value

示例用户消费记录（多条）👇

```
- 消费记录：
  - 项目：全切双眼皮；金额：7800 元；日期：2023-09-12
  - 项目：祛眼袋；金额：5200 元；日期：2024-01-03
  - 项目：皮肤管理；金额：398 元；日期：2024-01-28
```

为什么效果好？

- 嵌套列表结构 → embedding 模型能很好理解“多个独立事件”
- 每条事件是自然语义句子 → 聚类效果更清晰
- 不引入表格和 key:value 噪声
- 全中文 → 进入中文 embedding 空间一致性强

## 部署

```
ollama pull bge-m3
```

# LLM

**用户画像（销售记录、行为记录、聊天发言分析）** 和 **你的硬件：4090（24GB）** 来直接给你**最推荐的 LLM 方案**。

下面是“只看效果 + 性能 + 显存 + 性价比”下的**最优推荐**。

------

## 🟩 **🔥 最推荐（强烈推荐）**

### **Qwen2.5-7B (4-bit 量化)**

👉 **用户画像场景的第一选择**

为什么最推荐？

- 语义理解力非常强（比 Yi 1.5、Llama3 8B 在中文场景明显更强）
- 特别擅长：分析用户意图、行为模式、情绪推断
- 4090 上 4-bit 跑得非常快（60–90 tok/s）
- 显存只需：**6GB**
- 性价比最高

场景适配：

- 用户标签生成
- 用户兴趣总结
- 根据行为/发言做画像
- 生成推荐理由
- 异常行为分析
- 预测用户下一步动作（购买意图）

**如果你只想选一个 → 就选这个。**

------

## 🟦 **次推荐（更强一点，但更贵）**

### **Qwen2.5-14B (4-bit 量化)**

如果你希望 **更深度推理、更精细画像** → 用这个。

### 优点

- 中文能力比 7B 再上一档
- 人物画像、情绪识别、长文本总结更强
- 推理力接近 GPT-4 级别的轻量版

### 缺点

- 显存占用：**10–12GB**
- 单推速度比 7B 稍慢，但仍然能跑

### 场景适配：

- 高精度用户画像（如金融、电商、虚拟客服）
- 大段销售对话分析
- 多模态推断（如结合行为+文本）

## q4_k_m 比 q4_0 区别

```
ollama pull qwen2.5:14b-instruct-q4_K_M
```



**结论（一句话）**

**q4_k_m 比 q4_0 更强、更准、推理更稳，但显存占用更高一点。
 q4_0 更轻、更省显存，但效果稍弱一些。**

你只要记住：

👉 **要效果 → 用 q4_k_m**
 👉 **要速度/轻量 → 用 q4_0**

# 整体结构

下面我会用 **你的硬件（RTX 4090）+ 任务类型（用户画像，分析用户销售/行为/发言记录）** 为前提，给出：

1. 是否适合部署 **BGE-M3（或 BGE3）+ LLM + reranker**
2. 显存是否足够、是否会爆
3. QPS 大概能到多少
4. 推荐的最佳结构与量化方案

内容基于经验和你机器的实际硬件能力（4090 = 24GB VRAM）。

## ✅ 一、你的场景非常适合

### ✔️ 用户画像（User Profiling）

需要 embedding → 聚类 → 用户特征 → 推荐/预测 → LLM 分析总结
 你的需求非常典型。

### ✔️ 可用架构：

```
[Embedding: BGE-M3 or BGE-Large]
        ↓
[Reranker: BGE-reranker-v2 or Cohere Reranker]
        ↓
[LLM: GPT 4o mini / Qwen2.5 14B]
```

**非常适合！你完全能部署这一套架构。**

------

## ✅ 二、4090 显存能不能撑得住？

### 1. **BGE-M3（embedding）**

- FP16 大约占：**1.2–1.4GB**
- INT8 or 4-bit 量化后 → **400–800MB**

### 2. **Reranker（BGE-reranker-large / v2）**

- FP16 时大约：**2.0–2.5GB**
- INT8 后：**1.0–1.3GB**

### 3. **LLM（根据你选择）**

| 模型        | FP16显存        | 推荐量化 | 量化后显存          |
| ----------- | --------------- | -------- | ------------------- |
| Qwen2.5-7B  | ~14GB           | 4bit     | **6GB**             |
| Qwen2.5-14B | ~28GB（装不下） | 4bit     | **10–12GB**（可以） |
| Yi-1.5-9B   | ~18GB           | 4bit     | **8GB**             |

### ✔ 总显存预算（例）

以“7B LLM + BGE-M3 + reranker”为例（都量化）：

| 模块            | 显存       |
| --------------- | ---------- |
| BGE-M3 (INT8)   | ~0.7GB     |
| Reranker (INT8) | ~1.2GB     |
| 7B LLM (4bit)   | ~6GB       |
| 其他缓存        | ~1–2GB     |
| **总计**        | **9–10GB** |

### 👉 结论

**不会爆显存。4090 部署一整套：没问题。**

如果你用 14B LLM（4bit），显存会到 12-14GB，也能跑。

------

## 🚀 三、QPS 可以达到多少？（非常重要）

以下为“单卡 4090 + 24GB显存”的真实可达范围（经验值）

------

### ✅ **Embedding（BGE-M3）QPS**

- FP16：**3500–5000 QPS**（短文本）
- INT8：**6000+ QPS**

用于用户行为/发言/记录 → 非常够用

------

### ✅ **Reranker QPS（BGE-reranker-v2）**

reranker 是 pipeline 最慢的模块：

- FP16：**40–60 QPS**
- INT8：**70–90 QPS**

大多数业务 QPS 瓶颈在 reranker，不在 embedding。

------

### ✅ **LLM（7B–14B）本地推理 QPS**

按 token/s 换算：

### **7B（Qwen2.5 / Yi）**

- 生成速度：**60–90 tok/s**
- 典型对话：0.2~0.4s 响应

若你是“每条用户事件做 LLM 分析”，QPS 可达：

👉 **QPS ≈ 3–4**

### **14B（Qwen2.5 14B 4bit）**

- 生成速度：**35–50 tok/s**

👉 **QPS ≈ 2–3**

### 如果是批处理（离线构建用户画像）

- **可以到 10–20 QPS**

------

## 💡 四、真正的瓶颈在哪里？

如果你这样流程：

```
用户行为 → embedding → 前100候选 → reranker → LLM解释
```

瓶颈是：

1) reranker（70–90 QPS）

2) LLM（约 3 QPS）

因此你实际在线 QPS：

👉 **整体 end-to-end 在线 QPS ≈ 2–3（单卡 4090）**

如果你是 **批量离线构建用户画像**，那么可以：

👉 **embedding QPS 5000+**

👉 **reranker QPS 90**

👉 **LLM 可多线程跑到 10–20 QPS**



# 其他

## 分卡运行

明白，你是在 **Linux Mint 上运行 Ollama（作为系统服务 ollama.service）**，
 而不是通过两个 shell 环境去跑两个独立的 Ollama 实例。

⚠️ **重点：Ollama 是单实例服务，不支持同时以不同环境变量“开两套 Ollama 服务”。**
 所以“开两个终端分别设置环境变量”**对系统级 Ollama 服务是无效的**。

但——
 我可以教你**正确方式**让：

- **大模型（Qwen3-32B）用 GPU**
- **Embedding 模型用 CPU + 内存**

并且两者不会互相影响。

------

### **方案 A（最简单 ）—— embedding 时临时禁用 GPU（推荐生产）**

Ollama 允许你在 **每个 API 请求中指定是否使用 GPU**。

**curl 请求中加入： `"options":{"num_gpu":0}`**

👇 **Embedding 走 CPU：**

```
curl http://localhost:11434/api/embeddings \
  -d '{
    "model": "qwen3-embedding:0.6b",
    "prompt": "你好",
    "options": {
      "num_gpu": 0
    }
  }'
```

→ **这样即使 ollama 服务启用了 GPU，某个模型也可以强制走 CPU。**
 → 不需要两个 Ollama 实例，不改环境变量，不改 systemd。

------

### **方案 B —— 在 Python/Node 里指定 embedding 用 CPU**

Python：

```
import ollama

res = ollama.embeddings(
    model='qwen3-embedding:0.6b',
    prompt='hello',
    options={"num_gpu": 0}
)
```

Node：

```
const res = await ollama.embeddings({
  model: 'qwen3-embedding:0.6b',
  prompt: 'hello',
  options: { num_gpu: 0 }
})
```

------

### **方案 C —— 针对某个模型永久设置 CPU 推理（.ollama/models 中配置）**

Ollama 支持在 **模型 modelfile** 中写死强制 CPU：

创建一个 CPU-only embedding 模型：

1. 新建文件：

```
qwen3-emb-cpu.Modelfile
```

内容：

```
FROM qwen3-embedding:0.6b
PARAMETER num_gpu 0
```

1. 导入：

```
ollama create qwen3-embedding-cpu -f qwen3-emb-cpu.Modelfile
```

1. 使用：

```
ollama embeddings --model qwen3-embedding-cpu --prompt "hello"
```

→ **只影响 embedding 模型，不影响你的 32B 大模型。**



## 关闭 reasoning