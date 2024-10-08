# 第一个 Flask 应用

一个 Flask 应用是一个 [`Flask`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask) 类的实例。应用的所有东西（例如配 置和 URL ）都会和这个实例一起注册。

创建一个 Flask 应用最粗暴直接的方法是在代码的最开始创建一个全局 [`Flask`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask) 实例。可以在一个函数内部创建 [`Flask`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask) 实例来代替创建全局实例。这个函 数被称为 *应用工厂* 。所有应用相关的配置、注册和其他设置都会在函数 内部完成，然后返回这个应用。

> requirements.txt
>
> Flask

## 应用工厂

创建 `flaskr` 文件夹并且文件夹内添加 `__init__.py` 文件。 `__init__.py` 有两个作用：一是包含应用工厂； 二是告诉 Python `flaskr` 文件夹应当视作为一个包。

flaskr/__init__.py

```python
def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        return 'Hello, World!'

    return app
```

`create_app` 是一个应用工厂函数，后面的教程中会用到。这个看似简单的 函数其实已经做了许多事情。

1. `app = Flask(__name__, instance_relative_config=True)` 创建 [`Flask`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask) 实例。
   - `__name__` 是当前 Python 模块的名称。应用需要知道在哪里设置 路径，使用 `__name__` 是一个方便的方法。
   - `instance_relative_config=True` 告诉应用配置文件是相对于 [instance folder](https://dormousehole.readthedocs.io/en/latest/config.html#instance-folders) 的相对路径。实例文件夹在 `flaskr` 包的外面，用于存放本地数据（例如配置密钥和 数据库），不应当提交到版本控制系统
2. [`app.config.from_mapping()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Config.from_mapping) 设置一个 应用的缺省配置：
   - [`SECRET_KEY`](https://dormousehole.readthedocs.io/en/latest/config.html#SECRET_KEY) 是被 Flask 和扩展用于保证数据安全的。在开 发过程中，为了方便可以设置为 `'dev'` ，但是在发布的时候应当 使用一个随机值来重载它。
   - `DATABASE` SQLite 数据库文件存放在路径。它位于 Flask 用于存 放实例的 [`app.instance_path`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask.instance_path) 之内。 下一节会更详细地学习数据库的东西。
3. [`app.config.from_pyfile()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Config.from_pyfile) 使用 `config.py` 中的值来重载缺省配置，如果 `config.py` 存在的话。 例如，当正式部署的时候，用于设置一个正式的 `SECRET_KEY` 。
   - `test_config` 也会被传递给工厂，并且会替代实例配置。这样可以实现测试和开发的配置分离，相互独立。
4. [`os.makedirs()`](https://docs.python.org/3/library/os.html#os.makedirs) 可以确保 [`app.instance_path`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask.instance_path) 存在。 Flask 不会自动创建实例文件夹，但是必须确保创建这个文件夹，因为 SQLite 数据库文件会被保存在里面。
5. [`@app.route()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask.route) 创建一个简单的路由，这样在继续教程下面的内容前你可以先看看应用如何运行的。它创建了 URL `/hello` 和一个函数之间的关联。这个函数会返回一个响应，即一个 `'Hello, World!'` 字符串。

## 运行应用

现在可以通过使用 `flask` 命令来运行应用。在终端中告诉 Flask 你的应 用在哪里，然后在调试模式下运行应用。请记住，现在还是应当在最顶层的 `flask-tutorial` 目录下，不是在 `flaskr` 包里面。

在调试模式下，当页面出错的时候会显示一个交互调试器，并且当你修改代码 保存后会重启服务器。在学习本教程的过程中，你可以一直让它保持运行，只需要刷新页面就可以了。

```
$ flask --app flaskr run --debug
```

可以看到类似如下输出内容：

```
* Serving Flask app "flaskr"
* Debug mode: on
* Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
* Restarting with stat
* Debugger is active!
* Debugger PIN: nnn-nnn-nnn
```

在浏览器中访问 http://127.0.0.1:5000/hello ，就可以看到 “Hello, World!” 信息。恭喜你， Flask 网络应用成功运行了！

如果其他应用程序已经占用了 5000 端口，那么在启动服务的时候会看到 `OSError: [Errno 98]` 或者 `OSError: [WinError 10013]` 出错信息。 如何处理这个问题，请参阅 [地址已被占用](https://dormousehole.readthedocs.io/en/latest/server.html#address-already-in-use) 。

> 注意: 
>
> + 在 pycharm 中运行: 
>   + add Flask Server
>   + Script path: `dir/__init__.py`

## 使用蓝图实现 api



+ 声明蓝图

  ```python
  lingyi_api = Blueprint('lingyi', __name__)
  ```

+ 声明蓝图API

  ```python
  @lingyi_api.route('/chat', methods=['POST'])
  ```

+ 注册蓝图

  ```python
  # 注册蓝图
  app.register_blueprint(lingyi_api, url_prefix='/lingyi')
  ```

> 注意: 
>
> + Field required [type=missing, input_value={'message': [{'role': 'us..., 'content': '你好'}]}, input_type=dict]
>
>   前后端参数名不一致

## 以 JSON 接收 List对象

+ 定义一个新的Pydantic模型，用于接收PerMessage对象的列表

  ```python
  class PerMessageList(BaseModel):
      messages: List[PerMessage]
  ```

+ 解析请求体中的JSON数据为PerMessageList对象

  ```python
  data = PerMessageList.parse_obj(request.json)
  ```

## 以 JSON 返回对象

+ 对象实现序列化

  ```python
  from pydantic import BaseModel
  class ChatCompletion(BaseModel): # 继承 BaseModel
      role: str # 声明各成员变量
      content: str 
  ```

+ 单个对象 `return completion.dict()`

+ 对象列表 `return [message.dict() for message in messages]`

  

# 参考链接

+ Flask API开发的最佳实践: https://juejin.cn/post/7112607171312877576
+ Flask_BestPractices: https://github.com/yangyuexiong/Flask_BestPractices?tab=readme-ov-file
+ Flask WEB 教程: https://zhuanlan.zhihu.com/p/570313571