# llm
+ https://github.com/hsiong/project-LLM

# modelsArt
+ https://github.com/hsiong/project-modelarts.git
+ 基于MindSpore的ChatGLM微调原创: https://github.com/mindspore-lab/mindformers/blob/master/docs/model_cards/glm.md

# transformer
+ https://zhuanlan.zhihu.com/p/82312421

# tts
+ suno: https://app.suno.ai/create/
+ bark: https://github.com/suno-ai/bark
+ suno教程:
  + https://juejin.cn/post/7330569482790584357

## glm
+ ChatGLM调教指南: https://mindformers.readthedocs.io/zh-cn/latest/docs/model_cards/glm.html

# object-detect
## 病虫害
+ 作物病虫害识别数据集资源合集: https://zhuanlan.zhihu.com/p/451142782
+ 基于YOLOv8/YOLOv7/YOLOv6/YOLOv5的花卉检测与识别系统（附完整资源+PySide6界面+训练代码） : https://www.cnblogs.com/sixuwuxian/p/18034953
+ 基于YOLOv8/YOLOv7/YOLOv6/YOLOv5的植物叶片病害识别系统（Python+PySide6界面+训练代码） : https://www.cnblogs.com/sixuwuxian/p/18043554
+ 基于YOLOv8/YOLOv7/YOLOv6/YOLOv5的植物病害检测系统（Python+PySide6界面+训练代码） :
+ https://www.cnblogs.com/sixuwuxian/p/18043205
+ 基于改进残差网络的农作物病害识别系统: https://www.hanspub.org/journal/PaperInformation?paperID=42747
+ 农业病虫害数据集与算法——调研整理: https://www.dtstack.com/bbs/article/6063


# sam
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

+ 