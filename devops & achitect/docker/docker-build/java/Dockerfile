# syntax=docker/dockerfile:1

############################
# Build stage
############################
FROM eclipse-temurin:17-jre-jammy

# ===== 代理（构建阶段用：maven 拉依赖）=====
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG http_proxy
ARG https_proxy
ENV HTTP_PROXY=${HTTP_PROXY} \
    HTTPS_PROXY=${HTTPS_PROXY} \
    http_proxy=${http_proxy} \
    https_proxy=${https_proxy}

WORKDIR /app

ARG APP_JAR_NAME
# 再拷贝源码并打包
COPY ${APP_JAR_NAME} /app/app.jar

RUN mkdir -p /app/logs
# 与 config.port 一致
EXPOSE 8000

# CMD ["tail", "-f", "/dev/null"]

ENV JAVA_OPTS=" -Duser.timezone=GMT+08 "
CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]