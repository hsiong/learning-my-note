# 主要区别

**FastAPI** 和 **Flask** 都是用于构建 Web 应用程序的 Python 框架，但它们有一些显著的差异，适合不同的应用场景。以下是它们的主要区别：

### 1. **框架定位与设计目标**

- **Flask**：Flask 是一个轻量级的微框架，设计上非常灵活，允许开发者根据需要自由地选择扩展库和架构方式。适合需要灵活自定义的 Web 应用和小型、简单的 API 服务。
- **FastAPI**：FastAPI 专注于快速构建高性能的 REST API，利用了 Python 3.6+ 的类型注解和现代异步特性。它的设计目标是高性能、自动化 API 文档生成和数据验证。

### 2. **性能**

- **FastAPI**：FastAPI 使用 **Starlette** 和 **Pydantic** 作为底层技术，结合了异步编程（`asyncio`）和高效的 ASGI 框架，性能非常高，是构建高并发和低延迟应用的优秀选择。
- **Flask**：Flask 是 WSGI 框架，本质上是同步的。虽然支持某些异步扩展，但其性能通常低于 FastAPI，更适合 I/O 密集型或低并发的应用。

### 3. **异步支持**

- **FastAPI**：原生支持异步编程，允许使用 `async` / `await` 编写异步代码，适合 I/O 密集型任务（如调用外部 API 或数据库操作），显著提升性能。
- **Flask**：Flask 原生不支持异步操作，但可以通过 `gevent`、`aiohttp` 等扩展库进行支持，但使用起来不如 FastAPI 自然。

### 4. **类型注解与数据验证**

- **FastAPI**：深度集成了 Python 类型注解，利用 Pydantic 进行数据验证。定义请求体、路径参数、查询参数时，可以直接使用类型注解，自动完成数据验证，减少代码量。
- **Flask**：没有内置数据验证，需要通过 Marshmallow 或 WTForms 等库手动定义和验证数据，代码量相对较多。

### 5. **自动生成 API 文档**

- **FastAPI**：FastAPI 自带自动生成 OpenAPI（Swagger）和 ReDoc 文档。只需定义路由和 Pydantic 模型，即可在 `/docs` 和 `/redoc` 访问自动生成的文档，文档会实时更新。
- **Flask**：Flask 不自带 API 文档生成，需要通过 Flask-RESTPlus、Flasgger 等库生成 Swagger 文档，配置相对复杂，且文档生成的自动化程度较低。

### 6. **扩展性与插件生态**

- **Flask**：由于历史悠久，Flask 的扩展生态丰富，可以通过 Flask-SQLAlchemy、Flask-RESTful、Flask-JWT 等扩展实现丰富的功能，非常适合小型、中型项目。
- **FastAPI**：FastAPI 是一个新兴框架，虽然扩展较少，但可以集成 Starlette 和 Pydantic 扩展库，同时兼容 ASGI 应用的部分生态，如 WebSocket 和 GraphQL。

### 7. **上手难易度**

- **Flask**：Flask API 简单、易于理解，是许多新手学习 Web 框架的选择。没有严格的结构规范，开发者可以灵活选择自己的开发方式。
- **FastAPI**：使用 Python 的类型注解，学习曲线稍陡，但对于熟悉类型注解和异步编程的开发者来说，FastAPI 代码更加简洁和清晰。

### 8. **典型应用场景**

- **Flask**：适合构建小型 Web 应用和低并发 API 项目，适用于简单的 API 服务、原型开发或 MVP 产品。
- **FastAPI**：适合构建高并发、高性能的 API 微服务，特别是涉及数据验证、复杂请求体处理的场景，如机器学习模型服务、实时数据处理接口等。

### 总结

- **选择 Flask**：如果项目需求简单、并发量不高，且团队熟悉传统同步编程，可以选择 Flask。
- **选择 FastAPI**：如果项目需要高性能和异步支持、对类型注解和数据验证需求强烈，并且希望自动化 API 文档，那么 FastAPI 是更适合的选择。



# 特性介绍

## async

**Python 里的 `async/await` 使用方式**系统地讲清楚。

------

### 1. 什么是 `async/await`

