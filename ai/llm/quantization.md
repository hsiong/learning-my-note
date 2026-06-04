Below is the fully rebuilt version, judging **output quality only**, not VRAM, speed, device, or price.

# Core conclusion

For a Qwen3.5-27B-class model, my quality-only ranking is:

```
BF16 / FP16
> official FP8
≈ Q8_0 / good INT8
> Q6_K / EXL2 6bpw+
> Q5_K_M / EXL2 5bpw+
≈ good AWQ 4-bit / good GPTQ 4-bit / good NVFP4
> Q4_K_M
> NF4 / bitsandbytes 4-bit for direct inference
> Q4_0 / Q3 / Q2 / bad low-bit quants
```

The most important point:

```
Bit-width alone is not enough.
“8-bit FP8” and “8-bit Q8_0” are different.
“4-bit NVFP4”, “4-bit AWQ”, “4-bit GPTQ”, “Q4_K_M”, and “NF4” are also different.
```

# My practical quality ranking

| Tier   | Format                               | Quality-only judgment                                        |
| ------ | ------------------------------------ | ------------------------------------------------------------ |
| S      | **BF16 / FP16**                      | Original/reference quality                                   |
| S-     | **official FP8**                     | Almost original quality, especially if released by the model provider |
| A+     | **Q8_0 / good INT8**                 | Near-lossless for most visible output                        |
| A      | **Q6_K / EXL2 6–8bpw**               | Very close to Q8_0, small degradation                        |
| B+     | **Q5_K_M / EXL2 ~5bpw**              | Strong practical quality, usually much better than Q4        |
| B+ / B | **good AWQ 4-bit / good GPTQ 4-bit** | Can beat generic 4-bit; calibration quality matters          |
| B      | **good NVFP4**                       | Potentially very strong, but highly recipe/hardware/checkpoint dependent |
| B-     | **Q4_K_M**                           | Usable, but degradation appears on hard tasks                |
| C+     | **NF4 / bitsandbytes 4-bit**         | Excellent for QLoRA-style fine-tuning, not my first choice for best inference quality |
| C      | **Q4_0 / Q3 / Q2**                   | Noticeable quality loss                                      |

# 1. BF16 / FP16

**BF16 / FP16 is the baseline.**

This is the closest to the original model behavior. If you only care about effect, not memory or speed, this is the standard to compare everything else against.

```
Best output quality: BF16 / FP16
```

For LLM inference, BF16 and FP16 are usually both treated as full-quality formats. BF16 has better dynamic range; FP16 has more mantissa precision. In real LLM output, the difference is usually much smaller than the difference between full precision and low-bit quantization.

# 2. Official FP8

**FP8 is 8-bit floating point**, not integer quantization.

It still has:

```
sign + exponent + mantissa
```

So FP8 keeps floating-point dynamic range better than ordinary INT8-style quantization.

For Qwen3.5-27B specifically, the official Qwen3.5-27B-FP8 model card says the model uses **fine-grained FP8 quantization with block size 128**, and that the metrics are **nearly identical to the original model**. It is intended for Transformers, vLLM, SGLang, KTransformers, and similar runtimes. 

Quality-only judgment:

```
Official FP8 ≈ BF16
```

My ranking:

```
BF16 > official FP8 > random third-party FP8
```

Why official FP8 is strong: the model provider usually quantizes with a known recipe and tests the model after quantization. A random FP8 conversion may not be equally good.

# 3. Q8_0 / INT8

**Q8_0 is 8-bit integer-style GGUF weight quantization**, commonly used in llama.cpp / Ollama / GGUF workflows.

Conceptually:

```
FP8  = 8-bit floating point
Q8_0 = 8-bit integer-ish quantized weights + scale
```

Q8_0 is usually very close to BF16/FP16 in visible output quality. For casual chat, translation, summarization, and normal coding, many users will barely notice the difference.

But Q8_0 is still a converted quantized model. The final effect depends on the converter, tensor handling, quantization version, chat template, and whether importance-matrix quantization was used. llama.cpp’s quantization docs specifically recommend using an importance matrix for quantization optimization.  Qwen’s own llama.cpp quantization guide also describes computing an importance matrix with a calibration dataset. 

Quality-only judgment:

```
Q8_0 ≈ BF16
```

