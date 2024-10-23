# llm
+ https://github.com/hsiong/project-LLM

## transformer

+ https://zhuanlan.zhihu.com/p/82312421

# digital human 数字人

+ https://github.com/hsiong/project-LLM

# modelsArt
+ https://github.com/hsiong/project-modelarts.git
+ 基于MindSpore的ChatGLM微调原创: https://github.com/mindspore-lab/mindformers/blob/master/docs/model_cards/glm.md


# tts
+ suno: https://app.suno.ai/create/
+ bark: https://github.com/suno-ai/bark
+ suno教程:
  + https://juejin.cn/post/7330569482790584357

# onnx

## onnx 调优

### **使用TensorRT**

TensorRT是NVIDIA开发的一个高效的深度学习推理加速器，它专门为GPU优化，特别是在需要高吞吐量和低延迟的应用中。TensorRT可以显著提高模型在GPU上的推理速度。

**步骤：**

- 将ONNX模型转换为TensorRT格式，可以使用`onnx-tensorrt`工具。
- 在推理时使用TensorRT优化后的模型。

**示例：**

```
bash


Copy code
# 安装 onnx-tensorrt
pip install onnx-tensorrt
```

然后在Python中：

```

import onnx
import tensorrt as trt

onnx_model_path = "model.onnx"
trt_engine_path = "model_trt.engine"

# 创建TensorRT构建器
TRT_LOGGER = trt.Logger(trt.Logger.WARNING)
builder = trt.Builder(TRT_LOGGER)
network = builder.create_network()
parser = trt.OnnxParser(network, TRT_LOGGER)

# 读取ONNX模型
with open(onnx_model_path, "rb") as f:
    parser.parse(f.read())

# 编译为TensorRT引擎
engine = builder.build_cuda_engine(network)

# 保存TensorRT引擎
with open(trt_engine_path, "wb") as f:
    f.write(engine.serialize())
```

### **批处理（Batch Inference）**

批处理可以显著提高推理效率。通过将多张图片输入模型一次性进行推理，而不是逐张处理，可以充分利用GPU的并行处理能力。

**改进：**

- 将单张图片处理改为多张图片的批量处理，将图片堆叠成一个批次，并传入模型进行一次性推理。
- 这样GPU资源可以更好地利用，减少了推理过程中初始化和数据传输的开销。

**示例：**

```

def batch_inference(images, model, batch_size=16):
    batches = [images[i:i+batch_size] for i in range(0, len(images), batch_size)]
    results = []
    for batch in batches:
        batch = torch.stack(batch)  # 将图片堆叠为批次
        output = model(batch.to("cuda"))
        results.append(output)
    return results
```

###  **混合精度推理（Mixed Precision Inference）**

混合精度推理是指在推理过程中同时使用`FP32`（32位浮点）和`FP16`（16位浮点）数据类型，这可以显著加速推理过程，尤其是在NVIDIA的Volta、Turing和Ampere架构的GPU上。

**方法：**

- 使用`torch.cuda.amp.autocast()`在PyTorch中启用混合精度推理，或者通过TensorRT自动支持混合精度。

**示例：**

```

with torch.cuda.amp.autocast():
    output = model(input_tensor.to("cuda"))
```

###  **量化（Quantization）**

量化是将模型中的浮点数（FP32）权重和激活值转换为更低精度（例如`int8`或`int16`）的表示形式，从而加快推理速度并减少模型大小。

**方法：**

- 使用PyTorch的量化工具，或者在导出ONNX模型时直接支持量化。ONNX Runtime也支持量化推理。

**PyTorch量化示例：**

```

import torch.quantization

model_fp32 = load_model()  # 加载你的模型
model_fp32.eval()

# 使用动态量化
model_int8 = torch.quantization.quantize_dynamic(model_fp32, {torch.nn.Linear}, dtype=torch.qint8)

# 量化后的推理
output = model_int8(input_tensor)
```

###  **分布式推理（Distributed Inference）**

如果你有多块GPU或者多台机器，可以利用分布式推理来提升速度。你可以将推理任务分配到多块GPU上，这样可以有效减少单个GPU的负载。

**方法：**

- 使用`torch.distributed`库或`Horovod`等工具，将推理任务分布到多个GPU上执行。
- 可以将图片批次分割，并分配给多个GPU来并行执行推理。

**PyTorch分布式推理示例：**

```

import torch.distributed as dist

dist.init_process_group(backend="nccl")  # 使用 NCCL 后端
model = torch.nn.parallel.DistributedDataParallel(model)
```

### **模型剪枝（Model Pruning）**

模型剪枝是指删除模型中对最终结果影响不大的权重或神经元，从而减少模型的计算量，提高推理速度。

