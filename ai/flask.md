
Project Repo: https://github.com/hsiong/project-flask-template

# Flask - SQLAlchemy

## 初始化

## 基本类型

### 字符串

以下是不同数据库对 `Text` 类型和 `String` 类型的存储差异：

1. **MySQL**:

- **`VARCHAR(n)`**：是可变长度字符串，最大长度可以是 65,535 字节（根据表的字符集），但实际存储时，只占用内容长度的字节数，再加上额外的 1-2 字节用于存储字符串的长度。
- **`TEXT`**：`TEXT` 类型用于存储大文本，但通常被认为是大块数据。MySQL 会将 `TEXT` 数据存储在单独的区域（不是在行中），并且会有一些额外的开销。
- **存储方式**：在 MySQL 中，`JSON` 数据类型会将 JSON 文本存储为二进制格式。MySQL 会对 JSON 文本进行解析，并将其存储为内部格式，以提高读取和写入效率。
- **存储空间**：
  - JSON 数据的存储空间大小取决于实际数据的大小。
  - MySQL 对 JSON 类型字段没有固定的长度限制，但 JSON 文本的最大长度不能超过 `65,535` 字节（64 KB），因为 MySQL 中的单个字段最大支持这个长度。
  - 如果你需要存储非常大的 JSON 数据，超过 64 KB，可能需要考虑其他类型，如 `LONGTEXT`。

**性能差异**：如果你只需要存储少量的文本信息，使用 `VARCHAR`（或 `String(n)`）会更高效，因为它是存储在行中的。而 `TEXT` 类型则用于处理非常大的文本数据，会有一些性能和存储开销。

2. **PostgreSQL**:

- **`VARCHAR(n)`** 和 **`TEXT`**：在 PostgreSQL 中，`VARCHAR(n)` 和 `TEXT` 的存储方式几乎相同，它们都存储可变长度的文本数据，唯一的区别是 `VARCHAR(n)` 有长度限制，而 `TEXT` 没有。
- **存储方式**：PostgreSQL 提供了两种类型：`json` 和 `jsonb`。其中，`jsonb` 是二进制格式存储，具有更高效的查询和索引性能
- **存储空间**：
  - `jsonb` 会在存储时对数据进行压缩，实际占用空间取决于压缩后的数据大小。
  - PostgreSQL 没有具体的存储空间上限，只要表没有达到总行大小限制，就可以存储非常大的 JSON 数据。

**性能差异**：PostgreSQL 中，`VARCHAR(n)` 和 `TEXT` 没有明显的性能差异，选择哪个更多取决于你的设计需求。

## 增加一个非数据库的属性

### **使用普通属性**

你可以直接在类中定义一个属性或方法，这个属性不会被存储在数据库中，但你可以在对象实例上访问它。

```

class Task(_Base):
    '''
    实体-识别记录表
    '''
    __tablename__ = default_config.DATABASE_PREFIX + '_task'
    
    id = Column(String(64), primary_key=True)  
    create_time = Column(String(19), nullable=False, comment="创建时间，格式为YYYY-MM-DD HH:MM:SS")
    business_id = Column(String(32), unique=False, nullable=False, comment="业务ID")
    system_code = Column(String(20), nullable=False, comment="系统编码")
    callback_url = Column(String(255), nullable=False, comment="回调地址")
    prompt = Column(String(255), nullable=False, comment="任务提示信息")
    task_status = Column(String(32), nullable=False, comment="任务状态（pending, in_progress, completed, failed）")
    task_num = Column(Integer, nullable=False, comment="识别总数") 
    
    # 增加一个非数据库字段的属性
    additional_info = None  # 这不会存储在数据库中

    def __init__(self, **kwargs):
        super(Task, self).__init__(**kwargs)
        # 可以在构造函数中初始化额外的属性
        self.additional_info = "This is extra info"

# 示例用法
task = Task(id="123", create_time="2024-09-05 12:00:00", business_id="123456", system_code="cow", callback_url="https://example.com", prompt="Task prompt", task_status="pending", task_num=0)
task.additional_info = "New value for additional info"  # 这个属性不会影响数据库
print(task.additional_info)  # 输出: New value for additional info
```

