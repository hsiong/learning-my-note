
# https://www.mls-tech.info/python/python-init-list-method/
# Python中初始化列表(List)的几种方法
# 1. 使用循环进行初始化
lst = []
for i in range(1000000):
    lst.append(0)

# 2. 使用 [ value for i in range(length)] 语法
lst = [0 for i in range(1000000)]

# 3. 使用 [value] * length 语法
lst = [0] * 1000000


# if - else
# if 判断条件：
#     执行语句……
# else：
#     执行语句……

flag = False
name = 'luren'
if name == 'python':         # 判断变量是否为 python 
    flag = True              # 条件成立时设置标志为真
    print 'welcome boss'     # 并输出欢迎信息
else:
    print name               # 条件不成立时输出变量名称