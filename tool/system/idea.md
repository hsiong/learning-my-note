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