### 使用注解

如果你需要创建一个计算属性，可以使用 `@property` 或 `@hybrid_property`，这些属性也不会作为数据库字段存储，只在访问时动态计算。

使用 `@property`：

```

class Task(_Base):
    __tablename__ = default_config.DATABASE_PREFIX + '_task'
    
    id = Column(String(64), primary_key=True)
    create_time = Column(String(19), nullable=False, comment="创建时间，格式为YYYY-MM-DD HH:MM:SS")
    business_id = Column(String(32), unique=False, nullable=False, comment="业务ID")
    system_code = Column(String(20), nullable=False, comment="系统编码")
    callback_url = Column(String(255), nullable=False, comment="回调地址")
    prompt = Column(String(255), nullable=False, comment="任务提示信息")
    task_status = Column(String(32), nullable=False, comment="任务状态（pending, in_progress, completed, failed）")
    task_num = Column(Integer, nullable=False, comment="识别总数")
    
    # 使用 @property 创建一个计算属性
    @property
    def additional_info(self):
        return f"Task {self.id} for system {self.system_code}"

# 示例用法
task = Task(id="123", create_time="2024-09-05 12:00:00", business_id="123456", system_code="cow", callback_url="https://example.com", prompt="Task prompt", task_status="pending", task_num=0)
print(task.additional_info)  # 输出: Task 123 for system cow
```

总结：

- **普通属性**：可以在模型类中直接定义普通的 Python 属性，这不会影响数据库结构。
- **`@property`** 或 **`@hybrid_property`**：如果需要计算属性，可以使用 `@property` 来动态生成属性，这同样不会影响数据库结构。

# Flask - Json

## json_tool

