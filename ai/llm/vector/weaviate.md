

# 速查

下面汇总你当前安装的 weaviate/weaviate-client 4.18.0（Python 包 weaviate）的全部公开方法、调用方式与功能说明；若有多态/重载
  （参数取不同分支）也标出。同步与异步版本方法名一致，异步返回 Awaitable[...]，调用时换成 async 客户端即可。

## weaviate-ui
```shell
docker run -d \
  -p 8081:7777 \
  --name weaviate_ui \
  --restart unless-stopped \
  -e WEAVIATE_URL=http://172.16.69.222:8080 \
  -e WEAVIATE_API_KEYS=xxx \
  naaive/weaviate-ui:latest
```

##   顶层连接函数（weaviate 模块）

  - connect_to_local(host='localhost', port=8080, grpc_port=50051, headers=None, additional_config=None,
    skip_init_checks=False, auth_credentials=None) 连接本地。
  - connect_to_custom(http_host, http_port, http_secure, grpc_host, grpc_port, grpc_secure, headers=None,
    additional_config=None, auth_credentials=None, skip_init_checks=False) 自定义端口/协议。
  - connect_to_embedded(hostname='127.0.0.1', port=8079, grpc_port=50050, headers=None, additional_config=None,
    version='1.30.5', persistence_data_path=None, binary_path=None, environment_variables=None) 启动嵌入式。
  - connect_to_wcs(...)（4.6.2 起弃用）/connect_to_weaviate_cloud(cluster_url, auth_credentials, headers=None,
    additional_config=None, skip_init_checks=False) 连接 WCD。
  - 异步构造器：use_async_with_local / use_async_with_custom / use_async_with_embedded / use_async_with_weaviate_cloud，参数同
    上，返回 WeaviateAsyncClient。

##   客户端对象

  - WeaviateClient / WeaviateAsyncClient：connect()、close()、is_connected()、is_live()、is_ready()、get_meta()、
    get_open_id_configuration()、graphql_raw_query(gql_query)。

##   集合管理器：client.collections（_Collections）

  - list_all(simple=True) 列出所有集合配置；simple=True/False 为重载。
  - get(name, data_model_properties=None, data_model_references=None, skip_argument_validation=False) 获取现有集合对象（同步或
    异步）。
  - use(name, ...) 与 get 同，但总是同步集合。
  - create(name, *, description=None, generative_config=None, inverted_index_config=None, multi_tenancy_config=None,
    properties=None, references=None, replication_config=None, reranker_config=None, sharding_config=None,
    vector_index_config=None, vectorizer_config=None|list, vector_config=None|list, data_model_properties=None,
    data_model_references=None, skip_argument_validation=False) 创建集合并返回集合对象。
  - create_from_config(config_obj) / create_from_dict(config_dict)。
  - delete(name|[name])、delete_all()、exists(name)。
  - export_config(name) 导出集合配置。

##   集合实例：collection = client.collections.get("MyCollection")

  - 属性：consistency_level、tenant。
  - with_tenant(tenant|Tenant) 派生绑定指定租户的集合对象。
  - with_consistency_level(level) 派生绑定一致性级别的集合对象。
  - exists() 判断集合存在。
  - shards() 获取分片状态。
  - iterator(include_vector=False, return_metadata=None, *, return_properties=None|Type[DataModel], return_references=None|
    Type[RefModel]|QueryReference(s), after=None, cache_size=None) 迭代对象；重载：
        1. 仅 properties；2) properties + references；3) 指定数据模型类型；4) 指定引用查询（多 target）等。

##   聚合：collection.aggregate（_AggregateCollection）

  - over_all(*, filters=None, group_by=None|GroupByAggregate|str, total_count=True, return_metrics=None|MetricsText/Number/
    Date/Boolean/Reference|列表)
    重载：group_by=None 返回 AggregateReturn；group_by 给出 AggregateGroupByReturn。支持 metrics 列表、total_count。
  - hybrid(query, *, alpha=0.7, vector=None, query_properties=None, object_limit=None, bm25_operator=None, filters=None,
    group_by=None|GroupByAggregate|str, target_vector=None, max_vector_distance=None, total_count=True, return_metrics=None|
    列表)
    重载同 group_by：无 group_by 返回聚合结果，有 group_by 返回 group-by 聚合。
  - near_text(query, *, limit=None, move_to=None, move_away=None, certainty=None, distance=None, filters=None, group_by=None|
    GroupByAggregate|str, target_vector=None, return_metrics=None|列表, total_count=True)；group_by 有/无 两种返回。
  - near_vector(near_vector, *, limit=None, certainty=None, distance=None, filters=None, group_by=None|GroupByAggregate|str,
    target_vector=None, max_vector_distance=None, return_metrics=None|列表, total_count=True)；group_by 有/无 两种返回。
  - near_object(near_object, *, limit=None, certainty=None, distance=None, filters=None, group_by=None|GroupByAggregate|str,
    return_metrics=None|列表, total_count=True)；group_by 有/无 两种返回。
  - near_image(image: bytes|b64, *, limit=None, certainty=None, distance=None, filters=None, group_by=None|GroupByAggregate|
    str, return_metrics=None|列表, total_count=True)；group_by 有/无 两种返回。

