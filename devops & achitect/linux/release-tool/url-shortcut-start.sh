#!/bin/bash 
# -x 打印执行命令
# -e 脚本只要发生错误，就终止执行;这句语句告诉bash如果任何语句的执行结果不是true则应该退出
set -e

rftyDir='/root/backend/url-shortcut/'
backDir=`date +%Y%m%d`
tempDir='temp'
jarReg='project-URL-shortcut.jar'
shFile='/root/backend/push.sh'
newLibsFile=''
newJarFile=''
oldLibsFile=''
oldJarFile=''

cd $rftyDir

# 临时上传文件夹
if [ ! -d $tempDir ]; then
	# 不存在
	mkdir $tempDir
fi

# 在temp目录查找新的部署文件
for filename in $(ls $tempDir)
do
	if [[ $(expr "$filename" : "$jarReg") > 0 ]]; then
		newJarFile=$filename
		echo 'newJarFile: '$newJarFile 
	fi
done

# 判断文件是否存在
if [[ !(${newJarFile}) ]]; then
	echo '$tempDir: 新的部署jar或lib文件不存在!'
	exit 1
fi

# 判断备份文件夹
if [ ! -d $backDir ];then
	# 不存在
	mkdir $backDir
else
	# 存在一个
	backDir=${backDir}'-2'
	mkdir $backDir
fi

# 在当前目录查找旧的部署文件
for filename in $(ls)
do
	if [[ $(expr "$filename" : "$jarReg") > 0 ]]; then
		oldJarFile=$filename
		echo 'oldJarFile: '$oldJarFile
		# 备份文件			
		cp $oldJarFile ./$backDir
		# 结束进程
		sh $shFile stop $oldJarFile && rm -rf $oldJarFile
	fi
done


# 重启进程
mv $tempDir/$newJarFile ./

sh $shFile start $rftyDir$newJarFile

export tempPath=$(pwd)
echo $jarReg' output: '$tempPath/out.file
