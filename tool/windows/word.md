
# shortcuts
new line in cell                option+enter

# wildCards - office
***Reference*** https://blog.csdn.net/xufox/article/details/80264996
+ 把  .数字中文  改为 .数字 中文
\.([0-9]{1,100})([!^1-^127])
.\1 \2

# wildCards - wps
https://www.cnblogs.com/yingyingdeyueer/p/11573510.html
not support ^1
\.([0-9]{1,100})
.\1

# excel wps怎么批量去除左上角标志

Customize -> Error Checking -> Unclick Number stored as text

# change default font(修改主题字体)
page layout -> themes -> change theme font


# wps 快速选定可看区域

## 1
+ Ctrl + Home 回到开头；
+ 按 Ctrl + shift + End，光标复制到到最后一个有内容的单元格；


## 2
Ctrl + Shift + 箭头键：从当前单元格开始，选定到最后一个非空单元格。

## 有筛选
用“定位条件”选可见单元格（100% 通用）

先选好要处理的区域 → 按 F5 或 Ctrl + G → 点【定位条件】 → 选 “可见单元格” → 确定。

这一步完成后再 Ctrl + C 复制，就只会复制可见部分。