**方法：**

- 你可以使用PyTorch的`torch.nn.utils.prune`来实现模型的剪枝，特别是当你的模型非常大时，剪枝可以显著提高推理速度。

**示例：**

```

import torch.nn.utils.prune as prune

# 对线性层进行剪枝
prune.l1_unstructured(model.fc, name='weight', amount=0.4)  # 剪去40%的权重
```

### **模型压缩**

模型压缩可以通过减少模型的参数和层数来提高推理速度。可以使用知识蒸馏（Knowledge Distillation）技术，将大模型的知识传递到小模型上，保持精度的同时减少计算开销。

**方法：**

- 利用知识蒸馏技术，训练一个小模型来模仿大模型的行为，从而加快推理速度。

###  **异步推理（Asynchronous Inference）**



使用异步推理技术可以让推理和其他处理步骤（例如图像预处理或I/O操作）并行进行，避免等待推理完成后再开始处理其他步骤。

**方法：**

- 通过将推理操作放入异步线程或任务队列，能够同时进行多项任务，减少整体的等待时间。

### **基于FPGA或其他专用硬件加速**

如果你对速度要求特别高，且有定制硬件支持，可以考虑使用FPGA或其他专用推理加速器（如Google的TPU）。这些硬件专为深度学习推理设计，可以显著提高性能。

### **优化ONNX模型**

在导出ONNX模型时，可能会有一些未优化的计算操作，这些操作会影响推理速度。你可以尝试以下方法优化模型：

- **使用ONNX优化工具**：ONNX提供了一个优化工具`onnxruntime-tools`，你可以使用它来优化模型结构。通过优化图形，减少不必要的操作可以提高推理速度。
- **导出时设置优化选项**：在导出ONNX模型时，可以尝试打开某些优化标志，例如`opset_version`，或者确保所有运算都支持GPU加速。

示例命令：

```

import onnx
from onnxruntime_tools import optimizer

optimized_model = optimizer.optimize_model('path_to_your_model.onnx', model_type='bert')
optimized_model.save_model_to_file('optimized_model.onnx')
```

### **检查ONNX推理会话的设置**

你在推理过程中使用了ONNX的`CUDAExecutionProvider`，这通常能够显著加速推理过程。不过，还可以通过调整ONNX运行时的推理会话来进一步优化：

- **启用图优化级别**：在创建推理会话时，确保你使用了高级别的图优化，如`ORT_ENABLE_ALL`，以确保模型中可以被优化的部分都进行了优化。
- **检查GPU内存是否充足**：如果GPU内存不足，推理速度可能会大大降低。你可以通过减少批次大小或者图像尺寸来减轻GPU内存压力。

示例：

```

session_options = ort.SessionOptions()
session_options.graph_optimization_level = ort.GraphOptimizationLevel.ORT_ENABLE_ALL
ort_session = ort.InferenceSession(onnx_model_path, session_options, providers=['CUDAExecutionProvider'])
```

###  **减少图像的预处理时间**

你在预处理图像时可能会遇到瓶颈。检查图像加载和转换的时间是否过长，尤其是`torchvision.transforms`部分。你可以在推理前对图像进行一次性预处理并缓存预处理后的结果。

- **减少图像尺寸**：将图像尺寸调整为模型可以处理的较小的尺寸可以显著加快推理速度。如果你当前的图像是800x1200，你可以尝试进一步缩小图像尺寸。

### **避免频繁的I/O操作**

如果你每次推理都从磁盘读取图像（尤其是高分辨率图像），I/O操作也可能是瓶颈。将图像加载到内存中或使用批量处理的方法可以减少频繁的磁盘I/O，从而提高推理速度。

###  **检查CPU与GPU之间的数据传输**

如果推理过程中涉及频繁的CPU与GPU之间的数据传输，会大大降低效率。确保你的数据在GPU上是连续的（通过`contiguous()`方法），并避免不必要的数据在CPU与GPU之间来回传递。

### **ONNX模型的精度调整**

如果模型不要求非常高的精度，你可以尝试使用`浮点16（FP16）`来代替`浮点32（FP32）`，这可以减少计算量并提升推理速度，特别是在GPU上。

### **优化推理管道**

可以通过批量处理（batch processing）来提升推理速度，尤其是在同时处理多个图像时。

###  **确保CUDA和cuDNN版本兼容**

如果你的CUDA、cuDNN或PyTorch版本之间存在不兼容问题，可能会导致GPU性能没有充分发挥。确保你的CUDA版本与PyTorch和ONNX运行时兼容。

