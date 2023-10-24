## nacos, 使用@RefreshScope注解来标记需要动态刷新的Bean

## spring-boot 启动时传入 nacos 用户名和密码

--spring.cloud.nacos.username=your-username --spring.cloud.nacos.password=your-password

# nacos 相关API
## nacos 获取 token
NACOS_SERVER="http://localhost:8848/nacos"  # Nacos 服务地址
NAMESPACE="test"  # 你的命名空间 ID

USERNAME="nacos"  # 你的 Nacos 用户名
PASSWORD="nacos"  # 你的 Nacos 密码

auth_url="${NACOS_SERVER}/v1/auth/users/login"

token=$(curl -s -X POST "${NACOS_SERVER}/v1/auth/users/login" -d "username=${USERNAME}&password=${PASSWORD}" | awk -F'"accessToken":"' '{print $2}' | awk -F'"' '{print $1}')

## 新建namespace
curl -X POST "$NACOS_SERVER/v1/console/namespaces" \
     -H "Authorization: Bearer $token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "customNamespaceId=$NAMESPACE" \
     -d "namespaceName=$NAMESPACE" \
     -d "namespaceDesc=$NAMESPACE" \
     -d "namespaceId=$NAMESPACE"

## 上传 配置文件到 nacos 的配置中心

for config in /home/nacos/init.d/test/*/*.yml; do
    if [ "$(basename $config)" = "x1.yml" ]; then
        GROUP="GROUP1"
    else
        GROUP="GROUP2"
    fi

    curl -X POST "$NACOS_SERVER/v1/cs/configs" \
        -H "Authorization: Bearer $token" \
        --data-urlencode "dataId=$(basename $config)" \
        --data-urlencode "group=$GROUP" \
        --data-urlencode "content=$(cat $config)" \
        --data-urlencode "tenant=$NAMESPACE" \
        -d "type=yaml"
done

# 启动 nacos 并完成配置文件初始化 start.sh 如下

## Start docker-startup.sh
/home/nacos/bin/docker-startup.sh -m standalone &

## Get the PID of docker-startup.sh
NACOS_PID=$!

## Wait for Nacos to start
until nc -z localhost 8848; do 
    echo 'Waiting for Nacos'
    sleep 5
done

## Run load-configs.sh
/home/nacos/init.d/upload-nacos.sh

## Wait for docker-startup.sh to finish (this will keep it in the foreground)
wait $NACOS_PID

# docker-compose 挂载指定目录, 并完成配置文件初始化

    volumes:
      - /root/docker-compose/configs/fe:/home/nacos/init.d
    entrypoint: ["/bin/sh", "-c", "/home/nacos/init.d/start.sh"]

> 注意: /bin/sh: /home/nacos/init.d/start.sh: Permission denied
> chmod +x /path/to/your/local/directory/start.sh

