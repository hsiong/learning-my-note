

# reset ob
```ssh
sudo docker compose -f docker-compose.middleware.yaml down 
sudo docker stop oceanbase
sudo docker rm oceanbase
sudo docker rmi oceanbase/oceanbase-ce:4.3.5.1-101000042025031818
sudo docker compose -f docker-compose.yaml up -d
```


workflow_entry
single run
```python
    @classmethod
    def single_step_run(
        cls,
        *,
        workflow: Workflow,
        node_id: str,
        user_id: str,
        user_inputs: dict,
    ) -> tuple[BaseNode, Generator[NodeEvent | InNodeEvent, None, None]]:
```

```python
node_instance, generator = getter()
```

pg->metadata过滤->ids->weaviate

retrieval-knowledge: [knowledge_retrieval_node.py](core%2Fworkflow%2Fnodes%2Fknowledge_retrieval%2Fknowledge_retrieval_node.py)knowledge_retrieval_node.py
```python
    def _get_metadata_filter_condition(
        self,
        dataset_ids: list,
        query: str,
        tenant_id: str,
        user_id: str,
        metadata_filtering_mode: str,
        metadata_model_config: ModelConfig,
        metadata_filtering_conditions: Optional[MetadataFilteringCondition],
        inputs: dict,
    ) -> tuple[Optional[dict[str, list[str]]], Optional[MetadataCondition]]:
```

rerank
```python
    def invoke(
        self,
        query: str,
        documents: list[Document],
        score_threshold: Optional[float] = None,
        top_n: Optional[int] = None,
        user: Optional[str] = None,
    ) -> list[Document]:
```

economy doesn't support metadata filter
```python
                if dataset.indexing_technique == "economy":
                    # use keyword table query
                    documents = RetrievalService.retrieve(
                        retrieval_method="keyword_search", dataset_id=dataset.id, query=query, top_k=top_k
                    )
                    if documents:
                        all_documents.extend(documents)
                else:
                    if top_k > 0:
                        # retrieval source
                        documents = RetrievalService.retrieve(
                            retrieval_method=retrieval_model["search_method"],
                            dataset_id=dataset.id,
                            query=query,
                            top_k=retrieval_model.get("top_k") or 2,
                            score_threshold=retrieval_model.get("score_threshold", 0.0)
                            if retrieval_model["score_threshold_enabled"]
                            else 0.0,
                            reranking_model=retrieval_model.get("reranking_model", None)
                            if retrieval_model["reranking_enable"]
                            else None,
                            reranking_mode=retrieval_model.get("reranking_mode") or "reranking_model",
                            weights=retrieval_model.get("weights", None),
                            document_ids_filter=document_ids_filter,
                        )

                        all_documents.extend(documents)
```

invok llm
```python
def _invoke_llm(
        self,
        node_data_model: ModelConfig,
        model_instance: ModelInstance,
        prompt_messages: Sequence[PromptMessage],
        stop: Optional[Sequence[str]] = None,
    ) -> Generator[NodeEvent, None, None]:
```

+ annotation task
```python
@shared_task(queue="dataset")
def document_indexing_task(dataset_id: str, document_ids: list)::


```

+ .env / tool 等不生效，　
```markdown
+ 注意要先起 app，再启动 celery
+ Thread　由　celery　执行，断点在celery;
+ kill 其他 celery `ps aux | grep celery | grep -v grep | awk '{print $2}' | xargs kill -9`
```

+ metafilter -> sql
```python


from flask_login import current_user  # type: ignore
from werkzeug.exceptions import Forbidden

def _process_metadata_filter_func(

    case "sql":
        if not current_user.is_admin_or_owner:
            raise Forbidden()
        filters.append(text(f"documents.doc_metadata ->> '{metadata_name}' = {value}"))

'<-1>' or  documents.doc_metadata ->> 'area'  LIKE '%1,2'

```