- `async def` 定义的是 **协程函数**，调用时不会立即执行，而是返回一个 **协程对象**。
- `await` 的作用是 **挂起当前协程**，等待另一个协程完成，并把控制权交还给事件循环。
- 必须运行在一个 **事件循环** 中，通常由 `asyncio.run()` 或 Web 框架（FastAPI/Starlette/ASGI 服务器）帮你管理。

------

### 2. 基本用法

```
import asyncio

async def task(name, delay):
    print(f"{name} 开始")
    await asyncio.sleep(delay)   # 非阻塞等待
    print(f"{name} 完成")
    return name

async def main():
    # 并发运行多个协程
    results = await asyncio.gather(
        task("任务1", 2),
        task("任务2", 3),
        task("任务3", 1),
    )
    print("结果:", results)

# 启动事件循环
asyncio.run(main())
```

**输出（大约 3 秒完成）：**

```
任务1 开始
任务2 开始
任务3 开始
任务3 完成
任务1 完成
任务2 完成
结果: ['任务1', '任务2', '任务3']
```

👉 特点：虽然有 3 个耗时操作，但总时间只取决于最长的那个（3 秒），而不是 2+3+1=6 秒。

------

### 3. 常见场景

#### (1) 并发 I/O 操作

适合网络请求、数据库访问等 I/O 密集型任务。

```
import httpx, asyncio

async def fetch(url):
    async with httpx.AsyncClient() as client:
        resp = await client.get(url)
        return resp.text[:50]

async def main():
    urls = ["https://www.python.org", "https://www.fastapi.tiangolo.com"]
    results = await asyncio.gather(*(fetch(u) for u in urls))
    print(results)

asyncio.run(main())
```

------

#### (2) 在 FastAPI 里

FastAPI（ASGI 框架）天然支持 `async` 路由：

```
from fastapi import FastAPI
import asyncio

app = FastAPI()

@app.get("/demo")
async def demo():
    await asyncio.sleep(2)   # 模拟异步 I/O
    return {"msg": "ok"}
```

👉 请求会在 **2 秒后返回**，但这 2 秒期间，服务器线程还能处理其他请求。

------

#### (3) 在同步代码里调用协程 - **协作式并发**（concurrency） 

有时候你在同步函数里想调用异步函数，可以用 `asyncio.run` 或 `asyncio.to_thread`：

```
import asyncio

async def async_task():
    await asyncio.sleep(1)
    return "done"

def sync_func():
    result = asyncio.run(async_task())
    print(result)

sync_func()
```

------

### 4. 注意点

- `async/await` **不会**新开线程，而是基于事件循环调度。
- **不会提前返回结果**，除非你自己写后台任务（如 `BackgroundTasks`、线程池）。
- 如果调用阻塞库（如 `requests`、`time.sleep`），会卡住事件循环，需要用 `await asyncio.to_thread(...)` 或改用异步库（如 `httpx`、`asyncpg`）。

------

🔑 一句话总结：
 **Python 里的 `async/await` 是事件循环里的协程机制，能让等待 I/O 的时候不阻塞线程，实现高并发 I/O。**
 但它和“后台线程异步”不一样，除非你显式把任务丢到线程池或任务队列，否则响应还是要等逻辑执行完才会返回。

------

要不要我给你写一个 **“阻塞 vs async/await”的对比小实验**（同样 10 个请求，分别用 `time.sleep` 和 `await asyncio.sleep`），这样你一跑就能直观感受到差别？

## 异步多线程

### Flask

```
executor = ThreadPoolExecutor(max_workers=1)


def scheduled_task(app):
    '''
    定时任务 - 使用线程池并增加超时设置
    '''
    future = executor.submit(_recognize_queue_task, app)
    
    try:
        result = future.result(timeout=60)  # 设置任务超时时间为 30 秒
    except TimeoutError:
        print("Task took too long, terminating...")
```

### FastAPI

```
import time
import asyncio

def blocking_task(n):
    print(f"线程任务{n}开始")
    time.sleep(1)  # 阻塞
    print(f"线程任务{n}结束")
    return n

async def main():
    results = await asyncio.gather(*(asyncio.to_thread(blocking_task, i) for i in range(5)))
    print("结果:", results)

asyncio.run(main())
```

