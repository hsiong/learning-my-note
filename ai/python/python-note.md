
# python 基础

## 命名
以下划线开头的标识符是有特殊意义的。
+ 大写命名: 认为常量
+ 以单下划线开头 `_foo` 的代表不能直接访问的类属性，需通过类提供的接口进行访问，不能用 from xxx import * 而导入。
+ 以双下划线开头的 `__foo` 代表类的私有成员，常量, 不可修改
+ 以双下划线开头和结尾的 __foo__ 代表 Python 里特殊方法专用的标识，如 `__init__()` 代表类的构造函数。

## 行和缩进
学习 Python 与其他语言最大的区别就是，Python 的代码块不使用大括号 {} 来控制类，函数以及其他逻辑判断。python 最具特色的就是用缩进来写模块。

缩进的空白数量是可变的，但是所有代码块语句必须包含相同的缩进空白数量，这个必须严格执行。

## Python 引号

Python 可以使用引号( ' )、双引号( " )、三引号( ''' 或 """ ) 来表示字符串，引号的开始与结束必须是相同类型的。

其中三引号可以由多行组成，编写多行文本的快捷语法，常用于文档字符串，在文件的特定地点，被当做注释。

```python
word = 'word'
sentence = "这是一个句子。"
paragraph = """这是一个段落。
包含了多个语句"""
```

## Python注释
+ python中单行注释采用 # 开头。
+ python 中多行注释使用三个单引号 ''' 或三个双引号 """。

## 删除对象引用
del var
del var_a, var_b

## Pip

### pip 安装依赖
pip install -r requirements.txt

> 注意: 国外源会出现很多问题, 尤其是 代理 的问题

> pip proxy 代理: pip config set global.proxy http://127.0.0.1:10808

### 默认源
https://pypi.org/simple

pip config set global.index-url https://pypi.org/simple

### 国内源
https://zhuanlan.zhihu.com/p/623325525?utm_id=0&wd=&eqid=
+ 清华源: https://mirrors.tuna.tsinghua.edu.cn/help/pypi
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
+ 多个源

### 源路径
windows: User level configuration files
+ 1. `C:\Users\lenovo\AppData\Roaming\pip\pip.ini`
+ 2. `C:\Users\lenovo\pip\pip.ini`

### 清除缓存
+ 查看 pip 缓存目录
```
 pip cache dir 
```

## Jupter Notebook

.ipynb 是 Jupyter Notebook 文件的扩展名，代表 "Interactive Python Notebook"。这是一个可以在 Jupyter 环境中运行的交互式文档文件。Jupyter Notebook 是一种支持混合文本、代码和输出的工具，常用于数据科学、机器学习、研究和教育领域。

# Python 基础类型

## 整型 int

## 浮点型 float

## 布尔型 bool

## 字符串 str

### Python 字符串连接

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
var1 = 'Hello World!'
 
print "var1[0]: ", var1[0]
print "var2[1:5]: ", var2[1:5]
print "输出 :- ", var1[:6] + 'Runoob!'
```

+ int str int

`f"{1}{2}{3}"`

### 字符串截取

python字符串截取与java不同,

```python
print "var2[1:5]: ", var2[1:5]
```

### python 续行

+ 使用续行符

```python
total = item_one + \
        item_two + \
        item_three
```

+ 使用圆括号、方括号和花括号

```python
my_list = [
    1, 2, 3,
    4, 5, 6,
]

my_dict = {
    'key1': 'value1',
    'key2': 'value2',
}

my_function_call = (
    argument1,
    argument2,
    argument3,
)
```

+ 使用三引号字符串

```python
my_string = """This is a very long string
that spans across multiple lines in the
Python code."""
```

### Python 转义字符

在需要在字符中使用特殊字符时，python 用反斜杠 **\** 转义字符。如下表：

| 转义字符    | 描述                                                     |
| :---------- | :------------------------------------------------------- |
| \(在行尾时) | 续行符                                                   |
| \\          | 反斜杠符号                                               |
| \'          | 单引号                                                   |
| \"          | 双引号                                                   |
| \a          | 响铃                                                     |
| \b          | 退格(Backspace)                                          |
| \e          | 转义                                                     |
| \000        | 空                                                       |
| \n          | 换行                                                     |
| \v          | 纵向制表符                                               |
| \t          | 横向制表符                                               |
| \r          | 回车                                                     |
| \f          | 换页                                                     |
| \oyy        | 八进制数，y 代表 0~7 的字符，例如：\012 代表换行。       |
| \xyy        | 十六进制数，以 \x 开头，yy代表的字符，例如：\x0a代表换行 |
| \other      | 其它的字符以普通格式输出                                 |

### Python字符串运算符

| 操作符 | 描述                                                         | 实例                                 |
| :----- | :----------------------------------------------------------- | :----------------------------------- |
| +      | 字符串连接                                                   | >>>a + b 'HelloPython'               |
| *      | 重复输出字符串                                               | >>>a * 2 'HelloHello'                |
| []     | 通过索引获取字符串中字符                                     | >>>a[1] 'e'                          |
| [ : ]  | 截取字符串中的一部分                                         | >>>a[1:4] 'ell'                      |
| in     | 成员运算符 - 如果字符串中包含给定的字符返回 True             | >>>"H" in a True                     |
| not in | 成员运算符 - 如果字符串中不包含给定的字符返回 True           | >>>"M" not in a True                 |
| r/R    | 原始字符串 - 原始字符串：所有的字符串都是直接按照字面的意思来使用，没有转义特殊或不能打印的字符。 原始字符串除在字符串的第一个引号前加上字母"r"（可以大小写）以外，与普通字符串有着几乎完全相同的语法。 | >>>print r'\n' \n >>> print R'\n' \n |

### 格式化

#### `f`

在Python中，前缀`f`被用于字符串前，表示这是一个格式化字符串（f-string），从Python 3.6版本开始引入。使用f-string可以让你在字符串内直接嵌入表达式，这些表达式会在运行时被求值，并将其结果转换成字符串形式嵌入到字符串的相应位置。这样做的好处是可以简化字符串的格式化操作，使代码更加简洁易读。

```python
name = "世界"
message = f"你好，{name}！"
print(message)
```

#### str()

使用`shr()`函数进行转化

```
task_id=str(task_id),  # 将整数转换为字符串
```

#### 三引号

Python 三引号允许一个字符串跨多行，字符串中可以包含换行符、制表符以及其他特殊字符。

一个典型的用例是，当你需要一块HTML或者SQL时，这时当用三引号标记，使用传统的转义字符体系将十分费神。

```python
 errHTML = '''
<HTML><HEAD><TITLE>
Friends CGI Demo</TITLE></HEAD>
<BODY><H3>ERROR</H3>
<B>%s</B><P>
<FORM><INPUT TYPE=button VALUE=Back
ONCLICK="window.history.back()"></FORM>
</BODY></HTML>
'''
cursor.execute('''
CREATE TABLE users (  
login VARCHAR(8), 
uid INTEGER,
prid INTEGER)
''')
```

+ unicode

引号前小写的"u"表示这里创建的是一个 Unicode 字符串。如果你想加入一个特殊字符，可以使用 Python 的 Unicode-Escape 编码。如下例所示：

```python
>>> u'Hello\u0020World !'
u'Hello World !'
```

+ 方法注释

```python
def walk_directory(directory, parent_name=None, depth=0):
	"""批量标注。
	Args:
		directory (str): 要遍历的目录路径。
		depth (int): 当前遍历的深度，用于可视化和理解递归深度。
		parent_name: str: 父目录名称。
	"""
```

这个可以在pycharm中被识别

### 常用方法

#### 判断是否为真/假

真值（会导致 `if x:` 条件为 `True`）:

- **非空字符串**：`"hello"`、`" "`（只要字符串非空，即使是空格）
- **非零数字**：`1`、`-1`、`3.14` 等
- **非空容器**：列表、元组、字典、集合等，如果有元素。例如：`[1]`、`(2, 3)`、`{"key": "value"}` 等
- **自定义对象实例**：除非该对象实现了特殊方法 `__bool__()` 或 `__len__()` 并显式返回 `False` 或 `0`，否则实例默认为真值。

假值（会导致 `if x:` 条件为 `False`）:

- **`None`**：表示空值
- **空字符串**：`""`
- **数字 0**：`0`、`0.0`、`0j`（复数的零）
- **空容器**：空列表 `[]`，空元组 `()`，空字典 `{}`，空集合 `set()` 等
- **`False`**：布尔值 `False`

```
if x: # 判断是否为真
if not x: # 判断是否未假
```

#### 检查一个字符串是否包含另一个字符串

```python
if class_name in prompt: # 检查 prompt 是否包含 class_name
```



### Python 的字符串内建函数

| 方法                                                         | 描述                                                         |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| [string.capitalize()](https://www.runoob.com/python/att-string-capitalize.html) | 把字符串的第一个字符大写                                     |
| [string.center(width)](https://www.runoob.com/python/att-string-center.html) | 返回一个原字符串居中,并使用空格填充至长度 width 的新字符串   |
| **[string.count(str, beg=0, end=len(string))](https://www.runoob.com/python/att-string-count.html)** | 返回 str 在 string 里面出现的次数，如果 beg 或者 end 指定则返回指定范围内 str 出现的次数 |
| [string.decode(encoding='UTF-8', errors='strict')](https://www.runoob.com/python/att-string-decode.html) | 以 encoding 指定的编码格式解码 string，如果出错默认报一个 ValueError 的 异 常 ， 除非 errors 指 定 的 是 'ignore' 或 者'replace' |
| [string.encode(encoding='UTF-8', errors='strict')](https://www.runoob.com/python/att-string-encode.html) | 以 encoding 指定的编码格式编码 string，如果出错默认报一个ValueError 的异常，除非 errors 指定的是'ignore'或者'replace' |
| **[string.endswith(obj, beg=0, end=len(string))](https://www.runoob.com/python/att-string-endswith.html)** | 检查字符串是否以 obj 结束，如果beg 或者 end 指定则检查指定的范围内是否以 obj 结束，如果是，返回 True,否则返回 False. |
| [string.expandtabs(tabsize=8)](https://www.runoob.com/python/att-string-expandtabs.html) | 把字符串 string 中的 tab 符号转为空格，tab 符号默认的空格数是 8。 |
| **[string.find(str, beg=0, end=len(string))](https://www.runoob.com/python/att-string-find.html)** | 检测 str 是否包含在 string 中，如果 beg 和 end 指定范围，则检查是否包含在指定范围内，如果是返回开始的索引值，否则返回-1 |
| **[string.format()](https://www.runoob.com/python/att-string-format.html)** | 格式化字符串                                                 |
| **[string.index(str, beg=0, end=len(string))](https://www.runoob.com/python/att-string-index.html)** | 跟find()方法一样，只不过如果str不在 string中会报一个异常.    |
| [string.isalnum()](https://www.runoob.com/python/att-string-isalnum.html) | 如果 string 至少有一个字符并且所有字符都是字母或数字则返回 True,否则返回 False |
| [string.isalpha()](https://www.runoob.com/python/att-string-isalpha.html) | 如果 string 至少有一个字符并且所有字符都是字母则返回 True,否则返回 False |
| [string.isdecimal()](https://www.runoob.com/python/att-string-isdecimal.html) | 如果 string 只包含十进制数字则返回 True 否则返回 False.      |
| [string.isdigit()](https://www.runoob.com/python/att-string-isdigit.html) | 如果 string 只包含数字则返回 True 否则返回 False.            |
| [string.islower()](https://www.runoob.com/python/att-string-islower.html) | 如果 string 中包含至少一个区分大小写的字符，并且所有这些(区分大小写的)字符都是小写，则返回 True，否则返回 False |
| [string.isnumeric()](https://www.runoob.com/python/att-string-isnumeric.html) | 如果 string 中只包含数字字符，则返回 True，否则返回 False    |
| [string.isspace()](https://www.runoob.com/python/att-string-isspace.html) | 如果 string 中只包含空格，则返回 True，否则返回 False.       |
| [string.istitle()](https://www.runoob.com/python/att-string-istitle.html) | 如果 string 是标题化的(见 title())则返回 True，否则返回 False |
| [string.isupper()](https://www.runoob.com/python/att-string-isupper.html) | 如果 string 中包含至少一个区分大小写的字符，并且所有这些(区分大小写的)字符都是大写，则返回 True，否则返回 False |
| **[string.join(seq)](https://www.runoob.com/python/att-string-join.html)** | 以 string 作为分隔符，将 seq 中所有的元素(的字符串表示)合并为一个新的字符串 |
| [string.ljust(width)](https://www.runoob.com/python/att-string-ljust.html) | 返回一个原字符串左对齐,并使用空格填充至长度 width 的新字符串 |
| [string.lower()](https://www.runoob.com/python/att-string-lower.html) | 转换 string 中所有大写字符为小写.                            |
| [string.lstrip()](https://www.runoob.com/python/att-string-lstrip.html) | 截掉 string 左边的空格                                       |
| [string.maketrans(intab, outtab)](https://www.runoob.com/python/att-string-maketrans.html) | maketrans() 方法用于创建字符映射的转换表，对于接受两个参数的最简单的调用方式，第一个参数是字符串，表示需要转换的字符，第二个参数也是字符串表示转换的目标。 |
| [max(str)](https://www.runoob.com/python/att-string-max.html) | 返回字符串 *str* 中最大的字母。                              |
| [min(str)](https://www.runoob.com/python/att-string-min.html) | 返回字符串 *str* 中最小的字母。                              |
| **[string.partition(str)](https://www.runoob.com/python/att-string-partition.html)** | 有点像 find()和 split()的结合体,从 str 出现的第一个位置起,把 字 符 串 string 分 成 一 个 3 元 素 的 元 组 (string_pre_str,str,string_post_str),如果 string 中不包含str 则 string_pre_str == string. |
| **[string.replace(str1, str2, num=string.count(str1))](https://www.runoob.com/python/att-string-replace.html)** | 把 string 中的 str1 替换成 str2,如果 num 指定，则替换不超过 num 次. |
| [string.rfind(str, beg=0,end=len(string) )](https://www.runoob.com/python/att-string-rfind.html) | 类似于 find() 函数，返回字符串最后一次出现的位置，如果没有匹配项则返回 -1。 |
| [string.rindex( str, beg=0,end=len(string))](https://www.runoob.com/python/att-string-rindex.html) | 类似于 index()，不过是返回最后一个匹配到的子字符串的索引号。 |
| [string.rjust(width)](https://www.runoob.com/python/att-string-rjust.html) | 返回一个原字符串右对齐,并使用空格填充至长度 width 的新字符串 |
| [string.rpartition(str)](https://www.runoob.com/python/att-string-rpartition.html) | 类似于 partition()函数,不过是从右边开始查找                  |
| [string.rstrip()](https://www.runoob.com/python/att-string-rstrip.html) | 删除 string 字符串末尾的空格.                                |
| **[string.split(str="", num=string.count(str))](https://www.runoob.com/python/att-string-split.html)** | 以 str 为分隔符切片 string，如果 num 有指定值，则仅分隔 **num+1** 个子字符串 |
| [string.splitlines([keepends\])](https://www.runoob.com/python/att-string-splitlines.html) | 按照行('\r', '\r\n', '\n')分隔，返回一个包含各行作为元素的列表，如果参数 keepends 为 False，不包含换行符，如果为 True，则保留换行符。 |
| [string.startswith(obj, beg=0,end=len(string))](https://www.runoob.com/python/att-string-startswith.html) | 检查字符串是否是以 obj 开头，是则返回 True，否则返回 False。如果beg 和 end 指定值，则在指定范围内检查. |
| **[string.strip([obj\])](https://www.runoob.com/python/att-string-strip.html)** | 在 string 上执行 lstrip()和 rstrip()                         |
| [string.swapcase()](https://www.runoob.com/python/att-string-swapcase.html) | 翻转 string 中的大小写                                       |
| [string.title()](https://www.runoob.com/python/att-string-title.html) | 返回"标题化"的 string,就是说所有单词都是以大写开始，其余字母均为小写(见 istitle()) |
| **[string.translate(str, del="")](https://www.runoob.com/python/att-string-translate.html)** | 根据 str 给出的表(包含 256 个字符)转换 string 的字符,要过滤掉的字符放到 del 参数中 |
| [string.upper()](https://www.runoob.com/python/att-string-upper.html) | 转换 string 中的小写字母为大写                               |
| [string.zfill(width)](https://www.runoob.com/python/att-string-zfill.html) | 返回长度为 width 的字符串，原字符串 string 右对齐，前面填充0 |



## 列表 list

创建一个列表，只要把逗号分隔的不同的数据项使用方括号括起来即可。如下所示：

```python
list1 = ['physics', 'chemistry', 1997, 2000]
list2 = [1, 2, 3, 4, 5 ]
list3 = ["a", "b", "c", "d"]
```

### 访问列表中的值

使用下标索引来访问列表中的值，同样你也可以使用方括号的形式截取字符，如下所示：

```python
#!/usr/bin/python
 
list1 = ['physics', 'chemistry', 1997, 2000]
list2 = [1, 2, 3, 4, 5, 6, 7 ]
 
print "list1[0]: ", list1[0]
print "list2[1:5]: ", list2[1:5]
```

### 更新列表

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
list = []          ## 空列表
list.append('Google')   ## 使用 append() 添加元素
list.append('Runoob')
print list
```

### 删除列表元素

```python
#!/usr/bin/python
 
list1 = ['physics', 'chemistry', 1997, 2000]
 
print list1
del list1[2]
print "After deleting value at index 2 : "
print list1
```

### Python列表截取

Python 的列表截取实例如下：

\>>>L = ['Google', 'Runoob', 'Taobao'] >>> L[2] 'Taobao' >>> L[-2] 'Runoob' >>> L[1:] ['Runoob', 'Taobao'] >>>

描述：

| Python 表达式 | 结果                 | 描述                     |
| :------------ | :------------------- | :----------------------- |
| L[2]          | 'Taobao'             | 读取列表中第三个元素     |
| L[-2]         | 'Runoob'             | 读取列表中倒数第二个元素 |
| L[1:]         | ['Runoob', 'Taobao'] | 从第二个元素开始截取列表 |

### Python列表脚本操作符

列表对 + 和 * 的操作符与字符串相似。+ 号用于组合列表，* 号用于重复列表。

如下所示：

| Python 表达式                | 结果                         | 描述                 |
| :--------------------------- | :--------------------------- | :------------------- |
| len([1, 2, 3])               | 3                            | 长度                 |
| [1, 2, 3] + [4, 5, 6]        | [1, 2, 3, 4, 5, 6]           | 组合                 |
| ['Hi!'] * 4                  | ['Hi!', 'Hi!', 'Hi!', 'Hi!'] | 重复                 |
| 3 in [1, 2, 3]               | True                         | 元素是否存在于列表中 |
| for x in [1, 2, 3]: print x, | 1 2 3                        | 迭代                 |

### Python列表函数&方法

Python包含以下函数:

| 序号 | 函数                                                         |
| :--- | :----------------------------------------------------------- |
| 1    | [cmp(list1, list2)](https://www.runoob.com/python/att-list-cmp.html) 比较两个列表的元素 |
| 2    | [len(list)](https://www.runoob.com/python/att-list-len.html) 列表元素个数 |
| 3    | [max(list)](https://www.runoob.com/python/att-list-max.html) 返回列表元素最大值 |
| 4    | [min(list)](https://www.runoob.com/python/att-list-min.html) 返回列表元素最小值 |
| 5    | [list(seq)](https://www.runoob.com/python/att-list-list.html) 将元组转换为列表 |

Python包含以下方法:

| 序号 | 方法                                                         |
| :--- | :----------------------------------------------------------- |
| 1    | [list.append(obj)](https://www.runoob.com/python/att-list-append.html) 在列表末尾添加新的对象 |
| 2    | [list.count(obj)](https://www.runoob.com/python/att-list-count.html) 统计某个元素在列表中出现的次数 |
| 3    | [list.extend(seq)](https://www.runoob.com/python/att-list-extend.html) 在列表末尾一次性追加另一个序列中的多个值（用新列表扩展原来的列表） |
| 4    | [list.index(obj)](https://www.runoob.com/python/att-list-index.html) 从列表中找出某个值第一个匹配项的索引位置 |
| 5    | [list.insert(index, obj)](https://www.runoob.com/python/att-list-insert.html) 将对象插入列表 |
| 6    | [list.pop([index=-1\])](https://www.runoob.com/python/att-list-pop.html) 移除列表中的一个元素（默认最后一个元素），并且返回该元素的值 |
| 7    | [list.remove(obj)](https://www.runoob.com/python/att-list-remove.html) 移除列表中某个值的第一个匹配项 |
| 8    | [list.reverse()](https://www.runoob.com/python/att-list-reverse.html) 反向列表中元素 |
| 9    | [list.sort(cmp=None, key=None, reverse=False)](https://www.runoob.com/python/att-list-sort.html) 对原列表进行排序 |

## 元组 ()

Python 的元组与列表类似，不同之处在于元组的元素不能修改。

```python
tup1 = ('physics', 'chemistry', 1997, 2000)
tup2 = (1, 2, 3, 4, 5 )
tup3 = "a", "b", "c", "d"
#元组中只包含一个元素时，需要在元素后面添加逗号
tup1 = (50,)
```

### 修改元组

元组中的元素值是不允许修改的，但我们可以对元组进行连接组合，如下实例:

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
tup1 = (12, 34.56)
tup2 = ('abc', 'xyz')
 
# 以下修改元组元素操作是非法的。编译时报错
# tup1[0] = 100
 
# 创建一个新的元组
tup3 = tup1 + tup2
print tup3
```



### 删除元组

元组中的元素值是不允许删除的，但我们可以使用del语句来删除整个元组，如下实例

```python
#!/usr/bin/python
 
tup = ('physics', 'chemistry', 1997, 2000)
 
print tup
del tup
print "After deleting tup : "
print tup
```

### 无关闭分隔符

任意无符号的对象，以逗号隔开，默认为元组，如下实例：

```python
#!/usr/bin/python
 
print 'abc', -4.24e93, 18+6.6j, 'xyz'
x, y = 1, 2
print "Value of x , y : ", x,y
```

## 集合 set
`set` 是一种内置的数据结构，用于存储**唯一**的、**无序的**、**不可变的元素**。它非常适合用于需要快速去重或进行集合运算（如并集、交集等）的场景。

------

### **基本特性**

- **无序性**：集合中的元素没有顺序，因此无法通过索引访问。
- **唯一性**：集合中的每个元素都是唯一的，重复的元素会被自动移除。
- **元素的不可变性**：集合中的元素必须是不可变的（如整数、字符串、元组），但集合本身是可变的，可以动态添加或删除元素。

------

### **创建集合**

集合可以通过两种方式创建：

1. 使用大括号 `{}`。
2. 使用 `set()` 函数。

```
# 用大括号创建集合
my_set = {1, 2, 3, 4}

# 用 set() 函数创建集合
another_set = set([1, 2, 3, 4])

# 创建空集合
empty_set = set()  # 注意：{} 表示空字典，而不是空集合
```

### **集合的主要方法和操作**

#### **1) 添加元素**

- 使用 `add()` 方法向集合中添加单个元素。
- 使用 `update()` 方法向集合中添加多个元素。

```python
my_set = {1, 2, 3}
my_set.add(4)          # 添加单个元素
my_set.update([5, 6])  # 添加多个元素
print(my_set)          # 输出：{1, 2, 3, 4, 5, 6}
```

#### **2) 删除元素**

- `remove()`：移除指定元素，如果不存在会抛出 `KeyError`。
- `discard()`：移除指定元素，不存在则不报错。
- `pop()`：随机移除并返回集合中的一个元素。
- `clear()`：清空集合。

```python
my_set = {1, 2, 3, 4}
my_set.remove(2)       # 移除 2
my_set.discard(5)      # 不报错
removed_element = my_set.pop()  # 随机移除一个元素
my_set.clear()         # 清空集合
print(my_set)          # 输出：set()
```

#### **3) 检查元素**

- 使用 `in` 和 `not in` 判断元素是否存在。

```python
my_set = {1, 2, 3}
print(2 in my_set)    # 输出：True
print(4 not in my_set) # 输出：True
```

#### **4) 集合运算**

集合支持多种运算，如并集、交集、差集等。

| 运算                                 | 方法/符号                       | 示例          |
| ------------------------------------ | ------------------------------- | ------------- |
| **并集**（Union）                    | `union()` 或 `                  | `             |
| **交集**（Intersection）             | `intersection()` 或 `&`         | `set1 & set2` |
| **差集**（Difference）               | `difference()` 或 `-`           | `set1 - set2` |
| **对称差集**（Symmetric Difference） | `symmetric_difference()` 或 `^` | `set1 ^ set2` |

#### 示例

```python
set1 = {1, 2, 3}
set2 = {3, 4, 5}

# 并集
print(set1 | set2)  # 输出：{1, 2, 3, 4, 5}

# 交集
print(set1 & set2)  # 输出：{3}

# 差集
print(set1 - set2)  # 输出：{1, 2}

# 对称差集
print(set1 ^ set2)  # 输出：{1, 2, 4, 5}
```

#### **5) 子集和超集**

- `issubset()`：检查是否是另一个集合的子集。
- `issuperset()`：检查是否是另一个集合的超集。
- `isdisjoint()`：检查两个集合是否没有交集。

```python
set1 = {1, 2, 3}
set2 = {1, 2}
set3 = {4, 5}

print(set2.issubset(set1))  # 输出：True
print(set1.issuperset(set2))  # 输出：True
print(set1.isdisjoint(set3))  # 输出：True
```

------

###  **集合的遍历**

集合可以通过 `for` 循环遍历。

```python
my_set = {1, 2, 3}
for item in my_set:
    print(item)
```

------

### 集合的应用场景

#### **1) 去重**

集合的主要特点之一是去除重复元素。

```python
numbers = [1, 2, 2, 3, 4, 4, 5]
unique_numbers = set(numbers)  # 去重
print(unique_numbers)  # 输出：{1, 2, 3, 4, 5}
```

#### **2) 集合运算**

集合运算可以用来快速求解交集、并集等。

#### **3) 快速查找**

由于集合基于哈希表实现，`in` 操作的时间复杂度是 O(1)，适合用于快速查找。

```python
my_set = {1, 2, 3}
print(2 in my_set)  # 输出：True
```

------

### **注意事项**

1. **空集合**：用 `{}` 定义的是空字典，空集合必须用 `set()`。

   ```python
   empty_dict = {}
   empty_set = set()
   print(type(empty_dict))  # 输出：<class 'dict'>
   print(type(empty_set))   # 输出：<class 'set'>
   ```
   
2. **集合的元素必须是不可变的**：例如，数字、字符串和元组可以作为集合的元素，但列表和字典不行。

   ```python
   my_set = {1, 2, (3, 4)}
   # my_set = {1, 2, [3, 4]}  # 会报错
   ```

## 字典 dict

可以理解成java-map

字典是另一种可变容器模型，且可存储任意类型对象。键一般是唯一的，如果重复最后的一个键值对会替换前面的，值不需要唯一。

字典的每个键值 **key:value** 对用冒号 **`:`** 分割，每个键值对之间用逗号 **`,`** 分割，整个字典包括在花括号 **`{}`** 中 ,格式如下所示：

d = {key1 : value1, key2 : value2 }

> **注意：**dict 作为 Python 的关键字和内置函数，变量名不建议命名为 **dict**。

> ### 字典键的特性
>
> 字典值可以没有限制地取任何 python 对象，既可以是标准的对象，也可以是用户定义的，但键不行。
>
> + 不允许同一个键出现两次。创建时如果同一个键被赋值两次，后一个值会被记住
>
> + 键必须不可变，所以可以用数字，字符串或元组充当，所以用列表就不行
>
>   `tinydict[(1,2,3)]="hello"`

### 访问字典里的值

```python
#!/usr/bin/python
 
tinydict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'}
 
print "tinydict['Name']: ", tinydict['Name']
print "tinydict['Age']: ", tinydict['Age']
```

如果用字典里没有的键访问数据，会输出错误如下：

```python
tinydict['Alice']: 
Traceback (most recent call last):
  File "test.py", line 5, in <module>
    print "tinydict['Alice']: ", tinydict['Alice']
KeyError: 'Alice'
```

### 遍历字典

#### 1. 遍历字典的键

使用 `for key in dict` 或 `for key in dict.keys()` 遍历字典的所有键：

```python
my_dict = {'a': 1, 'b': 2, 'c': 3}

for key in my_dict:
    print(f"Key: {key}")
# 或
for key in my_dict.keys():
    print(f"Key: {key}")
```

**输出**:

```makefile
Key: a
Key: b
Key: c
```

------

#### 2. 遍历字典的值

使用 `for value in dict.values()` 遍历字典的所有值：

```python
for value in my_dict.values():
    print(f"Value: {value}")
```

**输出**:

```
Value: 1
Value: 2
Value: 3
```

------

#### 3. 遍历字典的键值对

使用 `for key, value in dict.items()` 遍历键值对：

```python
for key, value in my_dict.items():
    print(f"Key: {key}, Value: {value}")
```

**输出**:

```yaml
Key: a, Value: 1
Key: b, Value: 2
Key: c, Value: 3
```

### 获取第一个元素

在 Python 中，字典是无序的（在 Python 3.7 及更高版本中，字典按插入顺序维护元素）。如果你想获取字典的第一个元素，可以使用以下几种方法：

#### dict.items() 转为字典

+ `list()` 转换

你也可以将字典的 `items()` 转换为列表，并获取第一个元素：

```
my_dict = {
    '.': '',  # 所有
    'cow': "cow",  # 牛
}

# 转换为列表，获取第一个键值对
first_key, first_value = list(my_dict.items())[0]
print(f'First key: {first_key}, First value: {first_value}')
```

输出：

```
First key: ., First value: 
```

+ next() 和 iter() 

使用 `next()` 结合 `iter()` 可以快速获取字典中的第一个元素：

```
my_dict = {
    '.': '',  # 所有
    'cow': "cow",  # 牛
}

# 获取第一个键值对
first_key, first_value = next(iter(my_dict.items()))
print(f'First key: {first_key}, First value: {first_value}')
```

输出：

```
First key: ., First value: 
```

#### keys() 和 values() 获取键值

如果你只想获取第一个键或第一个值，可以分别从 `keys()` 或 `values()` 获取。

获取第一个键：

```
first_key = next(iter(my_dict.keys()))
print(f'First key: {first_key}')
```

获取第一个值：

```

first_value = next(iter(my_dict.values()))
print(f'First value: {first_value}')
```

总结：

- 使用 `next(iter(my_dict.items()))` 可以直接获取字典的第一个键值对。
- `list(my_dict.items())[0]` 是另一种选择，适合你想以索引方式访问时使用。

### 添加或修改字典

向字典添加新内容的方法是增加新的键/值对，修改或删除已有键/值对如下实例:

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
tinydict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'}
 
tinydict['Age'] = 8 # 更新
tinydict['School'] = "RUNOOB" # 添加
 
 
print "tinydict['Age']: ", tinydict['Age']
print "tinydict['School']: ", tinydict['School']
```

### 删除字典元素

能删单一的元素也能清空字典，清空只需一项操作。

显示删除一个字典用del命令，如下实例：

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
tinydict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'}
 
del tinydict['Name']  # 删除键是'Name'的条目
tinydict.clear()      # 清空字典所有条目
del tinydict          # 删除字典
 
print "tinydict['Age']: ", tinydict['Age'] 
print "tinydict['School']: ", tinydict['School']
```

## None 类型

# Python 函数

## 语法

以下是简单的规则：

- 函数代码块以 **def** 关键词开头，后接函数标识符名称和圆括号**()**。
- 任何传入参数和自变量必须放在圆括号中间。圆括号之间可以用于定义参数。
- 函数的第一行语句可以选择性地使用文档字符串—用于存放函数说明。
- 函数内容以冒号起始，并且缩进。
- **return [表达式]** 结束函数，选择性地返回一个值给调用方。不带表达式的return相当于返回 None。

```python
def functionname( parameters ):
   "函数_文档字符串"
   function_suite
   return [expression]
```

## 参数传递

### 直接传递参数

> 在 python 中，strings, tuples, 和 numbers 是不可更改的对象，而 list,dict 等则是可以修改的对象。
>
> - **不可变类型：**变量赋值 **a=5** 后再赋值 **a=10**，这里实际是新生成一个 int 值对象 10，再让 a 指向它，而 5 被丢弃，不是改变a的值，相当于新生成了a。
> - **可变类型：**变量赋值 **la=[1,2,3,4]** 后再赋值 **la[2]=5** 则是将 list la 的第三个元素值更改，本身la没有动，只是其内部的一部分值被修改了。

python 函数的参数传递：

- **对于不可变类型：**类似值传递，如 整数、字符串、元组。如fun（a），传递的只是a的值，没有影响a对象本身。比如在 fun（a）内部修改 a 的值，只是修改另一个复制的对象，不会影响 a 本身。
- **对于可变类型**：类似引用传递，如 列表，字典。如 fun（la），则是将 la 真正的传过去，修改后fun外部的la也会受影响

### 通过解包传递参数

**假设 `_vis_image` 函数原型**：假设 `_vis_image` 函数的签名如下：

```
def _vis_image(image_source, boxes, phrases, scores):
    # 函数内部使用传入的参数进行处理
    pass
```

这里需要传递的参数分别是：

- `image_source`：图像源
- `boxes`：边界框
- `phrases`：识别的短语或类别名称
- `scores`：识别的分数

**解包与传参：**

在你的代码中，你通过 `inference_damoyolo(image_url, prompt)` 获取了 `image_source` 以及 `boxes`, `phrases`, `scores`。解包方式如下：

```
image_source, (boxes, phrases, scores) = inference_damoyolo(image_url, prompt)
```

此时，`image_source` 保存了图像，`boxes`, `phrases`, `scores` 分别代表预测边界框、类别名称和分数。然后你可以直接将它们作为参数传递给 `_vis_image`。

## 参数

### 必备参数(与java一致)

### 关键字参数

使用关键字参数允许函数调用时参数的顺序与声明时不一致，因为 Python 解释器能够用参数名匹配参数值。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
#可写函数说明
def printinfo( name, age ):
   "打印任何传入的字符串"
   print "Name: ", name
   print "Age ", age
   return
 
#调用printinfo函数
printinfo( age=50, name="miki" )
```

### 默认参数

调用函数时，默认参数的值如果没有传入，则被认为是默认值。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
#可写函数说明
def printinfo( name, age = 35 ):
   "打印任何传入的字符串"
   print "Name: ", name
   print "Age ", age
   return
 
#调用printinfo函数
printinfo( age=50, name="miki" )
printinfo( name="miki" )
```

> 注意, 默认参数可不被传入, 所以默认参数之后新的参数也会被认为是默认参数, 需要添加默认值, 否则报错

### 不定长参数

你可能需要一个函数能处理比当初声明时更多的参数。这些参数叫做不定长参数，和上述2种参数不同，声明时不会命名。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
# 可写函数说明
def printinfo( arg1, *vartuple ):
   "打印任何传入的参数"
   print "输出: "
   print arg1
   for var in vartuple:
      print var
   return
 
# 调用printinfo 函数
printinfo( 10 )
printinfo( 70, 60, 50 )
```

### 匿名函数

python 使用 lambda 来创建匿名函数。

- lambda只是一个表达式，函数体比def简单很多。
- lambda的主体是一个表达式，而不是一个代码块。仅仅能在lambda表达式中封装有限的逻辑进去。
- lambda函数拥有自己的命名空间，且不能访问自有参数列表之外或全局命名空间里的参数。
- 虽然lambda函数看起来只能写一行，却不等同于C或C++的内联函数，后者的目的是调用小函数时不占用栈内存从而增加运行效率。

### 语法

lambda函数的语法只包含一个语句，如下：

```python
lambda [arg1 [,arg2,.....argn]]:expression
```

### return 语句(与java一致)

## 全局变量和局部变量

定义在函数内部的变量拥有一个局部作用域，定义在函数外的拥有全局作用域。

局部变量只能在其被声明的函数内部访问，而全局变量可以在整个程序范围内访问。调用函数时，所有在函数内声明的变量名称都将被加入到作用域中。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
total = 0 # 这是一个全局变量
# 可写函数说明
def sum( arg1, arg2 ):
   #返回2个参数的和."
   total = arg1 + arg2 # total在这里是局部变量.
   print "函数内是局部变量 : ", total
   return total
 
#调用sum函数
sum( 10, 20 )
print "函数外是全局变量 : ", total
```

### 命名空间和作用域

如果要给函数内的全局变量赋值，必须使用 `global` 语句。

global VarName 的表达式会告诉 Python， VarName 是一个全局变量，这样 Python 就不会在局部命名空间里寻找这个变量了。

例如，我们在全局命名空间里定义一个变量 Money。我们再在函数内给变量 Money 赋值，然后 Python 会假定 Money 是一个局部变量。然而，我们并没有在访问前声明一个局部变量 Money，结果就是会出现一个 UnboundLocalError 的错误。取消 global 语句前的注释符就能解决这个问题。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
Money = 2000
def AddMoney():
   # 声明函数内的 var 为 global
   global Money
   Money = Money + 1
 
print Money
AddMoney()
print Money
```

## 

# Python 常用API

## Python 日期和时间

Python 的 time 模块下有很多函数可以转换常见日期格式。如函数time.time()用于获取当前时间戳, 如下实例:

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
import time  # 引入time模块
 
ticks = time.time()
print "当前时间戳为:", ticks
```

## 运算符

### Python成员运算符

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
a = 10
b = 20
list = [1, 2, 3, 4, 5 ];
 
if ( a in list ):
   print "1 - 变量 a 在给定的列表中 list 中"
else:
   print "1 - 变量 a 不在给定的列表中 list 中"
 
if ( b not in list ):
   print "2 - 变量 b 不在给定的列表中 list 中"
else:
   print "2 - 变量 b 在给定的列表中 list 中"
 
# 修改变量 a 的值
a = 2
if ( a in list ):
   print "3 - 变量 a 在给定的列表中 list 中"
else:
   print "3 - 变量 a 不在给定的列表中 list 中"
```

### Python身份运算符

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
a = 20
b = 20
 
if ( a is b ):
   print "1 - a 和 b 有相同的标识"
else:
   print "1 - a 和 b 没有相同的标识"
 
if ( a is not b ):
   print "2 - a 和 b 没有相同的标识"
else:
   print "2 - a 和 b 有相同的标识"
 
# 修改变量 b 的值
b = 30
if ( a is b ):
   print "3 - a 和 b 有相同的标识"
else:
   print "3 - a 和 b 没有相同的标识"
 
if ( a is not b ):
   print "4 - a 和 b 没有相同的标识"
else:
   print "4 - a 和 b 有相同的标识"
```

## 常用语句

### if-else

python 并不支持 switch 语句，所以多个条件判断，只能用 elif 来实现

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
# 例3：if语句多个条件
 
num = 9
if num >= 0 and num <= 10:    # 判断值是否在0~10之间
    print 'hello'
    print 'hello'
# 输出结果: hello
 
num = 10
if num < 0 or num > 10:    # 判断值是否在小于0或大于10
    print 'hello'
else:
    print 'undefine'
# 输出结果: undefine
 
num = 8
# 判断值是否在0~5或者10~15之间
if (num >= 0 and num <= 5) or (num >= 10 and num <= 15):    
    print 'hello'
else:
    print 'undefine'
# 输出结果: undefine
```

### while

```python
count = 0
while (count < 9):
   print 'The count is:', count
   count = count + 1
 
print "Good bye!"

```

+ while-else
  在 python 中，while … else 在循环条件为 false 时执行 else 语句块：

```python
#!/usr/bin/python
 
count = 0
while count < 5:
   print count, " is  less than 5"
   count = count + 1
else:
   print count, " is not less than 5"
```

### for-in

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
for letter in 'Python':     # 第一个实例
   print("当前字母: %s" % letter)
 
fruits = ['banana', 'apple',  'mango']
for fruit in fruits:        # 第二个实例
   print ('当前水果: %s'% fruit)
 
print ("Good bye!")
```

### for-i

```python
fruits = ['banana', 'apple',  'mango']
for index in range(len(fruits)):
   print ('当前水果 : %s' % fruits[index])
 
print ("Good bye!")
```

### for-else

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
for num in range(10,20):  # 迭代 10 到 20 (不包含) 之间的数字
   for i in range(2,num): # 根据因子迭代
      if num%i == 0:      # 确定第一个因子
         j=num/i          # 计算第二个因子
         print ('%d 等于 %d * %d' % (num,i,j))
         break            # 跳出当前循环
   else:                  # 循环的 else 部分
      print ('%d 是一个质数' % num)
```

### pass

break/continue/pass

`pass` 是空语句，是为了保持程序结构的完整性。

**pass** 不做任何事情，一般用做占位语句。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*- 
 
# 输出 Python 的每个字母
for letter in 'Python':
   if letter == 'h':
      pass
      print '这是 pass 块'
   print '当前字母 :', letter
 
print "Good bye!"
```

### switch

Python 3.10 引入了新的 `match-case` 语句，类似于其他语言中的 `switch-case`。

```python
def switch_example(value):
    match value:
        case 1:
            return "Option 1"
        case 2:
            return "Option 2"
        case 3:
            return "Option 3"
        case _:
            return "Default Option"

print(switch_example(2))  # 输出：Option 2
```

#### 匹配常量

如果你想在 `match-case` 语句中使用 `model_damoyolo` 作为常量（不可变类型），你可以通过以下几种方式使其符合不可变类型的要求：

##### **使用枚举**

Python 的 `enum` 模块可以用于定义不可变的常量。你可以将 `model_damoyolo` 和 `model_groundingdino` 定义为枚举类型，这样在 `match-case` 中可以直接使用它们。

```python
from enum import Enum

# 定义枚举类
class ModelType(Enum):
    DAMOYOLO = "model_damoyolo"
    GROUNDINGDINO = "model_groundingdino"

# 示例函数
def process_model(model):
    match model:
        case ModelType.DAMOYOLO:
            # 白天
            prompt = enum_tool.get_enum_from_str(PromptStatusEnumGroundingdino, prompt).value
            annotated_frame, phrases = inference_damoyolo(image_url, prompt)  # 推理 - damoyolo
        case ModelType.GROUNDINGDINO:
            # 晚上
            annotated_frame, phrases = inference_grounding_dino(image_url, prompt)  # 推理 - groundingdino
        case _:
            return 'default result'

# 使用示例
process_model(ModelType.DAMOYOLO)
```

在此示例中：

- `ModelType` 枚举类定义了两个不可变的常量：`DAMOYOLO` 和 `GROUNDINGDINO`。
- 在 `match-case` 语句中可以直接使用这些枚举常量。

##### **使用常量**

如果不想使用 `enum`，可以简单地定义全局常量来代替变量。常量通常用全大写字母命名，以表示它们的不可变性。

```python
# 定义常量
MODEL_DAMOYOLO = "model_damoyolo"
MODEL_GROUNDINGDINO = "model_groundingdino"

# 示例函数
def process_model(model):
    match model:
        case MODEL_DAMOYOLO:
            # 白天
            prompt = enum_tool.get_enum_from_str(PromptStatusEnumGroundingdino, prompt).value
            annotated_frame, phrases = inference_damoyolo(image_url, prompt)  # 推理 - damoyolo
        case MODEL_GROUNDINGDINO:
            # 晚上
            annotated_frame, phrases = inference_grounding_dino(image_url, prompt)  # 推理 - groundingdino
        case _:
            return 'default result'

# 使用示例
process_model(MODEL_DAMOYOLO)
```

在此示例中，`MODEL_DAMOYOLO` 和 `MODEL_GROUNDINGDINO` 是字符串常量，表示不可变的类型。

##### **使用元组**

如果你的模型类型不仅仅是简单的字符串，可能包含多个属性，还可以使用不可变的元组或 `collections.namedtuple` 来表示不可变类型。

```python
MODEL_DAMOYOLO = ("model_damoyolo", "version_1")
MODEL_GROUNDINGDINO = ("model_groundingdino", "version_2")

def process_model(model):
    match model:
        case ("model_damoyolo", _):
            # 白天
            prompt = enum_tool.get_enum_from_str(PromptStatusEnumGroundingdino, prompt).value
            annotated_frame, phrases = inference_damoyolo(image_url, prompt)  # 推理 - damoyolo
        case ("model_groundingdino", _):
            # 晚上
            annotated_frame, phrases = inference_grounding_dino(image_url, prompt)  # 推理 - groundingdino
        case _:
            return 'default result'

# 使用示例
process_model(MODEL_DAMOYOLO)
```

这里的 `model` 是不可变的元组，模式匹配时可以匹配多个值。

**总结：**

1. **枚举 (`enum`)** 是定义不可变常量的最佳方式，它语义清晰，易于扩展。
2. **全局常量** 也是一种简单的方法，可以用于不可变类型。
3. **元组或命名元组** 可以处理复杂的数据结构，并且是不可变的。

### yield

+ Python yield 使用浅析: https://www.runoob.com/w3cnote/python-yield-used-analysis.html

简单理解, 返回一个 List<num1, num2, num3> 数组

典型方法: `os.walk(fileDir)`, 返回 List<root, dirs, files>

一个简单例子如下:

```python
def fab(max): 
    n, a, b = 0, 0, 1 
    while n < max: 
        yield b      # 使用 yield
        # print b 
        a, b = b, a + b 
        n = n + 1
 
for n in fab(5): 
    print n
```

总结: 一个带有 yield 的函数就是一个 generator，它和普通函数不同，生成一个 generator 看起来像函数调用，但不会执行任何函数代码，直到对其调用 next()（在 for 循环中会自动调用 next()）才开始执行。虽然执行流程仍按函数的流程执行，但每执行到一个 yield 语句就会中断，并返回一个迭代值，下次执行时从 yield 的下一个语句继续执行。看起来就好像一个函数在正常执行的过程中被 yield 中断了数次，每次中断都会通过 yield 返回当前的迭代值。

yield 的好处是显而易见的，把一个函数改写为一个 generator 就获得了迭代能力，比起用类的实例保存状态来计算下一个 next() 的值，不仅代码简洁，而且执行流程异常清晰。

### 冒号: 

冒号通常用来引入代码块或分隔条件、定义等。例如

`if prompt and prompt != '': text = prompt`

你提供的代码将 `if` 语句和它的主体放在了同一行，这是 Python 允许的简写形式。如果条件为真，紧跟在冒号后的语句就会执行。

### 三目运算

```python
value_if_true if condition else value_if_false
```

语法解释：

- `condition` 是一个返回 `True` 或 `False` 的表达式。
- 如果 `condition` 为 `True`，则返回 `value_if_true`。
- 如果 `condition` 为 `False`，则返回 `value_if_false`。

示例：

```python
age = 18
status = "Adult" if age >= 18 else "Minor"
print(status)  # 输出: Adult
```

## Python 文件I/O

### 打印到屏幕

### 读取键盘输入

### 打开和关闭文件

### 读取模式

| 模式 | 描述                                                         |
| :--- | :----------------------------------------------------------- |
| t    | 文本模式 (默认)。                                            |
| x    | 写模式，新建一个文件，如果该文件已存在则会报错。             |
| b    | 二进制模式。                                                 |
| +    | 打开一个文件进行更新(可读可写)。                             |
| U    | 通用换行模式（不推荐）。                                     |
| r    | 以只读方式打开文件。文件的指针将会放在文件的开头。这是默认模式。 |
| rb   | 以二进制格式打开一个文件用于只读。文件指针将会放在文件的开头。这是默认模式。一般用于非文本文件如图片等。 |
| r+   | 打开一个文件用于读写。文件指针将会放在文件的开头。           |
| rb+  | 以二进制格式打开一个文件用于读写。文件指针将会放在文件的开头。一般用于非文本文件如图片等。 |
| w    | 打开一个文件只用于写入。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
| wb   | 以二进制格式打开一个文件只用于写入。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。一般用于非文本文件如图片等。 |
| w+   | 打开一个文件用于读写。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
| wb+  | 以二进制格式打开一个文件用于读写。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。一般用于非文本文件如图片等。 |
| a    | 打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。 |
| ab   | 以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。 |
| a+   | 打开一个文件用于读写。如果该文件已存在，文件指针将会放在文件的结尾。文件打开时会是追加模式。如果该文件不存在，创建新文件用于读写。 |
| ab+  | 以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。如果该文件不存在，创建新文件用于读写。 |



例子如下:

```python
	file_path = 'example.txt'  # 目标文件的路径
	# 使用追加模式打开文件, 如果文件不存在，在指定路径创建一个新文件，并写入指定的文本行。
	with open(file_path, 'a', encoding='utf-8') as file:
		file.write(line + '\n')
```



#### File对象的属性

一个文件被打开后，你有一个file对象，你可以得到有关该文件的各种信息。

以下是和file对象相关的所有属性的列表：

| 属性           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| file.closed    | 返回true如果文件已被关闭，否则返回false。                    |
| file.mode      | 返回被打开文件的访问模式。                                   |
| file.name      | 返回文件的名称。                                             |
| file.softspace | 如果用print输出后，必须跟一个空格符，则返回false。否则返回true。 |

#### close()方法

File 对象的 close（）方法刷新缓冲区里任何还没写入的信息，并关闭该文件，这之后便不能再进行写入。

当一个文件对象的引用被重新指定给另一个文件时，Python 会关闭之前的文件。用 close（）方法关闭文件是一个很好的习惯。

#### write()方法

write()方法可将任何字符串写入一个打开的文件。需要重点注意的是，Python字符串可以是二进制数据，而不是仅仅是文字。

write()方法不会在字符串的结尾添加换行符('\n')：

#### read()方法

read（）方法从一个打开的文件中读取一个字符串。需要重点注意的是，Python字符串可以是二进制数据，而不是仅仅是文字。

#### tell()方法

tell()方法告诉你文件内的当前位置, 换句话说，下一次的读写会发生在文件开头这么多字节之后。

seek（offset [,from]）方法改变当前文件的位置。Offset变量表示要移动的字节数。From变量指定开始移动字节的参考位置。

如果from被设为0，这意味着将文件的开头作为移动字节的参考位置。如果设为1，则使用当前的位置作为参考位置。如果它被设为2，那么该文件的末尾将作为参考位置。

### 重命名和删除文件

#### rename() 方法

rename() 方法需要两个参数，当前的文件名和新文件名。

语法：

```python
os.rename(current_file_name, new_file_name)
```

#### remove()方法

你可以用remove()方法删除文件，需要提供要删除的文件名作为参数。

语法：

```python
os.remove(file_name)
```

### Python里的目录

所有文件都包含在各个不同的目录下，不过Python也能轻松处理。os模块有许多方法能帮你创建，删除和更改目录。

#### mkdir()方法

可以使用os模块的mkdir()方法在当前目录下创建新的目录们。你需要提供一个包含了要创建的目录名称的参数。

语法：

```python
os.mkdir("newdir")
```

#### chdir()方法

可以用chdir()方法来改变当前的目录。chdir()方法需要的一个参数是你想设成当前目录的目录名称。

语法：

```
os.chdir("newdir")
```

例子：

下例将进入"/home/newdir"目录。

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
 
# 将当前目录改为"/home/newdir"
os.chdir("/home/newdir")
```

#### getcwd() 方法

getcwd()方法显示当前的工作目录。

语法：

```python
os.getcwd()
```

#### rmdir()方法

rmdir()方法删除目录，目录名称以参数传递。

在删除这个目录之前，它的所有内容应该先被清除。

语法：

```python
os.rmdir('dirname')
```

[File 对象方法](https://www.runoob.com/python/file-methods.html): file 对象提供了操作文件的一系列方法。

### OS 方法

[OS 对象方法](https://www.runoob.com/python/os-file-methods.html)

#### 获取 source_file 的 dir 和 文件名

你可以使用 Python 的 `os` 模块来获取文件路径的目录和文件名。以下是一个示例代码，演示如何从文件路径中提取目录和文件名：

```python
import os

# 定义源文件路径
source_file = 'path/to/source/file.txt'

# 获取文件的目录和文件名
file_dir = os.path.dirname(source_file) 
file_name = os.path.basename(source_file) 

# 获取父级文件名
file_name = os.path.basename(os.path.dirname(source_file) ) 

print(f'文件目录: {file_dir}')
print(f'文件名: {file_name}')
```

在这个示例中：

- `os.path.dirname(source_file)` 获取文件的目录路径。
- `os.path.basename(source_file)` 获取文件的文件名。

你可以将这些变量用于需要的地方。比如，在文件复制操作中，如果需要处理文件路径，可以使用这些变量来构造新的路径。

#### 读取文件

如果你想获取指定路径下的文件并读取其内容，可以使用 Python 的 `open` 函数来读取文件内容。以下是一个示例代码，演示如何读取文件内容：

```python
import os

# 定义源文件路径
source_file = 'path/to/source/file.txt'

# 获取文件的目录和文件名
file_dir = os.path.dirname(source_file)
file_name = os.path.basename(source_file)

print(f'文件目录: {file_dir}')
print(f'文件名: {file_name}')

# 读取文件内容
try:
    with open(source_file, 'r', encoding='utf-8') as file:
        file_content = file.read()
        print(f'文件内容:\n{file_content}')
except IOError as e:
    print(f'无法读取文件。错误: {e}')

```

在这个示例中：

1. `os.path.dirname(source_file)` 获取文件的目录路径。
2. `os.path.basename(source_file)` 获取文件的文件名。
3. 使用 `open` 函数以只读模式（`'r'`）打开文件，并使用 `file.read()` 方法读取文件的全部内容。

如果文件内容较大，可以考虑逐行读取以节省内存：

```python
try:
    with open(source_file, 'r', encoding='utf-8') as file:
        for line in file:
            print(line, end='')
except IOError as e:
    print(f'无法读取文件。错误: {e}')
```



### python 复制文件

#### 单文件

在 Python 中可以使用 `shutil` 模块来复制文件。以下是一个简单的示例代码，演示如何使用 `shutil.copyfile` 方法来复制文件：

```python
import shutil

# 定义源文件路径和目标文件路径
source_file = 'path/to/source/file.txt'
destination_file = 'path/to/destination/file.txt'

# 使用 shutil.copyfile 复制文件
try:
    shutil.copyfile(source_file, destination_file)
    print(f'文件已成功复制到 {destination_file}')
except IOError as e:
    print(f'无法复制文件。错误: {e}')
```

#### 文件夹

如果你需要复制整个目录，可以使用 `shutil.copytree` 方法。以下是一个示例：

```python
import shutil

# 定义源目录路径和目标目录路径
source_dir = 'path/to/source/directory'
destination_dir = 'path/to/destination/directory'

# 使用 shutil.copytree 复制目录
try:
    shutil.copytree(source_dir, destination_dir)
    print(f'目录已成功复制到 {destination_dir}')
except IOError as e:
    print(f'无法复制目录。错误: {e}')
```





## 枚举

### 初始化

```
from enum import Enum

class TaskStatusEnum(Enum):
    '''
    任务状态枚举 - .value 是字符串, 否则是枚举
    '''
    PENDING = "pending" # initial state
    IN_PROGRESS = "in_progress" # 处理中
    COMPLETED = "completed" # 已完成
    FAILED = "failed" # 失败
```

### 工厂模式与枚举结合

要将每个模型的处理逻辑直接写在 `Enum` 类中，而不通过 `if-else` 判断，解决方案可以是：为每个 `Enum` 成员定义自己的处理函数。这可以通过将每个 `Enum` 成员与一个处理器对象（或者直接是处理函数）关联起来。这样我们可以保持工厂模式的思想，并且避免在 `get_result` 中使用 `if-else` 判断。

1. 修改 `ModelType` 枚举，直接在 `Enum` 中绑定处理函数

```python

from enum import Enum

# 定义处理类，负责处理结果
class DamoyoloResultProcessor:
    @staticmethod
    def process(result):
        return f"{result}."  # DAMOYOLO 结果加 '.'

class GroundingDinoResultProcessor:
    @staticmethod
    def process(result):
        return result  # GROUNDINGDINO 结果原样返回


# 定义模型类型枚举
class ModelType(Enum):
    DAMOYOLO = ("model_damoyolo", {
        'ALL': "cow . sheep . ",  # 所有 - 未实现
        'COW': "cow",  # 牛
        'SHEEP': "sheep"  # 羊
    }, DamoyoloResultProcessor.process)  # 处理函数是 DamoyoloResultProcessor.process
    
    GROUNDINGDINO = ("model_groundingdino", {
        'ALL': "all animals",  # 所有
        'COW': "cow",  # 牛
        'SHEEP': "sheep"  # 羊
    }, GroundingDinoResultProcessor.process)  # 处理函数是 GroundingDinoResultProcessor.process

    def __init__(self, model_name, prompts, process_func):
        self.model_name = model_name
        self.prompts = prompts
        self.process_func = process_func  # 存储每个模型的处理函数

    # 根据 prompt 获取对应的结果并处理
    def get_result(self, prompt):
        # 将 prompt 转换为大写
        prompt_upper = prompt.upper()

        # 查找 prompt 对应的结果
        result = self.prompts.get(prompt_upper, "Prompt not found")

        # 使用每个模型特定的处理函数对结果进行处理
        return self.process_func(result)

# 使用示例
model = ModelType.DAMOYOLO
prompt = 'cow'
result = model.get_result(prompt)
print(f"Result for model {model.model_name} and prompt '{prompt}': {result}")

model = ModelType.GROUNDINGDINO
prompt = 'sheep'
result = model.get_result(prompt)
print(f"Result for model {model.model_name} and prompt '{prompt}': {result}")
```

1. **`DamoyoloResultProcessor` 和 `GroundingDinoResultProcessor`**：这两个类定义了静态方法 `process`，分别处理 `DAMOYOLO` 和 `GROUNDINGDINO` 的 `result`。
   - `DamoyoloResultProcessor.process` 会在结果后面加上 `.`。
   - `GroundingDinoResultProcessor.process` 直接返回结果。
2. **`ModelType` 枚举**：
   - 每个枚举成员 `DAMOYOLO` 和 `GROUNDINGDINO` 都关联了一个处理函数 (`process_func`)。
   - 在 `get_result` 方法中，直接调用每个模型的 `process_func`，而无需使用 `if-else` 判断模型类型。
3. **使用示例**：分别查询 `DAMOYOLO` 和 `GROUNDINGDINO` 模型的 `prompt`，并通过各自的处理函数处理结果。

输出示例：

```python
Result for model model_damoyolo and prompt 'cow': cow.
Result for model model_groundingdino and prompt 'sheep': sheep
```

- 每个 `Enum` 成员在定义时就绑定了处理逻辑，符合工厂模式的思想。
- 通过将处理逻辑与枚举值绑定，避免了在 `get_result` 方法中使用 `if-else`，保持了结构的清晰和易于扩展性。
- 增加新的模型时，只需为其定义新的处理函数，无需修改现有的代码逻辑。

##### 

# Python 模块

Python 模块(Module)，是一个 Python 文件，以 .py 结尾，包含了 Python 对象定义和Python语句。

模块让你能够有逻辑地组织你的 Python 代码段。

把相关的代码分配到一个模块里能让你的代码更好用，更易懂。

下例是个简单的模块 support.py：

```python
def print_func( par ):
   print "Hello : ", par
   return
```

> ### 搜索路径
>
> 当你导入一个模块，Python 解析器对模块位置的搜索顺序是：
>
> - 1、当前目录
> - 2、如果不在当前目录，Python 则搜索在 shell 变量 PYTHONPATH 下的每个目录。
> - 3、如果都找不到，Python会察看默认路径。UNIX下，默认路径一般为/usr/local/lib/python/。
>
> 模块搜索路径存储在 system 模块的 sys.path 变量中。变量里包含当前目录，PYTHONPATH和由安装过程决定的默认目录。
>
> ### PYTHONPATH 变量
>
> 作为环境变量，PYTHONPATH 由装在一个列表里的许多目录组成。PYTHONPATH 的语法和 shell 变量 PATH 的一样。

## 导入模块

### import 语句

当解释器遇到 import 语句，如果模块在当前的搜索路径就会被导入。

搜索路径是一个解释器会先进行搜索的所有目录的列表。如想要导入模块 support.py，需要把命令放在脚本的顶端：

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
# 导入模块
import support
 
# 现在可以调用模块里包含的函数了
support.print_func("Runoob")
```

### from…import 语句

Python 的 from 语句让你从模块中导入一个指定的部分到当前命名空间中。使用如下语句：

```python
from modname import name1[, name2[, ... nameN]]
```

### from…import * 语句

把一个模块的所有内容全都导入到当前的命名空间也是可行的，只需使用如下声明：

```python
from modname import *
```

> 注意: 
>
> + `from openai_exec import *` 与 `import openai_exec` 实际使用有什么区别
>
>   + `from openai_exec import *`
>
>     ```python
>     from openai_exec import *
>     
>     # Press the green button in the gutter to run the script.
>     if __name__ == '__main__':
>         msg: List[PerMessage] = []
>         excute(msg)
>     ```
>
>   + `import openai_exec`
>
>     ```python
>     import openai_exec
>                                                                     
>     # Press the green button in the gutter to run the script.
>     if __name__ == '__main__':
>         msg: List[openai_exec.PerMessage] = []
>         openai_exec.excute(msg)
>     ```
>
>   

## 查询模块定义

### dir()函数

dir() 函数返回的列表容纳了在一个模块里定义的所有模块，变量和函数。如下一个简单的实例：

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
# 导入内置math模块
import math
 
content = dir(math)
 
print content;
```

### globals() 和 locals() 函数

如果在函数内部调用 locals()，返回的是所有能在该函数里访问的命名。

如果在函数内部调用 globals()，返回的是所有在该函数里能访问的全局名字。

### reload() 函数

当一个模块被导入到一个脚本，模块顶层部分的代码只会被执行一次。因此，如果你想重新执行模块里顶层部分的代码，可以用 reload() 函数。

## Python中的包

包是一个分层次的文件目录结构，它定义了一个由模块及子包，和子包下的子包等组成的 Python 的应用环境。简单来说，包就是文件夹，但该文件夹下必须存在 `__init__.py` 文件, 该文件的内容可以为空。**__init__.py** 用于标识当前文件夹是一个包。

例如: 考虑一个在 **package_runoob** 目录下的 **runoob1.py、runoob2.py、__init__.py** 文件，test.py 为测试调用包的代码，目录结构如下：

```shell
test.py
package_runoob
|-- __init__.py
|-- runoob1.py
|-- runoob2.py
```

你可以放置许多函数。你也可以在这些文件里定义Python的类，然后为这些类建一个包。

### Numpy

Release Version: https://github.com/numpy/numpy/releases

v1 newest version: 1.26.4 `The Python versions supported by this release are 3.9-3.12`

### Time

#### 获取时间段

要判断一个时间是否处于每天的 8:00 到 18:00 之间，你可以将 `capture_time` 与特定的时间进行比较。你可以使用 Python 的 `datetime.time()` 来创建 8:00 和 18:00 这两个时间点，并与 `capture_time` 进行比较。

示例代码：

```
from datetime import time

# 将 capture_time 转换为时间对象
capture_time = time_tool.str_to_datetime(recognition.capture_time)

# 定义每天的起始时间和结束时间
start_time = time(8, 0)   # 8:00 AM
end_time = time(18, 0)    # 6:00 PM

# 提取 capture_time 的时间部分
capture_time_only = capture_time.time()

# 判断 capture_time 是否在 8:00 到 18:00 之间
if start_time <= capture_time_only <= end_time:
    print("Capture time is within 8:00 to 18:00.")
else:
    print("Capture time is outside 8:00 to 18:00.")
```

解释：

1. **`time(8, 0)` 和 `time(18, 0)`**：分别表示 8:00 AM 和 6:00 PM。
2. **`capture_time.time()`**：提取 `capture_time` 的时间部分，去掉日期，只保留小时和分钟。
3. **时间比较**：使用 `<=` 运算符来判断 `capture_time` 是否在 8:00 到 18:00 之间。

## Python Excel

### Read

```python
def test_rhs_excel():
	# 读取 Excel 文件
	df = pd.read_excel('/Users/vjf/Desktop/Book5.xlsx', header=None)
	
	# 逐行处理第一列
	for index, value in df[0].items():
		# 按多个空格分割
		parts = re.split(r'\s{2,}', str(value))
		if len(parts) > 1:
			# 将第二段内容存入第二列
			df.at[index, 1] = parts[1]
			# 更新第一列，去掉第二段
			df.at[index, 0] = parts[0]
		else:
			# 如果没有第二段，第二列设为空
			df.at[index, 1] = None
	
	# 将处理后的 DataFrame 保存到新的 Excel 文件
	df.to_excel('/Users/vjf/Desktop/Book5_out.xlsx', index=False, header=False)
```

### Write

```python
pip install openpyxl
```

```python
import pandas as pd

# Specify the output file name
output_file = 'merged_data.xlsx'

# Create an Excel writer using xlsxwriter engine
with pd.ExcelWriter(output_file, engine='xlsxwriter') as writer:
    # Write the DataFrame to Excel without headers
    merged_data.to_excel(writer, index=False, header=False, startrow=1)
    
    # Access the workbook and worksheet objects
    workbook  = writer.book
    worksheet = writer.sheets['Sheet1']
    
    # Define a header format without bold
    header_format = workbook.add_format({'bold': False})

    # Write the headers with the custom format
    for col_num, value in enumerate(merged_data.columns.values):
        worksheet.write(0, col_num, value, header_format)
    
    # Adjust column widths
    for idx, col in enumerate(merged_data.columns):
        # Calculate the maximum length of the column content
        max_length = max(merged_data[col].astype(str).map(len).max(), len(col))
        # Set the column width
        worksheet.set_column(idx, idx, max_length + 2)  # Add extra space
```

### shift_row_left demo

```python

def shift_row_left(df, index, col, next_col):
	df_col_length = len(df.columns)
	
	# 如果当前列超出边界，结束递归
	if next_col >= df_col_length:
		return
	
	print(f"行 {index + 1}, 列 {col + 1}: 为{df.iloc[index, col]}，开始左移处理")
	
	# 如果当前列为空，则将后面的数据左移
	if pd.isna(df.iloc[index, col]):
		
		# 将该行从 col 列开始的所有值左移一列
		for i in range(col, df_col_length - 1):
			df.iloc[index, i] = df.iloc[index, i + 1]
		
		# 每移动一次, 最后一列赋空
		df.iloc[index, df_col_length - 1] = None 
		
		next_col = next_col + 1
		
		# 递归处理，继续检查当前列
		shift_row_left(df, index, col, next_col)
		
	else:
		# 如果当前列不为空，则递归处理下一列
		col = col + 1
		shift_row_left(df, index, col, col + 1)


def test_rhs_excel_remove_none():
	# 读取 Excel 文件，禁用表头，确保第一行不会作为列名
	df = pd.read_excel('/Users/vjf/Desktop/Book4.xlsx', header=None)
	
	# 创建原数据的副本，确保不对原数据进行修改
	df_copy = df.copy()
	
	# 逐行处理数据
	for index in range(len(df_copy)):
		shift_row_left(df_copy, index, 0, 1)
	# shift_row_left(df_copy, 0, 0, 1)
	
	# 将处理后的数据保存到 'Book4_out.xlsx'
	df_copy.to_excel('/Users/vjf/Desktop/Book4_out.xlsx', index=False, header=False)
	
	# 输出提示信息
	print("处理后的数据已保存为 'Book4_out.xlsx'，原文件未修改。")
```

## Python 多线程

多线程编程中可能会遇到资源竞争问题，需要使用线程同步技术，如锁（Lock）来避免资源冲突。

```python
import threading
import time

# 创建一个锁对象
lock = threading.Lock()

def print_numbers():
    for i in range(10):
        with lock:  # 使用锁保护共享资源
            print(f"{threading.current_thread().name} - Number: {i}")
            time.sleep(1)

def print_letters():
    for letter in "abcdefghij":
        with lock:  # 使用锁保护共享资源
            print(f"{threading.current_thread().name} - Letter: {letter}")
            time.sleep(1)

thread1 = threading.Thread(target=print_numbers, name="Thread-1")
thread2 = threading.Thread(target=print_letters, name="Thread-2")

thread1.start()
thread2.start()

thread1.join()
thread2.join()

print("All threads have finished execution.")

```

### 无入参

下面是一个简单的示例，演示如何使用`threading`模块在Python中创建和管理多个线程：

```python
import threading
import time

# 定义一个函数，线程将要执行的任务
def print_numbers():
    for i in range(10):
        print(f"{threading.current_thread().name} - Number: {i}")
        time.sleep(1)

def print_letters():
    for letter in "abcdefghij":
        print(f"{threading.current_thread().name} - Letter: {letter}")
        time.sleep(1)

# 创建线程对象
thread1 = threading.Thread(target=print_numbers, name="Thread-1")
thread2 = threading.Thread(target=print_letters, name="Thread-2")

# 启动线程
thread1.start()
thread2.start()

# 等待所有线程完成
thread1.join()
thread2.join()

print("All threads have finished execution.")

```

### 多参数

使用 `executor.map` 或 使用 `lambda` 表达式 传递多个参数;  尽量避免使用 `functools.partial` 来实现

#### 使用 `executor.map` 传递多个参数

`executor.map` 允许你传递多个参数迭代器，它会将每个迭代器的元素作为对应参数传递给任务函数。

```python
from concurrent.futures import ThreadPoolExecutor
import time

def task(name, duration):
    print(f"Task {name} starting")
    time.sleep(duration)
    result = f"Task {name} completed in {duration} seconds"
    print(result)
    return result

# 创建一个线程池，最多有3个线程
with ThreadPoolExecutor(max_workers=3) as executor:
    names = range(5)
    durations = [1, 2, 3, 4, 5]
    
    # 使用 map 传递多个参数
    results = executor.map(task, names, durations)

    # 直接获取结果
    for result in results:
        print(result)

print("All tasks have been submitted and completed.")
```

在这个示例中：

1. **定义任务函数** `task`，它接受两个参数 `name` 和 `duration`。
2. **使用 `executor.map` 传递多个参数迭代器**，`names` 和 `durations`。

#### 使用 `lambda` 表达式

你还可以使用 `lambda` 表达式将多个参数传递给 `submit` 方法。

```python
from concurrent.futures import ThreadPoolExecutor
import time

def task(name, duration):
    print(f"Task {name} starting")
    time.sleep(duration)
    result = f"Task {name} completed in {duration} seconds"
    print(result)
    return result

# 创建一个线程池，最多有3个线程
with ThreadPoolExecutor(max_workers=3) as executor:
    futures = [executor.submit(lambda n=i, d=duration: task(n, d)) for i, duration in enumerate([1, 2, 3, 4, 5])]

    # 获取任务结果
    for future in futures:
        result = future.result()
        print(result)

print("All tasks have been submitted and completed.")
```

在这个示例中：

1. **定义任务函数** `task`，它接受两个参数 `name` 和 `duration`。
2. **使用 `lambda` 表达式** 将多个参数传递给 `submit` 方法。

#### 使用 `functools.partial`

使用 `functools.partial` 可以预先绑定一些参数到函数上，然后将剩余的参数传递给 `submit` 方法。如果你的函数需要四个参数，可以使用 `partial` 来绑定这些参数。

```python
from concurrent.futures import ThreadPoolExecutor
import time
from functools import partial

def task(name, duration, repeat):
    for _ in range(repeat):
        print(f"Task {name} starting")
        time.sleep(duration)
        print(f"Task {name} completed in {duration} seconds")
    return f"Task {name} completed {repeat} times"

# 创建一个线程池，最多有3个线程
with ThreadPoolExecutor(max_workers=3) as executor:
    futures = []
    for i in range(5):
        duration = i + 1
        repeat = 2
        partial_task = partial(task, i, duration)
        futures.append(executor.submit(partial_task, repeat))

    # 获取任务结果
    for future in futures:
        result = future.result()
        print(result)

print("All tasks have been submitted and completed.")
```

在这个示例中：

1. **定义任务函数** `task`，它接受两个参数 `name` 和 `duration`。
2. **使用 `partial` 预先绑定 `name` 参数**，然后将 `duration` 参数传递给 `submit` 方法。



> ` futures = [executor.submit( task(1, duration, 2)) for i, duration in enumerate([1, 2, 3, 4, 5])] 不能这样吗`
>
> 你的代码中存在一个问题：你在提交任务时，直接调用了函数 `task`，而不是将其作为一个可调用对象传递给 `submit` 方法。这导致 `task` 函数会立即执行，而不是在线程池中异步执行。

#### 报错

+ Unexpoected types: xxxx

  使用`默认参数`常遇到这个问题, 请当做必备参数处理

  



# Python 异常处理

## python标准异常

| 异常名称                  | 描述                                               |
| :------------------------ | :------------------------------------------------- |
|                           |                                                    |
| BaseException             | 所有异常的基类                                     |
| SystemExit                | 解释器请求退出                                     |
| KeyboardInterrupt         | 用户中断执行(通常是输入^C)                         |
| Exception                 | 常规错误的基类                                     |
| StopIteration             | 迭代器没有更多的值                                 |
| GeneratorExit             | 生成器(generator)发生异常来通知退出                |
| StandardError             | 所有的内建标准异常的基类                           |
| ArithmeticError           | 所有数值计算错误的基类                             |
| FloatingPointError        | 浮点计算错误                                       |
| OverflowError             | 数值运算超出最大限制                               |
| ZeroDivisionError         | 除(或取模)零 (所有数据类型)                        |
| AssertionError            | 断言语句失败                                       |
| AttributeError            | 对象没有这个属性                                   |
| EOFError                  | 没有内建输入,到达EOF 标记                          |
| EnvironmentError          | 操作系统错误的基类                                 |
| IOError                   | 输入/输出操作失败                                  |
| OSError                   | 操作系统错误                                       |
| WindowsError              | 系统调用失败                                       |
| ImportError               | 导入模块/对象失败                                  |
| LookupError               | 无效数据查询的基类                                 |
| IndexError                | 序列中没有此索引(index)                            |
| KeyError                  | 映射中没有这个键                                   |
| MemoryError               | 内存溢出错误(对于Python 解释器不是致命的)          |
| NameError                 | 未声明/初始化对象 (没有属性)                       |
| UnboundLocalError         | 访问未初始化的本地变量                             |
| ReferenceError            | 弱引用(Weak reference)试图访问已经垃圾回收了的对象 |
| RuntimeError              | 一般的运行时错误                                   |
| NotImplementedError       | 尚未实现的方法                                     |
| SyntaxError               | Python 语法错误                                    |
| IndentationError          | 缩进错误                                           |
| TabError                  | Tab 和空格混用                                     |
| SystemError               | 一般的解释器系统错误                               |
| TypeError                 | 对类型无效的操作                                   |
| ValueError                | 传入无效的参数                                     |
| UnicodeError              | Unicode 相关的错误                                 |
| UnicodeDecodeError        | Unicode 解码时的错误                               |
| UnicodeEncodeError        | Unicode 编码时错误                                 |
| UnicodeTranslateError     | Unicode 转换时错误                                 |
| Warning                   | 警告的基类                                         |
| DeprecationWarning        | 关于被弃用的特征的警告                             |
| FutureWarning             | 关于构造将来语义会有改变的警告                     |
| OverflowWarning           | 旧的关于自动提升为长整型(long)的警告               |
| PendingDeprecationWarning | 关于特性将会被废弃的警告                           |
| RuntimeWarning            | 可疑的运行时行为(runtime behavior)的警告           |
| SyntaxWarning             | 可疑的语法的警告                                   |
| UserWarning               | 用户代码生成的警告                                 |

## 异常处理

捕捉异常可以使用try/except语句。

try/except语句用来检测try语句块中的错误，从而让except语句捕获异常信息并处理。

如果你不想在异常发生时结束你的程序，只需在try里捕获它。

语法：

以下为简单的*try....except...else*的语法：

```python
try:
	<语句>        #运行别的代码
except <名字> as e:
	<语句>        #如果引发了'name'异常，获得附加的数据
else:
	<语句>        #如果没有异常发生
finally:
  <语句>
```

try的工作原理是，当开始一个try语句后，python就在当前程序的上下文中作标记，这样当异常出现时就可以回到这里，try子句先执行，接下来会发生什么依赖于执行时是否出现异常。

- 如果当try后的语句执行时发生异常，python就跳回到try并执行第一个匹配该异常的except子句，异常处理完毕，控制流就通过整个try语句（除非在处理异常时又引发新的异常）。
- 如果在try后的语句里发生了异常，却没有匹配的except子句，异常将被递交到上层的try，或者到程序的最上层（这样将结束程序，并打印默认的出错信息）。
- 如果在try子句执行时没有发生异常，python将执行else语句后的语句（如果有else的话），然后控制流通过整个try语句。



下面是简单的例子，它打开一个文件，在该文件中的内容写入内容，且并未发生异常：

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-

message = 1
try:
    print(f"{0/1}")
    raise Exception(message)  # 使用raise语句自己触发异常
except (BaseException, UserWarning) as e:
    print(f"error:{e}") # 打印异常
    print("error", e) 
    print(e.args) # 打印异常参数
finally: 
    print("finally") # finally语句
    
```

## 用户自定义异常

以下为与RuntimeError相关的实例,实例中创建了一个类，基类为RuntimeError，用于在异常触发时输出更多的信息。

```python
# Exception
class CustomException(RuntimeError):
    def __init__(self, *args): # 不定长参数
        self.args = args

try:
    raise CustomException(1, 2, 3)
except CustomException as e:
    print(f"e.args, {e.args}")


```

# Python 面向对象

## 面向对象技术简介

- **类(Class):** 用来描述具有相同的属性和方法的对象的集合。它定义了该集合中每个对象所共有的属性和方法。对象是类的实例。
- **类变量：**类变量在整个实例化的对象中是公用的。类变量定义在类中且在函数体之外。类变量通常不作为实例变量使用。
- **数据成员：**类变量或者实例变量, 用于处理类及其实例对象的相关的数据。
- **方法重写：**如果从父类继承的方法不能满足子类的需求，可以对其进行改写，这个过程叫方法的覆盖（override），也称为方法的重写。
- **局部变量：**定义在方法中的变量，只作用于当前实例的类。
- **实例变量：**在类的声明中，属性是用变量来表示的。这种变量就称为实例变量，是在类声明的内部但是在类的其他成员方法之外声明的。
- **继承：**即一个派生类（derived class）继承基类（base class）的字段和方法。继承也允许把一个派生类的对象作为一个基类对象对待。例如，有这样一个设计：一个Dog类型的对象派生自Animal类，这是模拟"是一个（is-a）"关系（例图，Dog是一个Animal）。
- **实例化：**创建一个类的实例，类的具体对象。
- **方法：**类中定义的函数。
- **对象：**通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法。

## 创建类

使用 class 语句来创建一个新类，class 之后为类的名称并以冒号结尾:

```python
class ClassName:
   '类的帮助信息'   #类文档字符串
   class_suite  #类体
```

类的帮助信息可以通过ClassName.__doc__查看。

class_suite 由类成员，方法，数据属性组成。

### 实例

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
class Employee:
   '所有员工的基类'
   empCount = 0 # empCount 变量是一个类变量，它的值将在这个类的所有实例之间共享。你可以在内部类或外部类使用 Employee.empCount 访问。
 

   def __init__(self, name, salary): # 第一种方法__init__()方法是一种特殊的方法，被称为类的构造函数或初始化方法，当创建了这个类的实例时就会调用该方法
      self.name = name # 
      self.salary = salary
      Employee.empCount += 1
   
   def displayCount(self):
     print "Total Employee %d" % Employee.empCount
 
   def displayEmployee(self):
      print "Name : ", self.name,  ", Salary: ", self.salary
```



- 
- 

> 注意: 
>
> + python 对象声明需在 code 之前, 否则会报错
>
> + python 方法入参为一个 list<Msg> 的对象
>
>   ```python
>   from typing import List
>   
>   class Msg:
>       # 假设 Msg 类有一些属性和方法
>       def __init__(self, content: str):
>           self.content = content
>   
>   def process_messages(messages: List[Msg]):
>       # 这里是处理 messages 的逻辑
>       for message in messages:
>           print(message.content)
>   ```
>
> + 初始化 list<Msg> 的对象

# Json

> 注意: 
>
> + List对象转 json
>
>   ```python
>   from pydantic import BaseModel
>
>
>   class PerMessage(BaseModel):
>       role: str
>       content: str
>
>   messages = [message.dict() for message in messages] # 转为 json 对象
>
>   ```
>   
>   ```

# 参考链接

+ Python关键字yield的解释(stackoverflow):   https://pyzh.readthedocs.io/en/latest/the-python-yield-keyword-explained.html#:~:text=yield%20%E6%98%AF%E4%B8%80%E4%B8%AA%E7%B1%BB%E4%BC%BC%20return,%E8%BF%94%E5%9B%9E%E7%9A%84%E6%98%AF%E4%B8%AA%E7%94%9F%E6%88%90%E5%99%A8%E3%80%82&text=%E8%BF%99%E4%B8%AA%E4%BE%8B%E5%AD%90%E6%B2%A1%E4%BB%80%E4%B9%88%E7%94%A8%E9%80%94%EF%BC%8C%E4%BD%86%E6%98%AF,%E8%BF%99%E6%9C%89%E7%82%B9%E8%B9%8A%E8%B7%B7%E4%B8%8D%E6%98%AF%E5%90%97%E3%80%82



# 问题
## 私有变量与私有成员
```
class Employ:
    _foo = 1 # 私有变量
    __foo = 2 # 私有成员
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def show(self):
        print("Employ")
        print(self.name, self.age)
        print(self._foo, self.__foo)
        print(Employ._foo, Employ.__foo)
        

emp = Employ('john', 30)
emp.name = 'jf' # 改变私有变量

Employ._foo = 3 # 改变类变量
Employ.__foo = 4

emp.show()
```

## 如果你想限定函数的参数类型，使其只接受List[Msg]类型的对象作为参数，可以使用类型注解来实现
```
def process_messages(messages: List[Msg]):
    for msg in messages:
        print(msg.content)
```

## python 指定函数返回类型
```
def chat() -> str:
```

## pip install httpx[socks]

pip install httpx[socks]     requirements.txt中已经有httpx[socks], 但是安装不上

因为版本冲突了, 需要制定特定版本
```
httpx[socks] == 1.0.0b0
```

## 类转为 json 对象

1. 继承 from pydantic import BaseModel
2. messages = [message.dict() for message in messages]  # 转为 json 对象

## 字符串转为指定对象
```
from pydantic import BaseModel

# 定义一个 Pydantic 模型
class Person(BaseModel):
    name: str
    age: int
    city: str

# JSON 字符串
json_string = '{"name": "张三", "age": 30, "city": "北京"}'

# 将 JSON 字符串转换为 Person 模型的实例
person = Person.parse_raw(json_string)
```

## 字符串转为指定list对象
```
	raw_data = json.loads(json_string)
	msg: List[openai_exec.PerMessage] = TypeAdapter(List[openai_exec.PerMessage]).validate_python(raw_data)
```

## 字符串转为 json 对象
```python
person = json.loads(json_string)
```

## 字符串转为 json 对象, 再转为 json 字符串
```
   formatted_json_general = json.loads(jsonStr_general)
   formatted_json_str_general = json.dumps(formatted_json_general, indent=2, ensure_ascii=False)
```

## API 接口改为入参是一个PerMessage对象数组,
```python

from pydantic import BaseModel

# 定义一个新的Pydantic模型，用于接收PerMessage对象的列表
class PerMessageList(BaseModel):
    messages: List[PerMessage]

@home_api.route('/welcome', methods=['POST'])  # 确保使用POST方法
def welcome():
    # 解析请求体中的JSON数据为PerMessageList对象
    data = PerMessageList.parse_obj(request.json)
```

## json 验证
```
def extract_json(text):
	match_general = re.search(r'\[[\s\S]*\](?=\s*)|\{[\s\S]*\}(?=\s*)', text)  # 匹配完整的JSON
	
	if match_general:
		jsonStr_general = match_general.group(0)
		# 尝试格式化捕获的JSON字符串以便清晰显示
		try:
			formatted_json_general = json.loads(jsonStr_general)
			formatted_json_str_general = json.dumps(formatted_json_general, indent=2, ensure_ascii=False)
			print("解析成功")
			return formatted_json_str_general
		except json.JSONDecodeError as e:
			print("解析错误:", e)
	else:
		print("没有找到JSON字符串")
	raise UserWarning('JSON解析错误')
```

## python 遍历 某目录下的包和文件, 并获取地址
```python

def walk_directory(directory, parent_name=None, depth=0):
	"""批量标注。
	Args:
		directory (str): 要遍历的目录路径。
		depth (int): 当前遍历的深度，用于可视化和理解递归深度。
		parent_name: str: 父目录名称。
	"""
	# 获取当前目录下的所有子目录和文件
	with os.scandir(directory) as entries:
		for entry in entries:
			if entry.is_dir():
				if depth == 0:
					parent_name = entry.name
				# 递归调用以遍历子目录
				walk_directory(entry.path, parent_name, depth + 1)
			elif entry.is_file():
				if parent_name is None:
					# 处理隐藏文件
					continue

```


## 使用追加模式打开文件, 如果文件不存在，在指定路径创建一个新文件，并写入指定的文本行。

   with open(file_path, 'w', encoding='utf-8') as file:
      file.write(parent_name + '\n')

## Shadows name 'detect_file' from outer scope   如何处理

使用全局变量
如果你需要在函数内部修改或访问全局变量，可以使用global关键字来声明该变量：

```python
detect_file = "path/to/file"

def process_file():
    global detect_file
    detect_file = "new/path/to/file"  # 修改全局变量
    print(detect_file)

process_file()
print(detect_file)
```

## format code & optimize code
-> tool -> Actions on save -> click `Optimize imports`

## 关闭 auto format
无解

##   count = 0  output_directory = 'captured_frames_' + count    报错

你在代码中遇到错误，可能是因为将整数变量 `count` 直接与字符串连接，导致类型不匹配的问题。你需要将整数 `count` 转换为字符串格式。可以使用 `str()` 函数将整数转换为字符串。

这里是修正后的代码：

```python


count = 0
output_directory = 'captured_frames_' + str(count)
```

通过将 `count` 变量转换为字符串，可以避免类型不匹配的错误。完整的代码示例如下：

```python


count = 0
output_directory = 'captured_frames_' + str(count)
print(output_directory)  # 输出: captured_frames_0
```

这样，你就可以正确地将整数变量 `count` 与字符串连接，生成所需的目录名称。

### 'NoneType' object has no attribute 'encode' 

检查入参是否为null

### python 如何获取某目录下的所有文件

```python
	fileDir = ''
	# os.walk生成目录树下的所有文件名
	for root, dirs, files in os.walk(fileDir):
		for file in files:
			# 将目录的路径和文件名合成一个完整的路径
			file_path = os.path.join(root, file)
```