But for Qwen3.5-27B, I would rank:

```
BF16 > official FP8 >= high-quality Q8_0
```

Not because Q8_0 is bad, but because official FP8 is a provider-released checkpoint with reported near-original metrics.

# 4. Q6_K

**Q6_K is the high-quality GGUF middle ground.**

It is not full 8-bit, but the output quality is often very close to Q8_0.

Quality-only judgment:

```
Q8_0 > Q6_K > Q5_K_M > Q4_K_M
```

For normal chat:

```
Q6_K ≈ Q8_0
```

For hard tasks:

```
Q8_0 > Q6_K
```

The gap appears more clearly in:

```
math
long reasoning
agent/tool calling
repository-level coding
long-context retrieval
strict JSON / structured output
```

# 5. Q5_K_M

**Q5_K_M is usually the best “still high quality” GGUF choice.**

It is clearly better than Q4_K_M and often close enough to Q6_K/Q8_0 for ordinary usage.

Quality-only judgment:

```
Q5_K_M = strong practical quality
```

Compared with Q4_K_M:

```
Q5_K_M is noticeably safer
```

Compared with Q8_0:

```
Q5_K_M is weaker on hard reasoning, coding, math, and long context
```

So if judging pure output effect:

```
Q8_0 > Q6_K > Q5_K_M > Q4_K_M
```

# 6. Q4_K_M

**Q4_K_M is usable, but the quality loss is real.**

It is much better than old/simple Q4_0, but it is still 4-bit weight quantization.

Quality-only judgment:

```
Q4_K_M = acceptable, not near-lossless
```

It is fine for:

```
normal chat
basic translation
short summaries
simple code
short-context Q&A
```

It is weaker for:

```
complex coding
multi-step math
long-context reasoning
strict instruction following
tool calling
stable JSON output
```

For Qwen-style models, I would not use Q4_K_M to judge the model’s true ability. It can make a strong model look less stable than it actually is.

# 7. AWQ

**AWQ = Activation-aware Weight Quantization.**

AWQ is usually a **4-bit weight-only** quantization method. Its main idea is that not all weights are equally important. The AWQ paper says protecting roughly **1% salient weights/channels** can significantly reduce quantization error, and those salient channels are identified from activation distributions rather than only weight values.  Hugging Face’s AWQ docs also describe AWQ as preserving a small fraction of important weights to compress models to 4-bit with minimal degradation. 

Quality-only judgment:

```
good AWQ 4-bit > naive 4-bit
good AWQ 4-bit ≈ Q4_K_M to Q5_K_M
```

AWQ can be better than Q4_K_M in some cases, especially if the calibration and runtime are good. But I would not automatically rank AWQ 4-bit above Q5_K_M or Q6_K.

My practical quality ranking:

```
Q8_0 > Q6_K > Q5_K_M ≈ good AWQ 4-bit > Q4_K_M
```

# 8. GPTQ

**GPTQ = second-order post-training quantization.**

GPTQ is also commonly used for **3-bit / 4-bit / 8-bit weight quantization**. The GPTQ paper describes it as a one-shot weight quantization method using approximate second-order information, and reports strong 3–4 bit results on large GPT-style models.  Hugging Face’s GPTQ docs also state that GPTQ uses a calibration dataset during quantization. 

Quality-only judgment:

```
good GPTQ 4-bit ≈ good AWQ 4-bit
```

Difference:

```
AWQ: more activation-aware, often robust.
GPTQ: strong if calibration data matches your target workload.
```

GPTQ can be excellent, but it can also be sensitive to calibration data. Hugging Face’s quantization selection docs explicitly note that GPTQ requires calibration and can overfit to calibration data. 

My practical ranking:

```
good GPTQ 4-bit / good AWQ 4-bit > Q4_K_M in many cases
but
Q6_K / Q8_0 / official FP8 are still safer
```

# 9. NVFP4

**NVFP4 is NVIDIA’s 4-bit floating-point format**, mainly relevant to newer NVIDIA Blackwell-era workflows.

It is not the same as Q4_K_M, AWQ, GPTQ, or NF4.

NVIDIA’s Transformer Engine docs describe NVFP4 as using hierarchical scaling: FP4 values, block-level scaling, and global scaling to handle dynamic range.  NVIDIA’s API docs describe the block scaling strategy as using groups of 16 consecutive values with an E4M3 scale factor plus a global FP32 scale. 

