#!/bin/bash

SpringBoot=$2

#JVM参数
START_OPTS="-Dname=$SpringBoot -Xms512m -Xmx4g -Xmn512m  -Xss256k --add-opens java.base/java.lang=ALL-UNNAMED --spring.profiles.active=prod "
APP_HOME=`pwd`
LOG_PATH=$APP_HOME/logs/$SpringBoot.log

if [ "$1" = "" ];
then
    echo -e "\033[0;31m 未输入操作名 \033[0m  \033[0;34m {start|stop|restart|status} \033[0m"
    exit 1
fi

if [ "$SpringBoot" = "" ];
then
    echo -e "\033[0;31m 未输入应用名 \033[0m"
    exit 1
fi

function start()
{
    count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`
    if [ $count != 0 ];then
        echo "$SpringBoot is running..."
    else
        echo "starting $SpringBoot ..."
        echo "nohup java -jar  $SpringBoot  $START_OPTS> out.file 2>&1 &"
        nohup java -jar  $SpringBoot  $START_OPTS> out.file 2>&1 &
    fi
    
    # 查询日志检测java程序是否启动成功
    echo "$(date "+%Y-%m-%d %H:%M:%S") checking if started ..."
    while [ -f $LOG_PATH ]
    do
        current=`date +%Y-%m-%d\ %H:%M`
        result=`grep "Started GtApplication"`
    echo `result : "$result"`
        if [[ "$result" != "" ]]
        then
            echo "$(date "+%Y-%m-%d %H:%M:%S") springboot start ..."
            break
        else
            echo "$(date "+%Y-%m-%d %H:%M:%S") waiting for start..."
            sleep 5s
        fi
    done

    echo "$(date "+%Y-%m-%d %H:%M:%S") $SpringBoot started success."
}

function stop()
{
    # rm -ri ./out.file
    echo "Stop $SpringBoot"
    boot_id=`ps -ef |grep java|grep $SpringBoot|grep -v grep|awk '{print $2}'`
    count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`

    if [ $count != 0 ];then
        kill $boot_id
        count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`

        boot_id=`ps -ef |grep java|grep $SpringBoot|grep -v grep|awk '{print $2}'`
        kill -9 $boot_id
    fi
}

function restart()
{
    stop
    sleep 2
    start
}

function status()
{
    count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`
    if [ $count != 0 ];then
        echo "$SpringBoot is running..."
    else
        echo "$SpringBoot is not running..."
    fi
}

case $1 in
    start)
    start;;
    stop)
    stop;;
    restart)
    restart;;
    status)
    status;;
    *)

    echo -e "\033[0;31m Usage: \033[0m  \033[0;34m sh  $0  {start|stop|restart|status}  {SpringBootJarName} \033[0m
\033[0;31m Example: \033[0m
      \033[0;33m sh  $0  start esmart-test.jar \033[0m"
esac