##   查询：collection.query（_QueryCollection）

  每个查询都支持：limit/offset/after、filters、group_by、rerank、include_vector=False|str|[str]、return_metadata、
  return_properties（字段列表/嵌套/数据模型类型/True=全部）、return_references（引用查询/数据模型类型），返回 QueryReturn 或有
  group_by 时 GroupByReturn。

  - fetch_objects(*, limit=None, offset=None, after=None, filters=None, sort=None, include_vector=False, return_metadata=None,
    return_properties=None|bool|Type[DataModel], return_references=None|Type[RefModel])。
  - fetch_object_by_id(uuid, include_vector=False, *, return_properties=None|bool|Type[DataModel], return_references=None|
    Type[RefModel])。
  - fetch_objects_by_ids(ids, *, limit=None, offset=None, after=None, sort=None, include_vector=False, return_metadata=None,
    return_properties=None|bool|Type[DataModel], return_references=None|Type[RefModel])。
  - bm25(query, *, query_properties=None, limit=None, offset=None, operator=None, auto_limit=None, filters=None,
    group_by=None, rerank=None, include_vector=False, return_metadata=None, return_properties=None|bool|Type[DataModel],
    return_references=None|Type[RefModel])。
  - hybrid(query, *, alpha=0.7, vector=None (可传混合近文本/向量/多向量/多目标), query_properties=None, fusion_type=None,
    max_vector_distance=None, limit=None, offset=None, bm25_operator=None, auto_limit=None, filters=None, group_by=None,
    rerank=None, target_vector=None, include_vector=False, return_metadata=None, return_properties=None|bool|Type[DataModel],
    return_references=None|Type[RefModel])。
  - near_text(query, *, certainty=None, distance=None, move_to=None, move_away=None, limit=None, offset=None,
    auto_limit=None, filters=None, group_by=None, rerank=None, target_vector=None, include_vector=False, return_metadata=None,
    return_properties=None|bool|Type[DataModel], return_references=None|Type[RefModel])。
  - near_vector(near_vector, *, certainty=None, distance=None, limit=None, offset=None, auto_limit=None, filters=None,
    group_by=None, rerank=None, target_vector=None, include_vector=False, return_metadata=None, return_properties=None|bool|
    Type[DataModel], return_references=None|Type[RefModel])。
  - near_object(near_object, *, certainty=None, distance=None, limit=None, offset=None, auto_limit=None, filters=None,
    group_by=None, rerank=None, target_vector=None, include_vector=False, return_metadata=None, return_properties=None|bool|
    Type[DataModel], return_references=None|Type[RefModel])。
  - near_image(image: bytes|b64, *, certainty=None, distance=None, limit=None, offset=None, auto_limit=None, filters=None,
    group_by=None, rerank=None, target_vector=None, include_vector=False, return_metadata=None, return_properties=None|bool|
    Type[DataModel], return_references=None|Type[RefModel])。
  - near_media(media: bytes|b64, *, certainty=None, distance=None, limit=None, offset=None, auto_limit=None, filters=None,
    group_by=None, rerank=None, target_vector=None, media_type='image', include_vector=False, return_metadata=None,
    return_properties=None|bool|Type[DataModel], return_references=None|Type[RefModel])。

##   生成式查询：collection.generate（_GenerateCollection）

  与 query 方法名一一对应：fetch_objects、fetch_objects_by_ids、bm25、hybrid、near_text、near_vector、near_object、near_image、
  near_media。额外参数：

  - single_prompt（或 GroupedTask/grouped_task + grouped_properties）定义生成模板；支持 generative_provider 覆盖默认模型。
  - 其他参数与对应 query 方法一致（limit/filters/group_by/return_* 等），返回 GenerativeReturn 或 GenerativeGroupByReturn。

##   数据写入：collection.data（_DataCollection）

  - insert(properties, references=None, uuid=None, vector=None) 返回新 UUID。
  - insert_many(objects) 批量插入，返回批量结果。
  - update(uuid, properties=None, references=None, vector=None) 局部更新。
  - replace(uuid, properties, references=None, vector=None) 全量替换。
  - delete_by_id(uuid)。
  - delete_many(where_filters, *, verbose=False|True, dry_run=False) 重载：verbose=False 返回空/计数；verbose=True 返回被删对象
    列表。
  - exists(uuid)。
  - 参考操作：reference_add(from_uuid, from_property, to)、reference_add_many(refs)、reference_replace(from_uuid,
    from_property, to_many)、reference_delete(from_uuid, from_property, to)。
  - with_data_model(data_model_cls) 绑定数据模型类型。

##   Schema 配置：collection.config（_ConfigCollection）

  - get(simple=False|True) 重载：simple=True 仅基本信息；False 返回完整配置。
  - add_property(Property(...))。
  - add_reference(ReferenceProperty 或 _ReferencePropertyMultiTarget)。
  - add_vector(vector_config=VectorConfigCreate 或 NamedVectorConfigCreate，支持列表) 重载：向量或命名向量。
  - update(*, description=None, property_descriptions=None, inverted_index_config=None, multi_tenancy_config=None,
    replication_config=None, vector_index_config=None, vectorizer_config=None|list, vector_config=None|list,
    generative_config=None, reranker_config=None)。
  - get_shards()、update_shards(status='READY'|'READONLY', shard_names=None)。

##   批量：collection.batch（_BatchCollection，注意版本自动选择新/旧实现）

  - add_object(properties=None, references=None, uuid=None, vector=None) 入队。
  - add_reference(from_uuid, from_property, to|[to]|ReferenceToMulti) 入队。
  - flush() 发送并等待。
  - number_errors 返回累积错误数。

##   备份：collection.backup（_CollectionBackup）

  - create(backup_id, backend, wait_for_completion=False, config=None, backup_location=None)。
  - get_create_status(backup_id, backend, backup_location=None)。
  - restore(backup_id, backend, wait_for_completion=False, config=None, backup_location=None, overwrite_alias=False)。
  - get_restore_status(backup_id, backend, backup_location=None)。

##   租户：collection.tenants（_Tenants）

  - create(tenant|Tenant|TenantCreate|列表)、remove(tenant|列表)。
  - activate(...)、deactivate(...)、offload(...)。
  - update(Tenant|TenantUpdate|列表)。
  - exists(tenant)、get()、get_by_name(tenant)、get_by_names(tenants)。

##   对象迭代器：collection.iterator(...)

  - 返回 _ObjectIterator，支持 for obj in collection.iterator(...)；可带 after 游标、cache_size 批量预取；参见上方重载说明。

##   调用示例（同步版，异步版将 client 换成 async 并 await）

