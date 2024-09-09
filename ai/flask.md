
Project Repo: https://github.com/hsiong/project-flask-template

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



# Flask - Redis

## Redis 初始化

## Redis 上下文

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