# object-detect
## 病虫害
+ 作物病虫害识别数据集资源合集: https://zhuanlan.zhihu.com/p/451142782
+ 基于YOLOv8/YOLOv7/YOLOv6/YOLOv5的花卉检测与识别系统（附完整资源+PySide6界面+训练代码） : https://www.cnblogs.com/sixuwuxian/p/18034953
+ 基于YOLOv8/YOLOv7/YOLOv6/YOLOv5的植物叶片病害识别系统（Python+PySide6界面+训练代码） : https://www.cnblogs.com/sixuwuxian/p/18043554
+ 基于YOLOv8/YOLOv7/YOLOv6/YOLOv5的植物病害检测系统（Python+PySide6界面+训练代码） :
+ https://www.cnblogs.com/sixuwuxian/p/18043205
+ 基于改进残差网络的农作物病害识别系统: https://www.hanspub.org/journal/PaperInformation?paperID=42747
+ 农业病虫害数据集与算法——调研整理: https://www.dtstack.com/bbs/article/6063


# SAM
+ efficient-sam: https://github.com/yformer/EfficientSAM

# CUDA

## 如何看本机cuda

### **通过命令行检查 CUDA 版本**

1. **打开命令提示符（CMD）**：

   - 使用快捷键 `Win + R` 打开“运行”窗口，输入 `cmd`，然后按回车。

2. **运行命令检查 CUDA 版本**：

   - 输入以下命令检查 `nvcc`（CUDA 编译器驱动）的版本：

   ```
   nvcc --version
   ```

   这将输出 CUDA 编译器驱动的版本号。例如：

   ```
   nvcc: NVIDIA (R) Cuda compiler driver
   Copyright (c) 2005-2021 NVIDIA Corporation
   Built on Thu_Jan_28_19:32:12_Pacific_Standard_Time_2021
   Cuda compilation tools, release 11.2, V11.2.152
   ```

   上面的输出显示，CUDA 版本为 `11.2`。

3. **检查 CUDA 库文件版本**：

   - 输入以下命令，检查驱动支持的 CUDA 版本：

   ```
   nvidia-smi
   ```

   这会输出类似于以下的内容：

   ```
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 455.45.01    Driver Version: 455.45.01    CUDA Version: 11.1     |
   +-----------------------------------------------------------------------------+
   ```

   输出结果中的 `CUDA Version` 即为安装的 CUDA 版本号。

### **通过检查已安装的 CUDA 工具包**

#### Windows

1. **打开文件资源管理器**。

2. 导航到 CUDA 安装目录

   （默认路径）：

   - 通常安装在 `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\` 下。

3. 查看文件夹名称：

   - 在该目录下，你会看到以版本号命名的文件夹（如 `v10.1`、`v11.0` 等），这就是已安装的 CUDA 版本。

#### Linux

你可以通过查看 CUDA 工具包的安装目录来找到安装的版本号。

1. 通常，CUDA 安装在 `/usr/local/cuda` 目录下。如果该目录存在，你可以查看版本文件：

   ```
   cat /usr/local/cuda/version.txt
   ```

   示例输出：

   ```
   CUDA Version 11.2.67
   ```

   这会显示已安装的 CUDA 工具包的版本。

2. 你也可以列出 `/usr/local` 目录下的文件夹名，其中会显示以 `cuda-<version>` 命名的文件夹：

   ```
   ls /usr/local/ | grep cuda
   ```

   示例输出：

   ```
   cuda-10.1
   cuda-11.2
   ```

   这表明系统中安装了多个 CUDA 版本，你可以根据需求选择其中一个版本。

## CUDA 兼容性

+ 手动安装 cuda 11.8

+ python 3.12 

+ cuda nvidia capability: https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#
  `Table 3 CUDA Toolkit and Corresponding Driver Versions`

+ cuda pytorch capability: https://elenacliu-pytorch-cuda-driver.streamlit.app/

+ download pytorch: https://download.pytorch.org/whl/torch/

+ pytorch torchvision capability: https://pytorch.org/get-started/previous-versions/

+ python numpy capability: https://github.com/numpy/numpy/releases

  > v1 newest version: 1.26.4: The Python versions supported by this release are 3.9-3.12



# Mac

## Torch

````
```
python --version
pip uninstall torchvision torchaudio
pip install torch==2.3.1 torchvision==0.18.1 torchaudio==2.3.1

pip uninstall numpy
pip install numpy==1.26.4 # 模型使用的老版本 numpy

pip install -r requirements-mac.txt # pip install -e .
```
````

## Onnx

```python
if system == "Darwin":  # macOS (M1/M1 Pro)
    providers = ['CoreMLExecutionProvider', 'CPUExecutionProvider']
```