```

import weaviate
client = weaviate.connect_to_local(auth_credentials=weaviate.AuthApiKey("API_KEY"))

### 列出集合
print(client.collections.list_all())

### 获取集合
users = client.collections.get("UserProfile")

### Schema 变更 - ⭐️ 注意, weaviate 不支持删除 property
from weaviate.collections.classes.config import Property
users.config.add_property(Property(name="age", data_type="int"))

### 插入与查询
uid = users.data.insert({"name": "Alice", "age": 30})
res = users.query.fetch_object_by_id(uid, return_properties=True)
print(res.objects[0].properties)

### 聚合计数
agg = users.aggregate.over_all(total_count=True)
print(agg.total_count)

### 生成式查询

gen = users.generate.near_text("介绍一下 Alice", single_prompt="根据{{description}}生成一句简介", return_properties=True)
```

  上面覆盖了 weaviate/weaviate-client Python 4.18.0 的所有公开方法及其重载分支（按 namespace 列出）。如需具体类型签名，可直接在
  本环境用 inspect.signature(...) 查看对应方法（同步与异步同名）。

# weaviate 4.18.0 Python 客户端 API + 示例 + 字段说明（全用 `#` 注释）

> 说明：
>
> - 同步 / 异步方法名一致，异步只是在 async client 上 `await`。
> - 每个 API 先给「定义形式」，再给「示例」，两边的参数都用 `#` 写清含义。
> - 尽量贴合你原始示例，不乱改。

------

## 一、顶层连接函数（`weaviate` 模块）

### 1.1 本地连接：`connect_to_local`

```
import weaviate
from weaviate.classes.init import AuthApiKey

# ===================== API 定义 =====================
client = weaviate.connect_to_local(
    host="localhost",                       # HTTP 主机名，默认 "localhost"
    port=8080,                              # HTTP 端口，默认 8080
    grpc_port=50051,                        # gRPC 端口，默认 50051
    headers=None,                           # 附加 HTTP 请求头 dict，如 {"X-OpenAI-Api-Key": "..."}
    additional_config=None,                 # client 级别额外配置（超时、重试、连接池等）
    skip_init_checks=False,                 # 是否跳过初始化时的 /live /ready 健康检查
    auth_credentials=None,                  # 鉴权信息，如 AuthApiKey("...")，None 表示不鉴权
)

# ===================== 示例 =====================
client = weaviate.connect_to_local(
    host="localhost",                       # 本地 Weaviate
    port=8080,                              # HTTP 端口
    grpc_port=50051,                        # gRPC 端口
    headers={"X-OpenAI-Api-Key": "xxxxx"},  # 可选：给 text2vec-openai / generative-openai 用的 key
    additional_config=None,                 # 默认超时 / 重试配置
    skip_init_checks=False,                 # 连接时顺便做一次探活
    auth_credentials=AuthApiKey("MY_API_KEY")  # 可选：若启用 API Key 鉴权则必须设置
)
```

------

### 1.2 自定义 HTTP/gRPC：`connect_to_custom`

```
# ===================== API 定义 =====================
custom_client = weaviate.connect_to_custom(
    http_host="my-weaviate.example.com",    # HTTP 主机名或域名
    http_port=443,                          # HTTP 端口
    http_secure=True,                       # True = https，False = http
    grpc_host="my-weaviate.example.com",    # gRPC 主机名
    grpc_port=50051,                        # gRPC 端口
    grpc_secure=True,                       # True = TLS 加密的 gRPC，False = 明文
    headers=None,                           # 附加 HTTP 头
    additional_config=None,                 # client 额外配置
    auth_credentials=None,                  # AuthApiKey(...) 或其它鉴权方式
    skip_init_checks=False,                 # 是否跳过初始化健康检查
)

# ===================== 示例 =====================
custom_client = weaviate.connect_to_custom(
    http_host="my-weaviate.example.com",    # 部署在公网的域名
    http_port=443,                          # 标准 https 端口
    http_secure=True,                       # 使用 HTTPS
    grpc_host="my-weaviate.example.com",    # gRPC 同域
    grpc_port=50051,                        # gRPC 端口
    grpc_secure=True,                       # gRPC 也启用 TLS
    headers=None,                           # 这里暂时不用额外 header
    additional_config=None,                 # 使用默认 client 配置
    auth_credentials=AuthApiKey("MY_API_KEY"),  # 云端实例的 API Key
    skip_init_checks=False                  # 连接时做健康检查
)
```

------

### 1.3 嵌入式：`connect_to_embedded`

```
# ===================== API 定义 =====================
embedded_client = weaviate.connect_to_embedded(
    hostname="127.0.0.1",                   # HTTP 监听地址
    port=8079,                              # HTTP 端口
    grpc_port=50050,                        # gRPC 端口
    headers=None,                           # 附加 HTTP 头
    additional_config=None,                 # client 额外配置
    version="1.30.5",                       # 需要运行的 Weaviate 版本
    persistence_data_path=None,             # 数据持久化目录，为 None 时可能是临时目录
    binary_path=None,                       # Weaviate 二进制所在目录，None 时自动下载
    environment_variables=None,             # 传给嵌入式进程的环境变量 dict
)

# ===================== 示例 =====================
embedded_client = weaviate.connect_to_embedded(
    hostname="127.0.0.1",                   # 本机
    port=8079,                              # HTTP 端口
    grpc_port=50050,                        # gRPC 端口
    headers=None,                           # 无额外 header
    additional_config=None,                 # 默认 client 配置
    version="1.30.5",                       # 固定使用 1.30.5 版本
    persistence_data_path="./weaviate-data",# 数据持久化在本地目录
    binary_path=None,                       # 使用默认下载缓存路径
    environment_variables=None              # 不额外注入环境变量
)
```

------

### 1.4 Weaviate Cloud：`connect_to_weaviate_cloud`

```
# ===================== API 定义 =====================
cloud_client = weaviate.connect_to_weaviate_cloud(
    cluster_url="https://xxx.weaviate.network",  # WCD 集群 URL
    auth_credentials=None,                       # AuthApiKey("...") 等
    headers=None,                                # 附加 HTTP 头（如 OpenAI Key）
    additional_config=None,                      # client 额外配置
    skip_init_checks=False,                      # 是否跳过初始化健康检查
)

# ===================== 示例 =====================
from weaviate.classes.init import AuthApiKey

cloud_client = weaviate.connect_to_weaviate_cloud(
    cluster_url="https://my-wcd-cluster.weaviate.network",  # 控制台里复制的 URL
    auth_credentials=AuthApiKey("MY_WCD_API_KEY"),          # WCD 的 API Key
    headers={"X-OpenAI-Api-Key": "xxxxx"},                  # 给 text2vec-openai / generative-openai 用
    additional_config=None,                                 # 默认配置
    skip_init_checks=False                                  # 连接时检查 /live /ready
)
```

