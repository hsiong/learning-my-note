
# https://www.cnblogs.com/liftsail/p/16087127.html
# 依赖java8ub
FROM openjdk:11
# 创建者
MAINTAINER xtam
# 8081
EXPOSE 8081
# 不确定jar名字可以写*.jar 即为所以
ADD ./test.jar ~/test.jar
RUN mkdir -p ~/log
# 挂载目录
VOLUME /tmp
# 生产环境启动 可以写#容器已启动 默认运行命令 java -jar app.jar
ENTRYPOINT ["java","-jar","~/dkyedge.jar","--spring.profiles.active=prod", ">", "~/log/out.file", "2>&1", "&"]