

## Pycharm

### 快捷键

+ pycharm 不会自动 auto-import, 所以需要使用下列三个快捷键之一
  + Reformat Code: ctrl_cmd_l
  + Reformat File: shift_ctrl_cmd_l
  + Optimize Import: ctrl_alt_cmd_o 
+ Unclick PEB 8 coding style violation           
+ mint 有很多键位与pycharm冲突

#### macos

/Users/vjf/Library/Application\ Support/JetBrains/PyCharmxxx/keymaps/xxx.xml

```
  <action id="NewDir">
    <keyboard-shortcut first-keystroke="shift ctrl meta n" />
  </action>
  <action id="NewElement">
    <keyboard-shortcut first-keystroke="ctrl enter" />
  </action>
  <action id="NewFile">
    <keyboard-shortcut first-keystroke="ctrl n" />
  </action>
  <action id="NewPythonFile">
    <keyboard-shortcut first-keystroke="meta n" />
  </action>
  <action id="NewPythonPackage">
    <keyboard-shortcut first-keystroke="ctrl meta n" />
  </action>
```

#### Linux

~/.config/JetBrains/PyCharm<Version>/keymaps/xxx.xml

```
  <action id="NewPythonFile">
    <keyboard-shortcut first-keystroke="ctrl n" />
  </action>
  <action id="NewFile">
    <keyboard-shortcut first-keystroke="alt n" />
  </action>
  <action id="NewPythonPackage">
    <keyboard-shortcut first-keystroke="ctrl alt n" />
  </action>
  <action id="NewDir">
    <keyboard-shortcut first-keystroke="shift ctrl alt n" />
  </action>

```

#### windows

C:\Users\lenovo\AppData\Roaming\JetBrains\PyCharm2023.2\keymaps\xxx.xml

```
	<action id="NewDir">
    <keyboard-shortcut first-keystroke="shift ctrl alt n" />
  </action>
  <action id="NewFile">
    <keyboard-shortcut first-keystroke="alt n" />
  </action>
  <action id="NewPythonFile">
    <keyboard-shortcut first-keystroke="ctrl n" />
  </action>
  <action id="NewPythonPackage">
    <keyboard-shortcut first-keystroke="ctrl alt n" />
  </action>
```

### pycharm 回车不会缩进

Editor => Code Style => Python => `Keep indents on empty lines`

### pycharm 复制保持空格

Editor => smart keys => click smart indent pasted lines

### Action on save
+ Reformat code
+ Optimize import



### pycharm the file in the editor is not runnable

pycharm 没有识别 python 文件: https://blog.csdn.net/yxb_xb/article/details/118554048
Editor -> File Types -> Python -> add `*.py`

### pycharm-codeium异常 代码提示

+ version 采用 1.8.0
+ 中文乱码, 修改 Color Scheme Font - Font -> Microsoft Yahei UI
+ 提示过慢: click detect proxy
+ popup->5ms
+ disalbe `Enable chat inlay hints`
+ disalbe `show selection toolbar`

 > Match case > All letters

### pycharm 应用设置 proxy

> 在运行配置中设置环境变量

1. **打开 PyCharm**。

2. 打开运行配置：

   - 点击右上角的运行/调试配置下拉菜单，选择 "Edit Configurations"。

3. **选择你的运行配置**，或者新建一个配置。

4. 设置代理环境变量：

   - 在 "Environment Variables" 中，添加以下内容：

     ```
     HTTP_PROXY=http://username:password@proxy_host:proxy_port
     HTTPS_PROXY=http://username:password@proxy_host:proxy_port
     ```

     示例：

     ```
     HTTP_PROXY=http://user:pass@127.0.0.1:8080
     HTTPS_PROXY=http://user:pass@127.0.0.1:8080
     ```

### pycharm the file in the editor is not runnable

转到 Project: 你的项目名 > Project Interpreter。

### from openai_exec import *  与 import openai_exec 有什么区别

第一个pycharm可以自动提示, 使用第一个

### pycharm format

unclick Keep when reformatting -> Line breaks

### hide code author

 Inlay Hints -> unclick Code Author

### 生成返回值对象快捷键(实现类似java var的效果)

在编写一行JAVA语句时，有返回值的方法已经决定了返回对象的类型和泛型类型，我们只需要给这个对象起个名字就行。

如果使用快捷键生成这个返回值，我们就可以减少不必要的打字和思考，专注于过程的实现。

步骤：

1、把光标移动到需要生成返回值变量的语句之前，或者之后。

2、右键选择依次点击  Refactor-------------》Extract-------》Variable，也可以按快捷键ctrl+alt+v

3、生成以后一般需要你自己起一个名字，默认给的名字总是不太合适的

### Get from vcs

Menu -> Git -> Clone


### requirements.txt

+ Tools -> Python Integrated Tools -> Packaging: requirements.txt
+ 或者手动: pip install -r requirements.txt

### 取消代理

select `Help -> Edit Custom VM Options` add below:

```shell
-Dhttp.proxyHost
-Dhttp.proxyPort
-Dhttps.proxyHost
-Dhttps.proxyPort
-DsocksProxyHost
-DsocksProxyPort
```

> 注意: ⭐️⭐️⭐️ 
>
> terminal 执行的 python 进程, 包括 flask 、request 等操作, 都会收到代理的影响, 所以最优解是将远程地址加入代理配置



### git local changes

+ unclick `Commit` -> `Use non-modal commit interface`
+ plugin `Modal commit Interface`



### inspections

+ unclick `Incorrect call arguments`

### 插件

+ Material Theme UI -> Cpu usage High -> 
  + Solarized Light Chandrian
  + Michel's Solarized LightX
+ Atom Material Icons
+ Codeium
+ Indent Rainbow
+ Rainbow Brackets

> Indent Rainbow: Unclick `Do NOT rainbowify files with more than ... lines`
>
> codeium: Unclick `Chat Inlay Hints`



### flask 启动报错

如果其他应用程序已经占用了 5000 端口，那么在启动服务的时候会看到 `OSError: [Errno 98]` 或者 `OSError: [WinError 10013]` 出错信息。 如何处理这个问题，请参阅 [地址已被占用](https://dormousehole.readthedocs.io/en/latest/server.html#address-already-in-use) 。

> 注意: 
>
> + 在 pycharm 中运行: 
>   + add Flask Server
>   + Script path: `dir/__init__.py`



## 我想问在pycharm中 pytest 打断点, 为什么不能实时输出 printf
+ 打开 PyCharm 的运行配置（Run > Edit Configurations）。
+ 选择你的 pytest 配置。
+ 在 Additional Arguments 字段中添加 -s。

## color
+ 其他文件颜色不对
  change `File Color` - non-project-Files
  
+ main menu
  
  打开 **Settings / Preferences**
  
  - 快捷键：`Ctrl + Alt + S`
  
  在左侧导航栏中进入
   **Appearance & Behavior → Appearance**
  
  找到右侧的区域：
   ✅ **Main menu:**  **“Show main menu in a separate toolbar”**
  
+ unclick `Use project color in main toolbar`


## Field injection is not recommended

unclick `Non-recommended field injections`

## 关闭提示  Inferred annotations available. Full signature:

打开设置：**File | Settings…（或 Ctrl+Alt+S）**

进入：**Editor | General | Gutter Icons**

在列表里找类似：

- `Inferred annotations`
- 或带小 `@` 的条目（和注解相关） `inferred nullability annotation`

把这项前面的勾去掉 → Apply

## ✅ 禁用控制台日志折叠的步骤

找 `Editor` → `General` → 下面有 **`Console`** 和 **`Code Folding`** 两块

在 `Code Folding` 或 `Console` 里，找类似：

- `Fold stack trace lines`
- 或者 `Fold builder-like methods` / `折叠堆栈行` 一类选项

把它 **取消勾选**，应用 / 确认

## save password

一、先搞清楚：IDEA 是用什么来保存密码的？

在 IntelliJ IDEA 里：

1. 打开：`File` → `Settings` → `Appearance & Behavior` → `System Settings` → `Passwords`
2. 看看这里选的是哪一个：
   - **In native Keychain / KeePass / Memory** 之类

**建议设置：**

- 如果你用的是 Linux Mint，一般推荐：
  - **In native Keychain**（使用系统的 GNOME Keyring / Secret Service）
  - 或者 **KeePass**（IDEA 自己用一个本地加密数据库保存）

如果你现在选的是 **“In memory only”**，那就会导致：

> 每次重启电脑，所有密码都丢失 —— 这就完全符合你说的现象。

## 勾选当前文件

Project -> Behavior -> Always Select Opened File

## 快速找错 error

**方法二：使用 Code → Inspect Code（全项目检查）**

如果你想让 PyCharm **重新扫描整个项目**，可以这样：

 **步骤：**

1. 打开菜单 **Code → Inspect Code…**
2. 选择检查范围（一般选 *Whole Project*）
3. 点击 Run

你会得到一个完整报告，列出所有错误、警告和改进建议。

## 打印方法名

直接 cv 方法

## pytest: no tests were found
所有依赖的方式不能有 `main`

## pytest-实时输出
使用 `-s` 可以关闭输出捕获，让所有 print/log 立即显示。

## database - open
`Open results in new tab`

## select opened file 
1. 方法1: `Behavior` -> unclick `Always Select Opened File` , 手动点
2. 方法2: `Behavior` -> click `Always Select Opened File`, 点 tab

## rename 不改变引用
+ click `Search for references` and `Search in comments and strings`

# pycharm run/debug  运行保留之前的结果  而不是替换当前窗口
> pin tab 即可


# pycharm 滚动条不展示报错
> 换 theme 即可
￼

# Reformat on paste 关闭“粘贴时自动格式化”
Editor → General → Smart Keys -> Python → Reformat on paste => None
注意: 全局不管用
￼