------

### 1.5 异步构造器：`use_async_with_local` 等

```
# ===================== API 定义 =====================
async_client = weaviate.use_async_with_local(
    host="localhost",                   # HTTP 主机
    port=8080,                          # HTTP 端口
    grpc_port=50051,                    # gRPC 端口
    headers=None,                       # 附加 HTTP 头
    additional_config=None,             # client 额外配置
    skip_init_checks=False,             # 是否跳过健康检查
    auth_credentials=None,              # 鉴权信息
)

# ===================== 示例 =====================
import asyncio
import weaviate
from weaviate.classes.init import AuthApiKey

async def main():
    async_client = weaviate.use_async_with_local(
        host="localhost",                   # 本地 HTTP
        port=8080,                          # HTTP 端口
        grpc_port=50051,                    # gRPC 端口
        headers=None,                       # 无额外 header
        additional_config=None,             # 默认 client 配置
        skip_init_checks=False,             # 检查 /live /ready
        auth_credentials=AuthApiKey("MY_API_KEY")  # API Key 鉴权
    )

    meta = await async_client.get_meta()    # 异步获取元信息
    print(meta)

    await async_client.close()              # 关闭 async client

asyncio.run(main())
```

> 同理还有：
> `use_async_with_custom(...)` / `use_async_with_embedded(...)` / `use_async_with_weaviate_cloud(...)`，参数与同步版一致。

------

## 二、客户端对象常用方法

```
client = weaviate.connect_to_local()

is_conn = client.is_connected()   # 检查 client 是否已经建立基础连接（本地状态）
is_live = client.is_live()        # 调 /live，检查服务“活着”与否
is_ready = client.is_ready()      # 调 /ready，检查是否“已准备好处理请求”

meta = client.get_meta()          # 获取 Weaviate 元信息，如版本号等
print("Weaviate version:", meta.version)

oidc = client.get_open_id_configuration()   # 获取 OIDC 配置（如启用 OIDC）
print("OIDC config:", oidc)

query_str = """
{
  Aggregate {
    UserProfile {
      meta {
        count
      }
    }
  }
}
"""
raw_res = client.graphql_raw_query(query_str)  # 原始 GraphQL 查询（兼容老代码）
print(raw_res)

client.close()                    # 关闭 client，释放连接
```

------

## 三、集合管理：`client.collections`（_Collections）

### 3.1 列出 / 判断 / 删除集合

```
from weaviate.collections.classes.config import Property, DataType

client = weaviate.connect_to_local()

# 列出所有集合（simple=True 默认，仅基本信息）
all_simple = client.collections.list_all(
    simple=True                     # True = 只返回基本信息，如 name / description
)
print(all_simple)

# 获取完整配置（simple=False）
all_full = client.collections.list_all(
    simple=False                    # False = 返回完整 schema 配置
)
print(all_full)

# 判断集合是否存在
exists = client.collections.exists(
    "UserProfile"                   # 集合名
)
print("UserProfile exists?", exists)

# 删除集合（单个）
if exists:
    client.collections.delete(
        "UserProfile"               # 要删除的集合名
    )

# 批量删除
client.collections.delete(
    ["Temp1", "Temp2"]              # 需要删除的一组集合名
)

# 删除所有集合（危险操作）
# client.collections.delete_all()  # 删除整个实例上的所有集合
```

------

### 3.2 创建 / 获取 / use 集合

```
from weaviate.collections.classes.config import (
    Property, DataType, VectorIndexConfig, Vectorizer, InvertedIndexConfig
)

# 创建集合并返回集合实例
users = client.collections.create(
    name="UserProfile",                      # 集合名
    description="User profile data",         # 描述信息
    generative_config=None,                 # 生成式设置（如 generative-openai），None = 不配置
    inverted_index_config=InvertedIndexConfig(
        # 文本倒排索引配置，通常默认即可
    ),
    multi_tenancy_config=None,              # 多租户配置，None = 不启用多租户
    properties=[
        Property(name="name", data_type=DataType.TEXT),  # TEXT 字段：name
        Property(name="age", data_type=DataType.INT),    # INT 字段：age
        Property(name="description", data_type=DataType.TEXT),  # TEXT 字段：description
    ],
    references=None,                        # 引用字段配置，None = 暂不配置引用
    replication_config=None,                # 副本配置（集群用）
    reranker_config=None,                   # 重排模型配置
    sharding_config=None,                   # 分片配置，None = 默认
    vector_index_config=VectorIndexConfig(),# 向量索引配置（如 HNSW 参数）
    vectorizer_config=Vectorizer.text2vec_openai(),  # 向量化配置，使用 text2vec-openai
    vector_config=None,                     # 命名向量配置，None = 单向量
    data_model_properties=None,             # Pydantic 等数据模型绑定，None = 不绑定
    data_model_references=None,             # 引用的数据模型绑定
    skip_argument_validation=False,         # 是否跳过参数校验，False = 开启校验
)

# 之后再获取
users2 = client.collections.get(
    "UserProfile"                           # 已存在的集合名
)

# use 与 get 功能类似，但总是同步集合（避免意外 async）
users3 = client.collections.use(
    "UserProfile"                           # 返回同步版本集合对象
)

# 从配置创建
config = client.collections.export_config(
    "UserProfile"                           # 导出该集合的完整配置
)
copy_users = client.collections.create_from_config(
    config                                  # 使用导出的配置创建副本
)

# 从 dict 创建
config_dict = {
    "name": "AnotherCollection",            # 集合名
    "description": "…",                     # 描述
    # ... 其余配置字段
}
another = client.collections.create_from_dict(
    config_dict                             # 基于 dict 创建集合
)
```

------

## 四、集合实例：基本属性 & iterator