```python
import json
from enum import Enum
from typing import List, Type, TypeVar, Union, Optional

from pydantic import BaseModel
from sqlalchemy import Enum as SQLAlchemyEnum

from flaskr.tool.request_tool import ret_success_data, ret_error

T = TypeVar('T', bound=BaseModel)  # 定义泛型 T，要求继承自 BaseModel


def json_to_dict(data:str, model_class: Type[T]) -> Union[T, List[T]]:
    """
    将 JSON 字符串转换为 Pydantic 模型实例的通用函数，支持单个对象和对象列表。

    :param json_str: JSON 字符串
    :param model_class: Pydantic 模型类
    :return: Pydantic 模型实例或实例列表
    """
    # 如果数据是字符串，先将其转换为字典
    # 将 bytes 转换为字符串
    if isinstance(data, bytes):
        data = data.decode('utf-8')  # 或者 data.decode()，默认使用 'utf-8'
        
    if isinstance(data, str):
        data = json.loads(data) # 解析 JSON 字符串为 Python 字典或列表

    
    # 如果数据是列表，转换为 Pydantic 模型实例的列表
    if isinstance(data, list):
        return [model_class.parse_obj(item) for item in data]
    
    # 如果数据是单个对象，转换为 Pydantic 模型实例
    return model_class.parse_obj(data)


def dict_to_json_str(data: Union[BaseModel, List[BaseModel]]):
    '''
    将字典或包含 Pydantic 模型的列表转换为 JSON 字符串
    Args:
        data: 单个 Pydantic 模型实例或 Pydantic 模型实例的列表
    Returns:
        JSON 字符串
    '''
    if isinstance(data, list):
        # 对列表中的每个 BaseModel 对象调用 .json()
        return json.dumps([item.json() for item in data])
    else:
        # 直接将单个 BaseModel 对象转换为 JSON
        return data.json()


def _process_data(data, enum_columns):
    """
    处理数据，将枚举字段的字符串值转换为对应的枚举类型。
    """
    processed_data = {}
    for key, value in data.items():
        if key in enum_columns:  # 如果字段是枚举类型
            enum_class = enum_columns[key]
            processed_data[key] = enum_class[value]  # 使用 value 作为枚举的 name
        else:
            processed_data[key] = value
    return processed_data


def json_to_model(data, model_class):
    """
    将 JSON 字符串转换为 SQLAlchemy 模型实例的通用函数，支持枚举类型。
    Args:
        data: JSON 字符串或字典
        model_class: SQLAlchemy 模型类
    Returns:
        SQLAlchemy 模型实例
    """
    
    # 如果数据是字符串，先将其转换为字典
    if isinstance(data, str):
        data = json.loads(data)
    
    # 获取模型的所有枚举字段
    enum_columns = {column.name: column.type.enum_class for column in model_class.__table__.columns if
                    isinstance(column.type, SQLAlchemyEnum)}
    
    # 如果数据是列表，则返回模型实例列表
    if isinstance(data, list):
        return [model_class(**_process_data(item, enum_columns)) for item in data]
    
    # 如果数据是单个对象，则返回模型实例
    model_instance = model_class(**_process_data(data, enum_columns))
    
    return model_instance


def model_to_json_str(data):
    '''
    使用 SQLAlchemy 的内置方法转换为 JSON 字符串，支持单个模型和列表
    Args:
        data: SQLAlchemy 模型实例或 SQLAlchemy 模型实例的列表
    Returns:
        JSON 字符串
    '''
    return json.dumps(model_to_json_dict(data))


def model_to_json_dict(data):
    '''
    使用 SQLAlchemy 的内置方法转换为 JSON 字符串，支持单个模型和列表
    Args:
        data: SQLAlchemy 模型实例或 SQLAlchemy 模型实例的列表
    Returns:
        JSON 字符串
    '''
    
    def process_value(value):
        if isinstance(value,
                      Enum):  # SQLAlchemyEnum 是用于将枚举类（如 Python 的 enum.Enum）映射到数据库的字段类型。在实际的使用过程中，字段的值是枚举类的实例，而不是 
            # SQLAlchemyEnum 本身。
            return value.name
        return value
    
    # 如果传入的是列表，则对列表中的每个元素进行处理
    if isinstance(data, list):
        data_list = [{column.name: process_value(getattr(item, column.name)) for column in item.__table__.columns} for
                     item in data]
        return data_list
    
    # 如果传入的是单个 SQLAlchemy 模型实例
    data_dict = {column.name: process_value(getattr(data, column.name)) for column in data.__table__.columns}
    return data_dict


def _ret_json_success(data: Optional[dict] = None):
    return ret_success_data(data).json(), 200


def _ret_json_error(message):
    return ret_error(message).json(), 200


def return_success():
    '''
    返回成功
    Returns:

    '''
    return _ret_json_success()


def return_success_with_model(data):
    '''
    使用 SQLAlchemy 的内置方法返回成功
    Args:
        data: 

    Returns:

    '''
    return _ret_json_success(model_to_json_dict(data))


def return_success_data(data):
    '''
    返回成功
    Args:
        data: 数据

    Returns:

    '''
    return _ret_json_success(data)


def return_success_message(message):
    '''
    返回成功
    Args:
        message: 数据

    Returns:

    '''
    return message, 200


def return_error(exception):
    '''
    返回错误
    Returns:

    '''
    import traceback
    traceback.print_exc()  # 打印堆栈信息
    return json.dumps(str(exception)), 500


def return_error_message(message):
    '''
    使用 SQLAlchemy 的内置方法返回错误
    Args:
        message: 

    Returns:

    '''
    print(f'request error: {message}')
    return json.dumps(message), 500

```

## pydantic

### request -> pydantic_dict

```python
str = request.get_json()
pydantic_dict = Dict.parse_obj(obj) # obj inherited pydantic.BaseModel
```

### pydantic_dict -> str

```python
str = pydantic_dict.json()
```

## Sqlalchemy entity

### entity -> json

```
def model_to_json_str(data):
```

### json -> entity

```
def json_to_model(data, model_class):
```

### print entity str

