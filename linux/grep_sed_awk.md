
https://www.cnblogs.com/along21/p/10366886.html
# grep



# awk 

-F fs：fs指定输入分隔符，fs可以是字符串或正则表达式，如-F:
 -v var=value：赋值一个用户定义变量，将外部变量传递给awk
 -f scripfile：从脚本文件中读取awk命令
 
>  FS ：输入字段分隔符，默认为空白字符
>  OFS ：输出字段分隔符，默认为空白字符
>  RS ：输入记录分隔符，指定输入时的换行符，原换行符仍有效
>  ORS ：输出记录分隔符，输出时用指定符号代替换行符
>  NF ：字段数量，共有多少字段， $NF引用最后一列，$(NF-1)引用倒数第2列
>  NR ：行号，后可跟多个文件，第二个文件行号继续从第一个文件最后行号开始
>  FNR ：各文件分别计数, 行号，后跟一个文件和NR一样，跟多个文件，第二个文件行号从1开始
>  FILENAME ：当前文件名
>  ARGC ：命令行参数的个数
>  ARGV ：数组，保存的是命令行所给定的各参数，查看参数

# sed



# xargs
管道命令

# search java loc
ps aux | grep java | awk '{if(NR>=2) print $2 ","}' |xargs |sed 's/ //g' | sed -e 's/\(.*\),/\1/' | xargs top -bcp