```
users = client.collections.get("UserProfile")

# 设置一致性级别 / 租户（链式派生新对象）
users_quorum = users.with_consistency_level(
    "QUORUM"                                # 读写一致性级别：ONE / QUORUM / ALL
)
users_tenant = users.with_tenant(
    "tenant-a"                              # 多租户模式下的租户名
)

print(users.exists())                       # 再次确认集合是否存在

shards = users.shards()                     # 查看当前集合分片状态
print(shards)

# 对象迭代器（不带向量）
for obj in users.iterator(
    include_vector=False,                   # False = 不返回向量
    return_properties=True,                 # True = 返回所有属性
    return_references=None,                 # 不返回引用展开
    after=None,                             # 游标起点，None = 从头开始
    cache_size=128                          # 迭代器内部每次预取 128 个对象
):
    print(obj.uuid, obj.properties)         # 每个 obj 有 uuid 和 properties

# 使用数据模型类型
from pydantic import BaseModel

class UserModel(BaseModel):
    name: str
    age: int
    description: str | None = None

for obj in users.iterator(
    return_properties=UserModel,            # 自动把 properties 映射成 UserModel
):
    u: UserModel = obj.properties
    print(u.name, u.age)
```

------

## 五、聚合：`collection.aggregate`

### 5.1 `over_all`

```
from weaviate.classes.query import MetricsText, MetricsNumber, Filter

# 简单总数
agg = users.aggregate.over_all(
    filters=None,                           # 不加过滤，全表统计
    group_by=None,                          # 不分组
    total_count=True,                       # 返回总数
    return_metrics=None                     # 不计算额外 metrics
)
print("Total users:", agg.total_count)

# 带 metrics
agg2 = users.aggregate.over_all(
    filters=Filter.by_property("age").greater_than(18),  # 只统计 age > 18
    group_by=None,                          # 不分组
    total_count=True,                       # 返回总数
    return_metrics=[
        MetricsNumber(
            property="age",                 # 针对 age 字段
            name="age_stats",               # metrics 名字
            type="mean"                     # 计算均值（具体枚举看官方文档）
        ),
    ]
)
print(agg2.total_count, agg2.metrics)
```

------

### 5.2 `group_by` 聚合

```
from weaviate.classes.aggregate import GroupByAggregate

group = GroupByAggregate(
    property="age",                         # 按 age 分组
)

agg_gb = users.aggregate.over_all(
    filters=None,                           # 不过滤
    group_by=group,                         # 使用 GroupByAggregate
    total_count=True,                       # 每个 group 返回 count
    return_metrics=None,                    # 不计算 metrics
)

for g in agg_gb.groups:
    print("age =", g.value, "count =", g.total_count)
```

------

### 5.3 hybrid / near_text 聚合

```
# hybrid 聚合
agg_hybrid = users.aggregate.hybrid(
    query="developer",                      # 混合查询的文本部分
    alpha=0.7,                              # 向量 / 文本权重
    vector=None,                            # 可自带查询向量，None = 自动生成
    query_properties=["description"],       # BM25 参与字段
    object_limit=100,                       # 聚合时最多考虑 100 个对象
    bm25_operator=None,                     # BM25 运算符，None = 默认
    filters=None,                           # 过滤条件
    group_by=None,                          # 不分组
    target_vector=None,                     # 使用默认向量
    max_vector_distance=None,               # 不限制最大距离
    total_count=True,                       # 返回总数
    return_metrics=None,                    # 不计算 metrics
)
print(agg_hybrid.total_count)

# near_text 聚合
agg_nt = users.aggregate.near_text(
    query="software engineer",              # 文本查询
    limit=100,                              # 聚合时考虑的对象数上限
    filters=None,                           # 不加过滤
    group_by=None,                          # 不分组
    target_vector=None,                     # 默认向量
    total_count=True,                       # 返回总数
    return_metrics=None,                    # 不计算 metrics
)
print(agg_nt.total_count)
```

------

## 六、查询：`collection.query`

### 6.1 fetch_objects / fetch_object_by_id / fetch_objects_by_ids

```
from weaviate.classes.query import Filter

# 1) 按条件分页拉取对象
res = users.query.fetch_objects(
    limit=10,                               # 返回最多 10 条
    offset=0,                               # 从第 0 条开始（偏移分页）
    filters=Filter.by_property("age").greater_than(20),  # age > 20
    sort=[{"path": ["age"], "order": "desc"}],           # 按 age 倒序
    include_vector=False,                   # 不返回向量
    return_metadata=None,                   # 使用默认 metadata
    return_properties=True,                 # 返回所有属性
    return_references=None,                 # 不展开引用
)
for o in res.objects:
    print(o.uuid, o.properties)

# 2) 根据 ID 获取单个对象
uid = res.objects[0].uuid
single = users.query.fetch_object_by_id(
    uuid=uid,                               # 对象 UUID
    include_vector=False,                   # 不返回向量
    return_properties=True,                 # 返回所有属性
    return_references=None,                 # 不展开引用
)
print(single.objects[0].properties)

# 3) 根据 ID 列表批量获取
ids = [o.uuid for o in res.objects]
multi = users.query.fetch_objects_by_ids(
    ids,                                    # UUID 列表
    limit=None, offset=None, after=None,    # 通常 None 即可
    sort=None,                              # 不排序
    include_vector=False,                   # 不返回向量
    return_metadata=None,                   # 默认 metadata
    return_properties=True,                 # 返回所有属性
    return_references=None,                 # 不展开引用
)
print(len(multi.objects))
```

------

### 6.2 BM25 查询

```
from weaviate.classes.query import BM25, Filter

bm25_res = users.query.bm25(
    query="machine learning",               # 查询文本
    query_properties=["description"],       # 在 description 字段上做 BM25
    limit=5,                                # 返回 5 条
    offset=0,                               # 从第 0 条开始
    operator=BM25(operator="And"),          # 查询词之间用 AND 逻辑
    auto_limit=None,                        # 不使用 auto_limit
    filters=Filter.by_property("age").greater_than(18),  # 只看成年用户
    group_by=None,                          # 不分组
    rerank=None,                            # 不重排
    include_vector=False,                   # 不返回向量
    return_metadata=None,                   # 默认 metadata（含 score）
    return_properties=True,                 # 返回所有属性
    return_references=None,                 # 不展开引用
)
for o in bm25_res.objects:
    print(o.properties["name"], o.properties["description"])
```