Quality-only judgment:

```
Good NVFP4 can be very strong for 4-bit.
Bad NVFP4 can still degrade badly.
```

The danger is that “NVFP4” by itself does not tell you the whole recipe.

You need to know:

```
Is it official?
Was it PTQ or QAT?
Were activations also quantized?
What scaling strategy?
Which runtime?
Which GPU?
Which calibration data?
```

For effect only, I would rank it like this:

```
official / well-trained NVFP4: maybe around Q5_K_M to Q6_K, sometimes better
generic NVFP4 PTQ: maybe around Q4_K_M to Q5_K_M
```

I would not blindly say:

```
NVFP4 > Q8_0
```

or:

```
NVFP4 ≈ FP8
```

Because it is still 4-bit. It can be excellent, but only with a good recipe.

# 10. NF4 / bitsandbytes 4-bit

**NF4 = NormalFloat 4-bit**, mainly famous because of QLoRA.

The QLoRA paper introduced NF4 and describes it as a 4-bit datatype designed for normally distributed weights, along with double quantization and paged optimizers. 

Important distinction:

```
NF4 is excellent for QLoRA fine-tuning.
NF4 is not automatically the best inference quantization.
```

For pure inference output quality, I usually prefer:

```
Q5_K_M / Q4_K_M / AWQ / GPTQ / EXL2
```

over generic bitsandbytes NF4 inference.

Quality-only judgment:

```
NF4 is useful, but I would not rank it above good AWQ/GPTQ/Q5_K_M for inference.
```

# 11. EXL2

**EXL2 is ExLlamaV2’s flexible quantization format.**

ExLlamaV2 documentation says EXL2 is based on GPTQ-style optimization and supports mixed quantization levels from **2 to 8 bits per weight**, allowing arbitrary average bitrates. 

This makes EXL2 hard to rank by name alone.

You must specify the bitrate:

```
EXL2 8bpw ≈ Q8_0 / high quality
EXL2 6bpw ≈ Q6_K
EXL2 5bpw ≈ Q5_K_M
EXL2 4bpw ≈ good GPTQ/AWQ/Q4_K_M range
EXL2 <4bpw = increasingly risky
```

Quality-only judgment:

```
EXL2 quality depends on bpw.
```

So “EXL2” alone is not enough information.

# 12. Final unified quality ranking

For Qwen3.5-27B-class models, assuming good conversions and correct chat template:

```
1. BF16 / FP16
2. Official FP8
3. Q8_0 / high-quality INT8
4. Q6_K / EXL2 6–8bpw
5. Q5_K_M / EXL2 ~5bpw
6. Good AWQ 4-bit / good GPTQ 4-bit / good NVFP4
7. Q4_K_M
8. NF4 / bitsandbytes 4-bit inference
9. Q4_0
10. Q3 / Q2 / ultra-low-bit quants
```

# The simplest answer

```
Best effect:
BF16 / FP16
Best near-original quant:
official FP8
Best GGUF effect:
Q8_0
Best practical GGUF quality:
Q6_K or Q5_K_M
Minimum acceptable GGUF:
Q4_K_M
Best 4-bit algorithmic quant:
good AWQ / good GPTQ / good EXL2 4–5bpw / good NVFP4
```

# My final recommendation by use case

| Goal                                   | Pick                  |
| -------------------------------------- | --------------------- |
| Judge the model’s true ability         | **BF16 / FP16**       |
| Almost no quality loss, modern serving | **official FP8**      |
| Best GGUF quality                      | **Q8_0**              |
| Very high GGUF quality                 | **Q6_K**              |
| Good balance but still strong          | **Q5_K_M**            |
| 4-bit with smarter calibration         | **AWQ / GPTQ / EXL2** |
| 4-bit GGUF fallback                    | **Q4_K_M**            |
| Fine-tuning with LoRA                  | **NF4 / QLoRA**       |
| Avoid if quality matters               | **Q4_0 / Q3 / Q2**    |

Final one-line ranking:

```
BF16 > official FP8 > Q8_0 > Q6_K > Q5_K_M ≈ good AWQ/GPTQ/NVFP4/EXL2 5bpw > Q4_K_M > NF4 inference > Q4_0
```