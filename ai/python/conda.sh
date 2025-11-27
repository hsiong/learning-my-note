# 安装 anaconda
下载对应版本, 安装, 注意不要勾选覆盖 PATH

否则报错
```
conda create --name env python=3.10.13
conda activate env
python --version

python版本还是 3.11.5
```

# 初始化 conda

conda init

## Windows 安装了 anaconda, 但是找不到 conda 命令 

```
打开环境变量编辑器（在搜索栏中输入“环境变量”可以找到），然后在“系统变量”或“用户变量”中找到 PATH 变量并编辑，添加 Anaconda 的安装路径，
C:\Users\<你的用户名>\Anaconda3
C:\Users\<你的用户名>\Anaconda3\Scripts
C:\Users\<你的用户名>\Anaconda3\Library\bin
```

# 指定 conda 环境

conda create --name env python=3.10.13
conda info -e
conda activate env
python --version

## python版本还是 3.11.5

+ 查看激活的环境
这将列出所有可用的 conda 环境。确保你的环境 env 显示一个星号(*)，表示它是当前激活的环境。
conda info --envs

## 一些报错

> conda-script.py: error: argument COMMAND: invalid choice: 'activate' (choose from 'clean', 'compare', 'config', 'create', 'info', 'init', 'install', 'list', 'notices', 'package', 'remove', 'uninstall', 'rename', 'run', 'search', 'update', 'upgrade', 'build', 'content-trust', 'convert', 'debug', 'develop', 'doctor', 'index', 'inspect', 'metapackage', 'render', 'skeleton', 'verify', 'token', 'repo', 'pack', 'env', 'server')
执行 conda init