------

### 6.3 hybrid 查询

```
hybrid_res = users.query.hybrid(
    query="data scientist",                 # 混合查询文本
    alpha=0.5,                              # 文本 / 向量各占一半
    vector=None,                            # 不自带向量
    query_properties=["description"],       # BM25 字段
    fusion_type=None,                       # 默认融合算法
    max_vector_distance=None,               # 不限制距离
    limit=10,                               # 返回 10 条
    offset=0,                               # 从第 0 条开始
    bm25_operator=None,                     # 默认 BM25 运算符
    auto_limit=None,                        # 默认候选数量
    filters=None,                           # 无额外过滤
    group_by=None,                          # 不分组
    rerank=None,                            # 不重排
    target_vector=None,                     # 默认向量
    include_vector=False,                   # 不返回向量
    return_metadata=None,                   # 默认 metadata（含 score）
    return_properties=True,                 # 返回所有属性
    return_references=None,                 # 不展开引用
)
for o in hybrid_res.objects:
    print(o.properties["name"], o.metadata.score)  # metadata.score 一般为相关度分
```

------

### 6.4 near_text / near_vector / near_object / near_image / near_media（重点）

```
# near_text
near_text_res = users.query.near_text(
    "software engineer",        # 文本查询，将被编码成向量
    certainty=None,             # 相似度置信度阈值（0~1），None = 不限制
    distance=None,              # 向量距离阈值，None = 不限制
    move_to=None,               # 向某些概念“靠近”的向量偏移（高级用法）
    move_away=None,             # 远离某些概念的偏移配置（高级用法）
    limit=5,                    # 返回 5 条最相似结果
    offset=0,                   # 偏移分页起点
    auto_limit=None,            # 内部候选数量上限，None = 默认
    filters=None,               # 结构化过滤，如 age > 20
    group_by=None,              # 分组设置，None = 不分组
    rerank=None,                # 重排配置
    target_vector=None,         # 命名向量名，None = 默认向量
    include_vector=False,       # 是否在结果中返回向量
    return_metadata=None,       # 元信息，如 score / distance
    return_properties=True,     # 返回所有属性
    return_references=None,     # 不展开引用
)

# near_vector
my_vector = [0.1, 0.2, 0.3]     # 示例查询向量
near_vec_res = users.query.near_vector(
    near_vector=my_vector,      # 显式指定查询向量
    certainty=None,             # 相似度置信度阈值
    distance=None,              # 最大距离阈值
    limit=5,                    # 返回数量
    offset=0,                   # 偏移分页
    auto_limit=None,            # 内部候选上限
    filters=None,               # 过滤条件
    group_by=None,              # 不分组
    rerank=None,                # 不重排
    target_vector=None,         # 使用默认向量空间
    include_vector=False,       # 不返回向量
    return_metadata=None,       # 默认 metadata
    return_properties=True,     # 返回所有属性
    return_references=None,     # 不展开引用
)

# near_object（用已有对象作为“示例”）
near_obj_res = users.query.near_object(
    near_object=uid,            # 某个已存在对象的 uuid，当成“样本”
    certainty=None,             # 相似度阈值
    distance=None,              # 距离阈值
    limit=5,                    # 返回数量
    offset=0,                   # 偏移分页
    auto_limit=None,            # 候选上限
    filters=None,               # 过滤条件
    group_by=None,              # 不分组
    rerank=None,                # 不重排
    target_vector=None,         # 命名向量名，None = 默认
    include_vector=False,       # 不返回向量
    return_metadata=None,       # 默认 metadata
    return_properties=True,     # 返回所有属性
    return_references=None,     # 不展开引用
)

# near_image / near_media：image = bytes 或 base64 字符串
with open("avatar.png", "rb") as f:
    img_bytes = f.read()        # 读取图片为 bytes

near_img_res = users.query.near_image(
    image=img_bytes,            # 图像 bytes 或 base64
    certainty=None,             # 相似度阈值
    distance=None,              # 距离阈值
    limit=5,                    # 返回数量
    offset=0,                   # 偏移
    auto_limit=None,            # 候选上限
    filters=None,               # 过滤
    group_by=None,              # 分组
    rerank=None,                # 重排
    target_vector=None,         # 使用哪个命名向量（image 向量等）
    include_vector=False,       # 不返回向量
    return_metadata=None,       # 默认 metadata
    return_properties=True,     # 返回所有属性
    return_references=None,     # 不展开引用
)

# near_media = 通用接口，可以指定 media_type，默认 'image'
near_media_res = users.query.near_media(
    media=img_bytes,            # 任意媒体 bytes/base64
    certainty=None,             # 相似度阈值
    distance=None,              # 距离阈值
    limit=5,                    # 返回数量
    offset=0,                   # 偏移
    auto_limit=None,            # 候选上限
    filters=None,               # 过滤
    group_by=None,              # 分组
    rerank=None,                # 重排
    target_vector=None,         # 命名向量名
    media_type="image",         # 媒体类型，默认 "image"
    include_vector=False,       # 不返回向量
    return_metadata=None,       # 默认 metadata
    return_properties=True,     # 返回所有属性
    return_references=None,     # 不展开引用
)
```

------

## 七、生成式查询：`collection.generate`

### 7.1 single_prompt 示例

```
from weaviate.classes.init import GenerativeConfig

# 假设集合本身已有 generative 配置（如 OpenAI）
users_gen = client.collections.get(
    "UserProfile"                      # 使用已有集合
)

gen_res = users_gen.generate.near_text(
    "介绍一下 Alice",                  # 检索文本（near_text 部分）
    single_prompt="根据以下用户信息生成一句简介：{{description}}",  # 每个对象的生成模板
    generative_provider=None,          # None = 使用集合默认 provider，可临时覆盖
    limit=1,                           # 检索 + 生成 1 条
    return_properties=True             # 同时返回原始属性
)

obj = gen_res.objects[0]
print("原始属性:", obj.properties)
print("生成结果:", obj.generated)      # generated 字段名视 SDK 实现而定
```

### 7.2 grouped_task 示例

