# 基本类型

## 1. 🔌 连接

```
import weaviate

client = weaviate.connect_to_local(
	  host="host",
    port=8080,
    grpc_port=50051
)
```

Cloud API:

```
client = weaviate.connect_to_weaviate_cloud(
    cluster_url="https://xxxxx.weaviate.network",
    auth_credentials=weaviate.AuthApiKey("YOUR_KEY")
)
```

------

## 2. 📌 查看 Weaviate 元信息

```
meta = client.misc.get_meta()
print(meta)
```

------

## 3. 📚 Collection 管理（类似原来的 Class）

### 创建 Collection：

```
	client.collections.create(name="UserProfile", properties=[Property(name="user_id", data_type=DataType.TEXT),
															  Property(name="raw_text", data_type=DataType.TEXT),
															  Property(name="metadata", data_type=DataType.TEXT),
															  Property(name="dims_json", data_type=DataType.TEXT),
															  Property(name="profile_text", data_type=DataType.TEXT), ],
							  # 自己提供向量的场景
							  vector_config=Configure.Vectors.self_provided(
								  vector_index_config=Configure.VectorIndex.hnsw(ef_construction=128,
																				 max_connections=64, )), )
```

### 查看所有 Collections：

```
client.collections.list_all()
```

## 4. 📝 插入对象

### 先获取某个 Collection：

```
articles = client.collections.get("Article")
```

### 简单插入

```
uuid = articles.data.insert(article)
print(uuid)
```

### 插入时附带向量

```
articles.data.insert(
    properties=article,
    vector=[0.22, 0.18, ...]   # 如果手动计算
)
```

------

## 5. 🔍 查询（最常用）

### 5.1 全部数据

```
results = articles.query.fetch_objects()
print(results.objects)
```

------

### 5.2 Filter 查询（where）

```
from weaviate.classes.query import Filter

results = articles.query.fetch_objects(
    filters=Filter.by_property("title").equal("Weaviate v4 Guide")
)
```

------

### 5.3 向量搜索

```
vector = [0.1, 0.2, ...]  # 你的向量

results = articles.query.near_vector(vector=vector, limit=5)

for obj in results.objects:
    print(obj.properties)
```

------

### 5.4 Hybrid（关键词 + 向量）

```
results = articles.query.hybrid(
    query="weaviate api",
    alpha=0.5,       # 混合比例（文本 vs 向量）
    limit=5
)
```

------

### 5.5 BM25（全文搜索）

```
results = articles.query.bm25(
    query="Rust architecture",
    limit=5
)
```

------

## 6. 🎯 获取单条对象（by UUID）

```
obj = articles.query.fetch_object_by_id(uuid)
print(obj.properties)
```

------

## 7. ⚡ 批量写入（v4 大幅提升性能）

```
with articles.batch.fixed_size(batch_size=100) as batch:
    for i in range(1000):
        batch.add_object({
            "title": f"doc {i}",
            "content": "Some text..."
        })
```

------

# 8. ❌ 删除数据

```
articles.data.delete_by_id(uuid)
```

按 filter 删除：

```
from weaviate.classes.query import Filter

articles.data.delete_many(
    where=Filter.by_property("title").contains("doc")
)
```

------

# 9. 🗑 删除 Collection

```
client.collections.delete("Article")
```

## Collection

```
from weaviate.classes.config import Property, DataType, Configure

client.collections.create(
    name="UserProfile",
    properties=[
        Property(name="user_id",      data_type=DataType.TEXT),
        Property(name="raw_text",     data_type=DataType.TEXT),
        Property(name="metadata",     data_type=DataType.TEXT),
        Property(name="dims_json",    data_type=DataType.TEXT),
        Property(name="profile_text", data_type=DataType.TEXT),
    ],
    vector_config=Configure.Vectors.self_provided(   # 自己提供向量的场景
        vector_index_config=Configure.VectorIndex.hnsw(
            ef_construction=128,
            max_connections=64,
        )
    ),
)
```

