

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