```
grouped_res = users_gen.generate.hybrid(
    query="data engineer",             # hybrid 查询文本
    alpha=0.7,                         # hybrid 融合系数
    single_prompt=None,                # 不对单个对象生成
    grouped_task="根据所有用户的 {{name}} 与 {{description}} 生成一个团队总结",  # 汇总任务
    grouped_properties=["name", "description"],  # 汇总可用属性
    limit=10,                          # 检索上限 10 条
    return_properties=True             # 返回原始属性
)

print("汇总生成:", grouped_res.grouped) # grouped 字段为汇总生成结果
```

------

## 八、数据写入：`collection.data`

### 8.1 insert / update / replace / delete / exists

```
# 插入单对象
uid = users.data.insert(
    properties={
        "name": "Alice",               # 用户名
        "age": 30,                     # 年龄
        "description": "ML engineer",  # 描述
    },
    references=None,                   # 初始引用，None = 不设置
    uuid=None,                         # None = 自动生成 UUID
    vector=None                        # None = 使用集合 vectorizer 自动生成向量
)
print("New UUID:", uid)

# 批量插入
objects = [
    {"properties": {"name": "Bob", "age": 25}},   # 可以只放 properties
    {"properties": {"name": "Carol", "age": 28}},
]
insert_many_res = users.data.insert_many(
    objects                               # 批量对象列表
)
print(insert_many_res)

# 局部更新：只改某些字段
users.data.update(
    uuid=uid,                             # 要更新的对象 UUID
    properties={"age": 31},              # 只修改 age
    references=None,                     # 不改引用
    vector=None                          # 不改向量
)

# 全量替换：未提供的属性会被移除
users.data.replace(
    uuid=uid,                             # 要替换的对象 UUID
    properties={
        "name": "Alice",
        "age": 31,
        "description": "Senior ML engineer",
    },                                    # 新的完整属性集合
    references=None,                      # 新引用（如有）
    vector=None                           # 新向量（如有）
)

# 删除
users.data.delete_by_id(
    uid                                   # 通过 UUID 删除对象
)

# 判断对象是否存在
print(users.data.exists(uid))             # 删除后通常为 False
```

------

### 8.2 引用操作

```
# 假设有两个集合：UserProfile & Article
articles = client.collections.get("Article")

# 添加引用：UserProfile.wrote -> Article
users.data.reference_add(
    from_uuid="user-uuid",           # 源对象 UUID（UserProfile 中的某个用户）
    from_property="wrote",           # 源集合中引用字段名
    to="article-uuid"                # 目标对象 UUID，或列表，或 ReferenceToMulti
)

# 批量添加引用
refs = [
    {"from_uuid": "user-1", "from_property": "wrote", "to": "article-1"},
    {"from_uuid": "user-1", "from_property": "wrote", "to": "article-2"},
]
users.data.reference_add_many(
    refs                              # 多条引用操作
)

# 替换引用（多目标）
users.data.reference_replace(
    from_uuid="user-1",               # 源对象 UUID
    from_property="wrote",            # 引用字段名
    to_many=[
        "article-3",                  # 新引用目标列表
        "article-4",
    ]
)

# 删除引用
users.data.reference_delete(
    from_uuid="user-1",               # 源对象
    from_property="wrote",            # 引用字段
    to="article-4"                    # 要删除的目标 UUID
)
```

------

### 8.3 绑定数据模型

```
from pydantic import BaseModel

class UserModel(BaseModel):
    name: str
    age: int
    description: str | None = None

users_dm = users.data.with_data_model(
    UserModel                              # 绑定 Pydantic 模型
)

uid = users_dm.insert(
    UserModel(
        name="Dave",                       # name 字段
        age=26,                            # age 字段
        description="Backend dev"          # description 字段
    )
)

obj = users.query.fetch_object_by_id(
    uid,
    return_properties=UserModel            # 查询时也映射为 UserModel
)
user_model: UserModel = obj.objects[0].properties
print(user_model)
```

------

## 九、Schema 配置：`collection.config`

```
# simple=False：完整配置
config_full = users.config.get(
    simple=False                           # False = 返回完整配置
)
print(config_full)

# simple=True：只看核心信息
config_simple = users.config.get(
    simple=True                            # True = 简要视图
)
print(config_simple)
```

添加属性 / 引用 / 向量：

```
from weaviate.collections.classes.config import (
    Property, DataType, ReferenceProperty, VectorConfigCreate, NamedVectorConfigCreate
)

# 添加普通属性
users.config.add_property(
    Property(
        name="title",                      # 字段名
        data_type=DataType.TEXT           # 字段类型
    )
)

# 添加引用
users.config.add_reference(
    ReferenceProperty(
        name="friends",                   # 引用字段名
        target_collection="UserProfile"   # 目标集合名
    )
)

# 添加向量 / 命名向量
users.config.add_vector(
    vector_config=VectorConfigCreate(
        vectorizer=Vectorizer.text2vec_openai()  # 向量器配置
    )
)

users.config.add_vector(
    vector_config=[
        NamedVectorConfigCreate(
            name="default",               # 命名向量 default
            vectorizer=Vectorizer.text2vec_openai()
        ),
        NamedVectorConfigCreate(
            name="image",                 # 命名向量 image，通常用于图像
            vectorizer=Vectorizer.multi2vec_bind()
        )
    ]
)
```

更新配置 & 分片：

```
from weaviate.collections.classes.config import (
    InvertedIndexConfig, MultiTenancyConfig, ReplicationConfig,
    VectorIndexConfig, RerankerConfig, GenerativeConfig
)

users.config.update(
    description="Updated user profile collection",        # 新描述
    property_descriptions={"name": "User's name"},        # 字段描述
    inverted_index_config=InvertedIndexConfig(),          # 倒排索引配置
    multi_tenancy_config=MultiTenancyConfig(enabled=True),# 开启多租户
    replication_config=ReplicationConfig(),               # 副本配置
    vector_index_config=VectorIndexConfig(),              # 向量索引配置
    vectorizer_config=Vectorizer.text2vec_openai(),       # 向量器配置
    vector_config=None,                                   # 命名向量配置
    generative_config=GenerativeConfig(
        # 生成式配置内容，视 provider 而定
    ),
    reranker_config=RerankerConfig(
        # 重排器配置
    )
)

# 分片信息
shards = users.config.get_shards()       # 获取所有分片信息
print(shards)

# 更新分片状态
users.config.update_shards(
    status="READONLY",                   # 设置为只读（或 "READY"）
    shard_names=None                     # None = 应用于所有分片
)
```