```python
from sqlalchemy.orm import declarative_base
from flaskr.tool import json_tool
_Base = declarative_base() # 创建一个 Alchemy 基类, 不是全局
class Recognition(_Base):
	  id = Column(String(64), primary_key=True)  # 不在此处插入id, 而是在json序列化生成id, 以满足全局事务的同时, 接口返回id
    create_time = Column(String(19), nullable=False, comment="创建时间，格式为YYYY-MM-DD HH:MM:SS")
    
    def __repr__(self):
        '''
        自定义打印
        Returns:

        '''
        json_str = json_tool.model_to_json_str(self)
        return json_str 
```

## Enum

### print enum keys

#### 直接打印 list()

`list()` 可以将 `dict_keys` 转换为一个列表并自动打印成 `[...]` 的格式。

```python
if __name__ == '__main__':
    from flaskr.init.prompt_enum import ModelType
    
    # 获取键并转换为列表，直接打印
    keys = list(ModelType.DAMOYOLO.prompts.keys())
    
    # 打印列表形式的键
    print(f'keys: {keys}')
```

这样你会得到一个标准的 Python 列表格式输出，类似于 `[...]`。

输出示例：

```
keys: ['ALL', 'COW', 'SHEEP']
```

#### 使用 * 解包直接打印

如果你只想简单输出键的内容，也可以用 Python 的解包功能 `*`，这样直接将键打印出来：

```python
if __name__ == '__main__':
    from flaskr.init.prompt_enum import ModelType
    
    # 获取键并直接解包打印
    keys = ModelType.DAMOYOLO.prompts.keys()
    
    # 打印键，解包到 print 中
    print(f'keys: [{", ".join(keys)}]')
```

输出示例：

```
keys: [ALL, COW, SHEEP]
```



## 注意

### json 无法处理 dict:{dict, entity...}的情况

例如, 无法处理

```
class RedisRecognitionSchema(BaseModel):
    task: Optional[dict] = {}  # 任务 json，提供默认值为空字符串
    recognition_list: Optional[List[Recognition]] = []  # 待识别记录 json，提供默认值为空字符串
```

这种情况只能先转为 dict 即

```
class RedisRecognitionSchema(BaseModel):
    task: Optional[dict] = {}  # 任务 json，提供默认值为空字符串
    recognition_list: Optional[List] = []  # 待识别记录 json，提供默认值为空字符串
```

获取的时候, 调用 json(), to_model() 等方法

# Flask - Redis

## Redis 初始化

## Redis 上下文

## Redis 自动重连

#### **心跳机制**

为了避免 Redis 连接因空闲而断开，启用定期发送 PING 命令的心跳机制可以帮助保持连接活跃。你可以通过在应用中定期与 Redis 服务器通信来避免连接断开。

例如，可以在 Flask 应用的背景任务中定期向 Redis 发送 PING 命令：

```

from flask import Flask
from flask_redis import FlaskRedis
from apscheduler.schedulers.background import BackgroundScheduler

app = Flask(__name__)
app.config['REDIS_URL'] = "redis://localhost:6379/0"
redis_store = FlaskRedis()
redis_store.init_app(app)

# 创建一个后台调度器
scheduler = BackgroundScheduler()

def ping_redis():
    try:
        redis_store.ping()
        print("Redis connection is alive")
    except Exception as e:
        print(f"Redis connection failed: {e}")

# 每隔 60 秒发送一次 PING
scheduler.add_job(func=ping_redis, trigger="interval", seconds=60)
scheduler.start()

@app.route('/')
def index():
    redis_store.set('foo', 'bar')
    return redis_store.get('foo')

if __name__ == '__main__':
    app.run(debug=True)
```

#### **配置自动重连机制**

你可以通过设置 `retry_on_timeout=True` 来启用连接超时重试，以及配置 `socket_timeout` 和 `socket_connect_timeout` 来控制连接超时时间。

示例：

```

from flask import Flask
from flask_redis import FlaskRedis

app = Flask(__name__)
app.config['REDIS_URL'] = "redis://localhost:6379/0"

# 配置 redis 连接选项，启用超时重试
app.config['REDIS_OPTIONS'] = {
    'retry_on_timeout': True,
    'socket_timeout': 5,          # 5 秒超时
    'socket_connect_timeout': 5   # 5 秒连接超时
}

redis_store = FlaskRedis()
redis_store.init_app(app)
```

