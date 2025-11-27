## idea 2021.2及以后设置全局搜索结果不限制为100 原创
https://blog.51cto.com/u_15344989/4762223

advanced setting -> Maximum number of results to show in Find in Path/Show Usages preview: 100 -> 10000

## Code Completion
https://www.cnblogs.com/javastack/p/11230120.html

# Jrebel

## Jrebel 4.2 
https://blog.csdn.net/totoropcbeta/article/details/128225587

## JRebel:Cannot reactivate, offline seat in use.
https://blog.csdn.net/u013066244/article/details/102895342
```
rm -rf ~/.jrebel
```

## Jrebel Startup Guide
update to Jrebel 4.2

# Intellij

## edit code - color

Editor -> Color Schme -> General/Language Default/Java/Java Addition
+ General 
  + Hyperlink
  + Unused code
  + TODO defaults
+ Language Default 
  + Classes
  + Interface name
  + Reassigned parameter (parameter in function)
  + Inline hints
+ Java 
  + Annotation name
  + Constant
  + Instance field
  + Instance final field
  + static filed 
  + Abstract class = Anonymous class = Class = Constructor call
  + Interface = Enum
  + Block comment = Line comment
  + JavaDoc
    + Tag 
    + Tag value
    + Text
  + key word
  + Constructor declaration = Method declaration
  + Inherited method = Method call = Static imported method call
  + Parameter != Reassigned parameter != Local variable
  + Local variable = Reassigned local variable
  + unclick Semantic highlighting
  + String text
  + Invaild 
  + Valid
+ Java Addtion
  + super, this
  + null, true, false


## idea 识别不出未使用的代码

在开发环境中，如IntelliJ IDEA，通常会有一些代码检查和优化的功能，其中包括检测未使用的代码。IDEA默认是开启这些检查的，但有时由于配置或其他原因，IDEA可能无法正确识别未使用的代码。

以下是一些常见的原因和解决方法，以确保IDEA能够正确识别未使用的代码：

确认代码检查设置：在IDEA中，打开Settings（或Preferences，取决于操作系统），然后选择Editor -> Inspections。确保 "Unused declaration" （未使用的声明） 这一项被选中。

确认项目编译：未使用的代码只能在编译后被正确识别。在IDEA中，确保你的项目是正确编译的。你可以尝试重新编译项目，或者使用"Build"菜单中的"Rebuild Project"选项。

检查文件类型：有时，未使用的代码在一些特定类型的文件中可能无法被正确识别。例如，在HTML或模板文件中，未使用的代码可能被误报。你可以在Inspections设置中排除特定类型的文件，以避免误报。

检查代码所在的代码块：有时，IDEA可能无法准确地确定代码是否未使用，特别是在复杂的代码块中。你可以尝试调整代码块的结构，或者使用IDEA的"Analyze"菜单中的"Inspect Code"选项来重新检查代码。

使用"Optimize Imports"：如果你的项目中有未使用的导入语句，IDEA的"Optimize Imports"功能可以帮助你自动移除未使用的导入。你可以通过按下Ctrl + Alt + O（Windows/Linux）或Cmd + Option + O（Mac）来调用该功能。

## IDEA 关闭/开启引用提示Usages
https://blog.csdn.net/Logicr/article/details/124957505

## IDEA 优化 .var 提示
> Postfix Completion -> var, 并且禁用 val varl 等

## .var 禁用 final
.var 之后, 取消勾选 declare final, 就不会生成 final 关键字了
![Screenshot 2023-12-11 at 15 27 25](https://github.com/hsiong/learning-my-note/assets/37357447/26912836-5c4f-4152-9d2a-9f644394b0f2)

## idea 如何 自定义 Postfix Completion

1. **创建自定义补全**：在“Postfix Completion”页面，你会看到一个列表，显示了所有可用的后缀补全模板。点击列表下方的 `+` 按钮来创建一个新的模板。
2. **配置模板**：在创建新模板的对话框中，你需要填写几个字段：
   - **Key**：这是触发模板的后缀。例如，如果你创建一个用于打印变量值的模板，你可以使用 `print` 作为 Key。
   - **Description**：这是模板的描述，帮助你记住这个模板的用途。
   - **Applicable in**：选择模板适用的上下文，例如 Java 方法体内。
   - **Template text**：这是模板的主体。你需要使用 `$EXPR$` 代表原始表达式，`$END$` 指定光标最终的停留位置。如果你的模板是用来打印变量值，模板文本可能类似于 `System.out.println($EXPR$);$END$`。



## 关闭 coverage
搜索 coverage -> close

## IDEA中Ctrl+Shift+F快捷键被占用 - windows
https://www.jianshu.com/p/bdd0c27810ed

windows 自带输入法, 默认开启了简繁切换热键

## 新版本IDEA，在XML文件中没有SQL关键字提示 
https://youtrack.jetbrains.com/issue/IDEA-320526
禁用了相关插件的问题, 初步判定为禁用了 spring web 和 persistence framework 插件导致的

## IDEA sql 不提示表
检查数据库端口和地址

## FastRequest 关闭升级提示
在插件内, 关闭升级提示

## Android studio 字体很奇怪
Editor -> Color Scheme -> Color Scheme Font
Font: JetBrains Mono
Size: 13.0
Line height: 1.6

## 关闭二级菜单
New UI -> Click Show main menu in a separate toolbar

## idea - 破
https://jetbra.in/s

-javaagent:/Path/ja-netfilter.jar=jetbrains
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED

## idea-显示git栏
unclick `Commit` -> `Use non-modal commit interface`

## 选择 jdk 版本
project -> sdk

+ Restful Fast Request - API Buddy 2023.1.7.1
https://plugins.jetbrains.com/plugin/16988-restful-fast-request--api-buddy/versions/stable/358589

## shortcut

+ Plugin -> Java -> Java Class `ctrl+N`
+ File -> ... -> New -> Create New Directory or Pachage `alt+N`

## 个性化
### Code Completion Color
进：Editor → Color Scheme → General → Popups and Hints → Completion

### Test-package-color
用 File Colors（推荐）

打开 Settings (Preferences) → Appearance & Behavior → File Colors

在右侧点 +，新建规则，选择 All 或者新建一个 Scope 只包含 test 包

设置背景色，并勾选 Use in Project View

这样 Project 栏对应的目录背景会被你自定义颜色覆盖

不受 Theme 限制，可以精确指定颜色

这里就能改补全列表里普通项（前景/背景）、当前选中项（Selection 前景/背景）、以及匹配文本（Matched text）的颜色与效果（粗体、下划线等）。

### 

### idea

idea 2023.2.6  main menu -> file -> file open actions -> open projec actions -> new -> file

### pycharm
详见 pycharm.md