------

## 十、批量：`collection.batch`

```
batch = users.batch                      # 获取批量操作对象

# 1) 批量添加对象
for i in range(10):
    batch.add_object(
        properties={"name": f"User {i}", "age": 20 + i},  # 对象属性
        references=None,                                  # 初始引用
        uuid=None,                                       # 自动生成 UUID
        vector=None                                      # 自动生成向量
    )

# 2) 批量添加引用
batch.add_reference(
    from_uuid="user-123",               # 源对象 UUID
    from_property="friends",            # 引用字段名
    to="user-456"                       # 目标对象 UUID（或列表）
)

# 3) 发出批量请求
batch.flush()                           # 发送所有缓冲的 batch 操作

# 4) 错误数量
print("Number of batch errors:", batch.number_errors)  # 上一批 flush 的错误数
```

------

## 十一、备份：`collection.backup`

```
# 创建备份（不等待）
backup_res = users.backup.create(
    backup_id="backup-2024-01-01",      # 备份 ID
    backend="filesystem",               # 后端类型，如 filesystem/s3 等
    wait_for_completion=False,          # False = 异步创建
    config=None,                        # 后端配置，如路径、bucket 等
    backup_location="/backups/weaviate" # 备份位置/路径
)
print(backup_res)

# 查询备份创建状态
status = users.backup.get_create_status(
    backup_id="backup-2024-01-01",      # 对应备份 ID
    backend="filesystem",               # 同 create 中 backend
    backup_location="/backups/weaviate" # 同 create 中 backup_location
)
print(status)

# 恢复备份（可选择覆盖 alias）
restore_res = users.backup.restore(
    backup_id="backup-2024-01-01",      # 要恢复的备份 ID
    backend="filesystem",               # 后端类型
    wait_for_completion=False,          # False = 异步恢复
    config=None,                        # 恢复相关配置
    backup_location="/backups/weaviate",# 备份路径
    overwrite_alias=False               # 是否覆盖已有 alias
)
print(restore_res)

# 查询恢复状态
restore_status = users.backup.get_restore_status(
    backup_id="backup-2024-01-01",      # 同上
    backend="filesystem",               # 同上
    backup_location="/backups/weaviate" # 同上
)
print(restore_status)
```

------

## 十二、多租户：`collection.tenants`

```
from weaviate.collections.classes.tenants import Tenant, TenantCreate, TenantUpdate

# 创建租户（单个或列表）
users.tenants.create(
    TenantCreate(
        name="tenant-a",                # 租户名
        description="Tenant A"          # 描述
    )
)
users.tenants.create([
    TenantCreate(name="tenant-b"),      # 第二个租户
    TenantCreate(name="tenant-c"),      # 第三个租户
])

# 租户状态变更
users.tenants.activate("tenant-a")      # 激活租户
users.tenants.deactivate("tenant-b")    # 停用租户
users.tenants.offload("tenant-c")       # 卸载租户数据（释放资源）

# 更新租户
users.tenants.update(
    TenantUpdate(
        name="tenant-a",                # 要更新的租户名
        description="Updated tenant A"  # 新描述
    )
)

# 查询租户
print(users.tenants.exists("tenant-a")) # 检查是否存在
all_tenants = users.tenants.get()       # 获取所有租户
print(all_tenants)

t = users.tenants.get_by_name("tenant-a")          # 获取单个租户详情
print(t)

ts = users.tenants.get_by_names(["tenant-a", "tenant-b"])  # 批量获取
print(ts)

# 绑定租户集合对象后再操作数据/查询
tenant_a_users = users.with_tenant(
    "tenant-a"                            # 将集合绑定到 tenant-a
)
res = tenant_a_users.query.fetch_objects(
    limit=5,                              # 返回 5 条
    return_properties=True                # 返回所有属性
)
```

------

## 十三、对象迭代器：游标 + 批量示例

```
after = None
while True:
    it = users.iterator(
        include_vector=False,              # 不返回向量
        return_properties=["name", "age"], # 只取 name / age
        after=after,                       # 上一次游标位置
        cache_size=100,                    # 每批预取 100 条
    )

    batch_count = 0
    for obj in it:
        batch_count += 1
        print(obj.uuid, obj.properties)
        after = obj.uuid                   # 更新游标为当前对象 UUID

    if batch_count == 0:                   # 没有更多数据，退出
        break
```

------

## 十四、异步整体示例（收尾）

```
import asyncio
import weaviate
from weaviate.classes.init import AuthApiKey
from weaviate.collections.classes.config import Property, DataType

async def async_flow():
    client = await weaviate.use_async_with_local(
        auth_credentials=AuthApiKey("MY_API_KEY")  # 异步 client 鉴权
    )

    # 创建集合
    users = await client.collections.create(
        name="AsyncUser",                       # 集合名
        properties=[
            Property(name="name", data_type=DataType.TEXT),  # TEXT 字段
            Property(name="age", data_type=DataType.INT),    # INT 字段
        ]
    )

    # 写入
    uid = await users.data.insert(
        {"name": "Async Alice", "age": 24}      # 要插入的属性 dict
    )

    # 查询
    res = await users.query.fetch_object_by_id(
        uid,
        return_properties=True                  # 返回所有属性
    )
    print(res.objects[0].properties)

    # 聚合
    agg = await users.aggregate.over_all(
        total_count=True                        # 只要总数
    )
    print("Total:", agg.total_count)

    # 生成式（假设已配置 generative）
    # gen = await users.generate.near_text(
    #     "介绍一下 Async Alice",              # near_text 查询
    #     single_prompt="根据 {{name}} 和 {{age}} 生成一句简介",  # single_prompt 模板
    #     return_properties=True
    # )
    # print(gen.objects[0].generated)

    await client.close()                        # 关闭 async client

asyncio.run(async_flow())
```

------