#### **使用 Redis 连接池**

如果你希望管理连接池并保持连接活跃，可以通过 `FlaskRedis` 使用连接池。连接池能够有效管理 Redis 的多个连接，并且可以设置连接超时和重试机制。

```

from flask import Flask
from flask_redis import FlaskRedis

app = Flask(__name__)

# 使用连接池管理 Redis 连接
app.config['REDIS_URL'] = "redis://localhost:6379/0"

redis_store = FlaskRedis()
redis_store.init_app(app)

# 你可以设置 Redis 的其他选项，比如使用连接池
app.config['REDIS_OPTIONS'] = {
    'retry_on_timeout': True,
    'socket_keepalive': True,     # 启用 Keepalive 以保持长连接
    'max_connections': 20,        # 设置连接池的最大连接数
}

# 初始化连接池
redis_store = FlaskRedis()
redis_store.init_app(app)
```

#### **获 Redis 连接异常**

你可以捕获 Redis 连接异常并在连接失败时进行自动重试：

```

from flask import Flask
from flask_redis import FlaskRedis
import redis

app = Flask(__name__)
app.config['REDIS_URL'] = "redis://localhost:6379/0"

redis_store = FlaskRedis()
redis_store.init_app(app)

@app.route('/')
def index():
    try:
        redis_store.ping()  # 测试 Redis 连接
        redis_store.set('foo', 'bar')
        return redis_store.get('foo')
    except redis.ConnectionError as e:
        print(f"Redis connection error: {e}")
        return "Redis connection failed"

if __name__ == '__main__':
    app.run(debug=True)
```

### 总结：

- **自动重连机制**：通过 `retry_on_timeout=True` 和配置超时相关参数确保 Redis 断开连接时自动重连。
- **使用连接池**：通过设置 `max_connections` 管理 Redis 连接池，防止连接过多或超时问题。
- **定期心跳**：使用 PING 命令保持连接活跃，避免因闲置而断开。
- **异常处理**：在连接异常时捕获错误并尝试重连，保证应用的健壮性。

## 综合使用

设计一个案例

request -> request_dict(pydantic) -> entity -> dto_dict(pydantic) -> entity , json_str -> redis -> json_str -> dto_dict(pydantic) -> entity

+ request -> request_dictt(pydantic)

  ```
  str = request.get_json()
  request_dict = super().parse_obj(obj) # obj inherited pydantic.BaseModel
  ```

+ request_dictt(pydantic) -> entity

  ```python
  from sqlalchemy.orm import declarative_base
  _Base = declarative_base() # 创建一个 Alchemy 基类, 不是全局
  class Entity(_Base):
  	  id = Column(String(64), primary_key=True)  # 不在此处插入id, 而是在json序列化生成id, 以满足全局事务的同时, 接口返回id
      create_time = Column(String(19), nullable=False, comment="创建时间，格式为YYYY-MM-DD HH:MM:SS")
      
    
  from snowflake.snowflake import SnowflakeGenerator
  generator = SnowflakeGenerator(instance=1)  # 创建一个 Snowflake ID 生成器实例
  entity = Entity(id=next(generator), create_time=time_tool.get_time_str(), model = model)
  ```

+ entity -> dto_dict(pydantic)

  ```python
  dto_dict = json_tool.model_to_json_dict(entity)
  ```

+ dto_dict(pydantic) -> entity , json_str

  ```python
  entity = json_tool.json_to_model(dto_dict, Entity)
  json_str = ret_json = dto_dict.json()
  ```

+ json_str -> redis

  ```python
  redis_client = current_app.extensions['redis']
  redis_client.put_queue(redis_constant.QUEUE_COW, task.id, ret_json)
  ```

+ redis -> json_str

  ```python
  json_str = redis_client.pop_queue(redis_constant.QUEUE_COW)
  ```

+ json_str -> dto_dict(pydantic)

  ```python
  dto_dict = json_tool.json_to_dict(json_str, DtoDict)
  ```

+ dto_dict(pydantic) -> entity

  ```python
  entity = json_tool.json_to_model(dto_dict, Entity)
  ```