+ chunk embed
```shell
 这里是“从一篇 document → 拆 chunk → 入库 → 向量化（Weaviate）”的完整链路和可直接查看的代码片段：

  - 拆分与构建 chunk 对象（含 metadata）
      - 段落模式：core/rag/index_processor/processor/paragraph_index_processor.py 153–217 行（index() 构建 Document，设置 doc_id/doc_hash/document_id/dataset_id，可带附件）。
        查看：sed -n '140,220p' core/rag/index_processor/processor/paragraph_index_processor.py
      - 父子层级模式：core/rag/index_processor/processor/parent_child_index_processor.py 245–316 行（Document + 子 chunk ChildDocument，同样带 doc_id/doc_hash，并保存 parent_mode）。
        查看：sed -n '240,330p' core/rag/index_processor/processor/parent_child_index_processor.py
  - 将 chunk 写入数据库（DocumentSegment / ChildChunk）
      - core/rag/docstore/dataset_docstore.py 62–178 行(segment_document) ：add_documents() 把每个 chunk 写入 document_segments（index_node_id=doc_id），可选保存子 chunk 到 child_chunks，并绑定附件
        SegmentAttachmentBinding。
        查看：sed -n '60,200p' core/rag/docstore/dataset_docstore.py
      - 模型定义（字段/索引）：
          - models/dataset.py 697–738 行 DocumentSegment
            查看：sed -n '690,740p' models/dataset.py
          - models/dataset.py 912–942 行 ChildChunk
            查看：sed -n '900,950p' models/dataset.py
  - 向量化入口与嵌入
      - core/rag/datasource/vdb/vector_factory.py：Vector.create/create_multimodal/add_texts 批量嵌入文本或文件，然后调用底层向量实现。
        查看：sed -n '1,320p' core/rag/datasource/vdb/vector_factory.py
      - 由 index processor 决定是否调用：
          - 段落模式：paragraph_index_processor.py 88–109、205–217 行（高质量索引调用 Vector.create；经济模式用关键词）。
          - 父子模式：parent_child_index_processor.py 120–134、301–316 行（高质量索引用 Vector.create 孩子 chunk）。
  - Weaviate 具体落库（向量 + 元数据绑定）
      - core/rag/datasource/vdb/weaviate/weaviate_vector.py：
          - 1–90 行：client/init
          - 120–186 行：建/补 schema，确保属性 text(document content), document_id, doc_id, chunk_index。
          - 200–268 行：add_texts() 把 Document.metadata 写成属性（doc_id 对应 DB 的 index_node_id；document_id 绑定源文档），UUID 基于内容或随机；vector payload使用 embeddings。
          - 检索/删除等同样基于 doc_id/document_id。
            查看：sed -n '1,320p' core/rag/datasource/vdb/weaviate/weaviate_vector.py

  链路摘要

  1. 文档通过 IndexProcessor 拆 chunk，填充 doc_id/doc_hash/document_id/dataset_id（可有 children/attachments）。
  2. DatasetDocumentStore.add_documents() 将 chunk 持久化到 document_segments（index_node_id=doc_id），子 chunk 到 child_chunks，附件绑定到 segment_attachment_bindings。
  3. 高质量索引时，IndexProcessor 调 Vector.create/create_multimodal，VectorFactory 用租户配置选型（Weaviate 时走 WeaviateVectorFactory）。
  4. WeaviateVector 创建/补 schema 后，add_texts 把 chunk 文本 + 元数据（doc_id/document_id 等）连同 embeddings 批量写入 Weaviate。
  5. 后续检索用 Weaviate 返回的 doc_id/document_id，再映射回数据库（DocumentSegment/ChildChunk）的元数据。

```

+ 9ji.code 
```
unable to access 'https://code.9ji.com/xiongjiangfeng/flask-pdf.git/': gnutls_handshake() failed: The TLS connection was non-properly terminated.

设置代理　no_proxy  9ji.com

```

+ proxy
```python
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
http_proxy="http://10.1.250.160:7777/"
https_proxy="http://10.1.250.160:7777/"
ftp_proxy="http://10.1.250.160:7777/"
no_proxy="localhost,127.0.0.1,192.168.254.29,aliyuncs.com,192.168.254.69,9ji.com"
```

+ redis
Another-Redis-Desktop-Manager-linux-1.7.1-x86_64.AppImage 
click `Allow executing file as program`
./Another-Redis-Desktop-Manager-linux-1.7.1-x86_64.AppImage --disable-gpu --no-sandbox

+ git 拉取大文件

local-llm error
![img.png](img.png)


+ installing plugin, the plugin not work but you can input api key and no tip
  no available node, plugin not found

xxx service --- API

+ model
```
~/.cache/huggingface/hub
```

+ like sql
```sql
 LIKE '%<1>%' or 'area' LIKE '%<-1>%'
```

+ dify code test
```shell



```

+ 使用space　而不是tab


