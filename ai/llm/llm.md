

# 常见问题

### oceanbase 混合检索如何实现

#### 一、OceanBase 支持情况（截至 版本 4.3.5.1 及以上）

从官方文档来看：

- OceanBase 4.3 开始支持向量（VECTOR）数据类型与 ANN（近似最近邻）索引。 [oceanbase.github.io+2en.oceanbase.com+2](https://oceanbase.github.io/docs/blogs/tech/vector-search?utm_source=chatgpt.com)
- OceanBase v4.3.5.1 开始支持在同一张表中同时存在**全文索引（FULLTEXT INDEX）**与向量索引。 [en.oceanbase.com+1](https://en.oceanbase.com/docs/common-oceanbase-cloud-10000000001843160?utm_source=chatgpt.com)
- 官方文档里有关于向量检索 + 向量存储 + 全文索引用法的指引。 Full-text index 文档也明确支持。 [en.oceanbase.com+2oceanbase.github.io+2](https://en.oceanbase.com/docs/common-oceanbase-database-10000000001378818?utm_source=chatgpt.com)

所以版本条件很关键：**必须 ≥ 4.3.5.1** 才能安全使用混合检索的特性。

------

#### 二、混合检索（Hybrid Search）的实现思路

混合检索通常要做到两方面：

- 语义匹配／相似度匹配 → 用向量检索（ANN / vector index）
- 关键词匹配／全文过滤／关键词排序 → 用全文索引（FULLTEXT / MATCH AGAINST / WITH PARSER …）

然后把两者得分结合，进行排序 / 过滤。

在 OceanBase 中，这里可能的实现路径有：

1. 在同一张表里，既有向量列 + vector 索引，又有支持全文搜索的文本列 + fulltext 索引。
2. 写一个 SQL 查询，先通过 vector index 检索 top-K 候选，再用全文检索过滤 /加分，或者关键词全文检索先过滤再 vector 检索。
3. 如果需要，也可以把两个子查询的结果联合，再进行排序。

------

#### 三、示例 SQL（混合检索）

假设：

- 表 `documents` 有三列：`id` (主键)、`text` (全文本内容)、`embedding` (向量)
- 已经为 `text` 列建了 FULLTEXT 索引（用 ik parser 或其他适合的 parser）
- 已经为 `embedding` 列建了 vector 索引（如 HNSW 或 IVFFlat，OceanBase 支持的）

示例：

```
-- 假设你有要搜的关键词 keyword 和查询 embedding query_emb

SELECT
  d.id,
  d.text,
  
  -- 向量相似度得分（假设 OceanBase 支持 inner product、cosine 等）
  /* vs_score */ embedding <@ {YOUR_QUERY_VECTOR} AS vs_score,
  
  -- 全文匹配得分
  /* fts_score */ MATCH(text) AGAINST('your keyword phrase') AS fts_score,
  
  -- 加权组合得分
  (0.7 * vs_score + 0.3 * fts_score) AS final_score

FROM documents d

-- 可以先用向量索引来加速获取 top N
ORDER BY vs_score DESC
LIMIT 100

-- 再从这些 candidate 中做全文检索或全文排序过滤
-- 或者全文检索 + 向量排序，视不同场景

-- 最终排序
ORDER BY final_score DESC
LIMIT 10;
```

另一种写法：先全文检索加上关键词过滤再 vector 排序：

```
SELECT
  d.id,
  d.text,
  embedding <@ {YOUR_QUERY_VECTOR} AS vs_score
FROM documents d
WHERE MATCH(text) AGAINST('your keyword phrase')
ORDER BY vs_score DESC
LIMIT 10;
```

或做 union + re-ranking：

```
WITH vs AS (
  SELECT id, embedding <@ {YOUR_QUERY_VECTOR} AS vs_score
  FROM documents
  ORDER BY vs_score DESC
  LIMIT 100
),
fts AS (
  SELECT id, MATCH(text) AGAINST('keyword') AS fts_score
  FROM documents
  WHERE MATCH(text) AGAINST('keyword')
  LIMIT 100
)
SELECT
  co.id,
  co.text,
  vs.vs_score,
  fts.fts_score,
  (vs.vs_score * 0.7 + COALESCE(fts.fts_score, 0) * 0.3) AS combined
FROM vs
LEFT JOIN fts ON vs.id = fts.id
ORDER BY combined DESC
LIMIT 10;
```



## 重排序混合检索

检索与重排

```
        with ThreadPoolExecutor(max_workers=dify_config.RETRIEVAL_SERVICE_EXECUTORS) as executor:  # type: ignore
            futures = []
            if retrieval_method == "keyword_search":
                futures.append(
                    executor.submit(
                        cls.keyword_search,
                        flask_app=current_app._get_current_object(),  # type: ignore
                        dataset_id=dataset_id,
                        query=query,
                        top_k=top_k,
                        all_documents=all_documents,
                        exceptions=exceptions,
                        document_ids_filter=document_ids_filter,
                    )
                )
            if RetrievalMethod.is_support_semantic_search(retrieval_method):
                futures.append(
                    executor.submit(
                        cls.embedding_search,
                        flask_app=current_app._get_current_object(),  # type: ignore
                        dataset_id=dataset_id,
                        query=query,
                        top_k=top_k,
                        score_threshold=score_threshold,
                        reranking_model=reranking_model,
                        all_documents=all_documents,
                        retrieval_method=retrieval_method,
                        exceptions=exceptions,
                        document_ids_filter=document_ids_filter,
                    )
                )
            if RetrievalMethod.is_support_fulltext_search(retrieval_method):
                futures.append(
                    executor.submit(
                        cls.full_text_index_search,
                        flask_app=current_app._get_current_object(),  # type: ignore
                        dataset_id=dataset_id,
                        query=query,
                        top_k=top_k,
                        score_threshold=score_threshold,
                        reranking_model=reranking_model,
                        all_documents=all_documents,
                        retrieval_method=retrieval_method,
                        exceptions=exceptions,
                        document_ids_filter=document_ids_filter,
                    )
                )
            concurrent.futures.wait(futures, timeout=30, return_when=concurrent.futures.ALL_COMPLETED)

        if exceptions:
            raise ValueError(";\n".join(exceptions))

        if retrieval_method == RetrievalMethod.HYBRID_SEARCH.value:
            data_post_processor = DataPostProcessor(
                str(dataset.tenant_id), reranking_mode, reranking_model, weights, False
            )
            all_documents = data_post_processor.invoke(
                query=query,
                documents=all_documents,
                score_threshold=score_threshold,
                top_n=top_k,
            )

        return all_documents
```



## topK , score, weight 如何影响检索效果

以 oceanbase.search_by_vector() 为例

核心逻辑：

1. **构造 where 子句**
    如果传了 `document_ids_filter`，就拼接成 JSON 条件：

   ```
   metadata->>'$.document_id' in ('id1','id2','id3')
   ```

2. **设置 HNSW 搜索参数**

   ```
   ef_search = kwargs.get("ef_search", self._hnsw_ef_search)
   self._client.set_ob_hnsw_ef_search(ef_search)
   ```

3. **调用 OceanBase 的 ANN 搜索**

   ```
   cur = self._client.ann_search(
       table_name=self._collection_name,
       vec_column_name="vector",
       vec_data=query_vector,
       topk=topk,   # 👈 注意这里
       distance_func=func.l2_distance,
       output_column_names=["text", "metadata"],
       with_dist=True,
       where_clause=_where_clause,
   )
   ```

   👉 OceanBase 的 `ann_search` 本身是「返回 topK 最近邻」。

   - 这里 **没有直接做 score_threshold 的过滤**，只拿了 topK 个候选。

4. **转化为文档**

   ```
   metadata["score"] = 1 - distance / math.sqrt(2)
   docs.append(Document(page_content=_text, metadata=metadata))
   ```

   👉 score 是手动算出来的，基于 L2 距离。

------

### 2. 那 score_threshold 呢？

从你给的代码看，**这里完全没处理 score_threshold**，而是直接返回 topK。
 换句话说：

- ANN 检索时：取最近的 topK。
- 阈值过滤：如果要做，只能在 **上层调用 embedding_search** 或 `DataPostProcessor` 里二次过滤。



```
def invoke(
    self,
    query: str,
    documents: list[Document],
    score_threshold: Optional[float] = None,
    top_n: Optional[int] = None,
    user: Optional[str] = None,
) -> list[Document]:
    if self.rerank_runner:
        documents = self.rerank_runner.run(query, documents, score_threshold, top_n, user)

    if self.reorder_runner:
        documents = self.reorder_runner.run(documents)

    return documents
    
    

def _get_rerank_runner(
        self,
        reranking_mode: str,
        tenant_id: str,
        reranking_model: Optional[dict] = None,
        weights: Optional[dict] = None,
    ) -> Optional[BaseRerankRunner]:
        if reranking_mode == RerankMode.WEIGHTED_SCORE.value and weights:
            runner = RerankRunnerFactory.create_rerank_runner(
                runner_type=reranking_mode,
                tenant_id=tenant_id,
                weights=Weights(
                    vector_setting=VectorSetting(
                        vector_weight=weights["vector_setting"]["vector_weight"],
                        embedding_provider_name=weights["vector_setting"]["embedding_provider_name"],
                        embedding_model_name=weights["vector_setting"]["embedding_model_name"],
                    ),
                    keyword_setting=KeywordSetting(
                        keyword_weight=weights["keyword_setting"]["keyword_weight"],
                    ),
                ),
            )
            return runner
        elif reranking_mode == RerankMode.RERANKING_MODEL.value:
            rerank_model_instance = self._get_rerank_model_instance(tenant_id, reranking_model)
            if rerank_model_instance is None:
                return None
            runner = RerankRunnerFactory.create_rerank_runner(
                runner_type=reranking_mode, rerank_model_instance=rerank_model_instance
            )
            return runner
        return None
    
class ReorderRunner:
    def run(self, documents: list[Document]) -> list[Document]:
        # Retrieve elements from odd indices (0, 2, 4, etc.) of the documents list
        odd_elements = documents[::2]

        # Retrieve elements from even indices (1, 3, 5, etc.) of the documents list
        even_elements = documents[1::2]

        # Reverse the list of elements from even indices
        even_elements_reversed = even_elements[::-1]

        new_documents = odd_elements + even_elements_reversed

        return new_documents    
```

rerank 调用大模型重新打分再排序;  reorder 是规则排序

## 排序

### 1. 基于关键词的召回

- **BM25**（改进的 TF-IDF）
  - 最常见的倒排索引检索方法。
  - 优点：高效，搜索引擎工业界标准。
- **TF-IDF / 词频统计**
  - 最基础的方法，现在很少单独用，常作为 baseline。
- **布尔检索（Boolean Retrieval）**
  - 精确匹配，比如 `title:AI AND body:"large model"`。
  - 更适合法律、合规、专利场景。
- **N-gram / 前缀检索**
  - 中文分词、子串匹配、模糊匹配。

------

### 2. 基于语义的召回

- **Embedding 向量搜索**（ANN：HNSW、IVF、PQ 等）
  - 用向量相似度（cosine、内积、欧几里得距离）召回。
  - 覆盖语义相似，但可能引入噪声。
- **词袋模型（LSA / LDA / Topic Model）**
  - 比 BM25 更能捕捉主题，但相比 embedding 已过时。
- **Dual Encoder / Bi-Encoder**
  - BERT / SimCSE 之类，直接生成向量再用 ANN 搜索。
  - 工业界常用作粗排。

------

### 3. 基于结构化 / 规则的召回

- **过滤（Filter-based Retrieval）**
  - 按 metadata（时间、作者、类型）过滤候选。
  - 常和 BM25/embedding 结合。
- **规则模板匹配**
  - 例如 FAQ 检索：基于规则正则匹配候选，再进入 rerank。
- **Graph-based Retrieval**
  - 基于知识图谱，按实体关系先找到相关节点。

------

### 4. 多路召回（Hybrid Recall）

- **关键词 + 向量并行召回**
  - 比如 BM25 取 50，向量取 50，合并为候选 100。
- **搜索引擎多路召回**
  - BM25 + Semantic + Rule-based，再合并。

------

### 5. 工业界的粗排典型配置

- **电商搜索**：BM25 + 类目过滤 + embedding。
- **问答系统**：向量搜索 (embedding) + BM25（关键词）。
- **法条检索**：布尔检索（精确条文匹配）+ 向量召回（语义补全）。
- **推荐系统**：embedding 召回（user-item embedding）、规则召回（热门 / 最新）。



## oceanbase 多路召回

在 **OceanBase** 里都有对应的能力，但背后的机制和适用场景不同。我帮你逐一说明：

------

### 1. `keyword_search` → 关键词检索（BM25 / 倒排索引）

#### OceanBase 里的实现

- OceanBase 本身是 **关系型数据库**，默认提供 **B-Tree 索引**，对 `LIKE`、前缀匹配等支持还行。

- 要做 **BM25 或倒排索引**，需要依赖 **全文索引（FULLTEXT INDEX）** 或外部引擎。

- 如果你们的 `keyword_search` 是简单 SQL，那多半是：

  ```
  SELECT * FROM documents 
  WHERE text LIKE '%keyword%';
  ```

- 如果用了 FULLTEXT 索引，那可以：

  ```
  SELECT * FROM documents 
  WHERE MATCH(text) AGAINST('keyword');
  ```

#### 特点

- 精确匹配关键词（适合法律、日志、代码场景）。
- 不能捕捉语义（“汽车” ≠ “小车”）。
- 性能好，索引结构紧凑。

------

### 2. `embedding_search` → 语义检索（向量搜索）

#### OceanBase 里的实现

- 从 **4.3.0** 起，OceanBase 支持 **向量数据类型 VECTOR** 和 **ANN 索引（HNSW、IVFFlat 等）**。

- 用法示例：

  ```
  SELECT id, text, 
         l2_distance(vector, :query_vector) AS score
  FROM documents
  ORDER BY score
  LIMIT 10;
  ```

- 也可以建 **向量索引** 来加速：

  ```
  CREATE INDEX idx_vec ON documents(vector) USING HNSW;
  ```

#### 特点

- 捕捉语义相似度（“汽车”和“轿车”能被召回）。
- 适合问答、推荐、语义搜索。
- 缺点：解释性差，依赖 embedding 模型。

------

### 3. `full_text_index_search` → 全文索引检索

#### OceanBase 里的实现

- 从 **4.3.5.1** 开始，OceanBase 支持 **FULLTEXT INDEX**，并允许和向量索引共存。

- 创建全文索引：

  ```
  ALTER TABLE documents
  ADD FULLTEXT INDEX idx_fulltext_text (text) WITH PARSER ngram;
  ```

- 查询：

  ```
  SELECT id, text, 
         MATCH(text) AGAINST('智能 AND 手机' IN BOOLEAN MODE) AS relevance
  FROM documents
  WHERE MATCH(text) AGAINST('智能 手机');
  ```

#### 特点

- 比 `keyword_search` 更强，因为它支持 **分词 + 排序 + BM25 评分**。
- OceanBase 支持 `ngram`、`ik` 分词器，能做中文分词。
- 适合文章检索、新闻检索、知识库。

------

#### 4. 三者对比（基于 OceanBase）

| 方法                       | OceanBase 实现方式                  | 优点                              | 缺点                        | 适用场景             |
| -------------------------- | ----------------------------------- | --------------------------------- | --------------------------- | -------------------- |
| **keyword_search**         | `LIKE` / 简单倒排（低级版全文索引） | 简单直接，低成本                  | 不能排序，不支持语义        | 小规模检索，精确匹配 |
| **embedding_search**       | 向量类型 + HNSW 索引 (`VECTOR`)     | 语义相似度强                      | 成本高，需要 embedding 模型 | QA、推荐、语义搜索   |
| **full_text_index_search** | FULLTEXT INDEX + 分词器 (ngram/ik)  | 关键词召回强，BM25 排序，中文友好 | 语义不足（同义词/近义词难） |                      |

## B-tree & bm25 等索引

好问题 👍，BM25/倒排索引和 B-Tree 都是数据库里非常核心的索引结构，但应用场景完全不同。我帮你从 **原理 → 结构 → 场景 → OceanBase 里的区别** 来拆解：

------

### 1. **B-Tree 索引**

#### 原理

- **有序树结构**，每个节点存放 key 和指针。
- 查找依赖 **排序和范围查询**：等值查找、范围查询、前缀匹配。

#### 特点

- 适合结构化字段（id、时间戳、数值）。
- **强一致**：查询结果是精确的。
- 复杂度 `O(log n)`。

#### 场景

- 主键索引、二级索引。
- 精确匹配：`WHERE id=123`。
- 范围查询：`WHERE age BETWEEN 20 AND 30`。

------

### 2. **倒排索引 (Inverted Index)**

#### 原理

- 存储结构：**单词 → 文档列表**。

- 类似字典：

  ```
  "AI" → [doc1, doc5, doc8]
  "Database" → [doc2, doc3]
  ```

- 查询时通过单词快速定位文档集合。

#### 特点

- 面向全文检索（unstructured text）。
- 支持 BM25 / TF-IDF 等相关性评分。
- 查询结果是**相关性排序**，而不是简单有序。

#### 场景

- 关键词搜索（全文搜索引擎）。
- 支持布尔检索：`"AI" AND "Database"`。
- BM25 计算：衡量词频、逆文档频率，评估文档相关性。

------

### 3. **BM25**

- **不是索引结构**，而是 **评分函数**（Ranking Function）。
- 通常运行在倒排索引上，用来给候选文档打分。
- 核心公式考虑：
  - `tf`（词频）：词在文档里出现的次数。
  - `idf`（逆文档频率）：词在整个语料库中有多罕见。
  - 文档长度归一化。

👉 可以理解为：

- **倒排索引** = 数据结构，用来快速找到包含关键词的文档。
- 