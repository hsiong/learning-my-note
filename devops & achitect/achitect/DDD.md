https://mp.weixin.qq.com/s/IeB6VsHZ6nKS8nzBMEZpjQ

# 领域驱动设计（DDD）：几种典型架构详解

## 架构演变

![Image](https://mmbiz.qpic.cn/mmbiz_png/eQPyBffYbucd5TzIycUvPNK3KmtfJcAZeEpx2hicmFSvf7n82FVvTByv9je9IYXB7ka6XI7ffVPwYsrTtM7iasKQ/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

从图中已经可以很容易看出架构的演进过程，通过对三个层的举例来进行说明：

- SAAS：比如我们最早的就是单体应用，多个业务之间可能都没有进行分层，之后我们业务多了，都各自混淆在一起，后来我们就通过MVC、SSM、分层等方式进行业务拆分，保证业务与业务之间解耦
- PAAS：随者业务的增长，我们打算分离出一个子系统，但是成本太高，每次都需要从头搭建一个子系统，效率低下。这时我们就抽取除了一些通用技术，比如mesh、SOA、微服务等方式来隔离系统，且对通用技术复用来快速搭建一个系统
- IAAS：比如订单服务并发量高，单台服务器已经无法满足要求，这时我们需要多台服务器，可能有windows的、linux、mac，想要快速部署就需要屏蔽OS，于是就有了VM、Docker、K8S等技术来屏蔽OS

## 限界上下文(Bounded Context - BC)

![Image](https://mmbiz.qpic.cn/mmbiz_png/eQPyBffYbucd5TzIycUvPNK3KmtfJcAZ5AQ22Ryy7kU6nM9IbJKiaOVctA9ByzticlcReeS7L6N1CfpYNaibvdo1w/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

+ BC与业务的关系：

通过对业务的划分，比如订单系统，订单是一个子域；库存是一个子域；其中商品再不同的子域中所表示的意义也不同，比如在订单上下文中的商品表示商品的单价、折扣等等；而在库存的上下文中商品表示商品的库存量、成本、存放位置等。

+ BC与技术的关系：

多个子域之间必须需要在应用层进行聚合，而聚合的过程中就引出了技术方案，比如订单到库存到支付，他们应该采用同步方式；这几个子域调用通知都应该是异步，那么可能就需要消息中间件或其它技术方案

### 限界上下文划分规则

![Image](https://mmbiz.qpic.cn/mmbiz_png/eQPyBffYbucd5TzIycUvPNK3KmtfJcAZ0KxETqbZlQ51gSTdTM63jXHDZbwTme7ydFDuEOo65vQxZurpAicDVTg/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

一般来说，先考虑团队规模，来决定最终需要划分到多细粒度的BC，如果团队规模过小而BC过细，则对后期的运维、部署、上线都会造成很大的负担；

在确定好粒度后，可以对语义相关性、功能相关性-业务方向、功能相关性-非业务方向进行划分按照以上的规则划分之后就得到了多个BC啦

### 一个BC代表一个微服务吗？

![Image](https://mmbiz.qpic.cn/mmbiz_png/eQPyBffYbucd5TzIycUvPNK3KmtfJcAZmsejO7pxVjCOCZljg0Xtnvjxf0Vv4LibgRzLwcPPnV92czuwaBRwANA/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

**概念：** 微服务一般是指将高度相关功能的一个开发部署单元，有自己的技术自治性、技术选型、弹性扩缩容、发布上下频率等，说白了就是各自维护一个业务，然后多个业务组成一个系统，多个业务之间各自管理

**关系：** 这里的BC其实就是一个领域或一个模块或一个业务，如果两个领域相关性很高，就可以包含多个BC，或者如果一个领域访问量非常大，则需要部署在一个微服务中以提高性能

## 领域驱动设计的四重边界

![Image](https://mmbiz.qpic.cn/mmbiz_png/eQPyBffYbucd5TzIycUvPNK3KmtfJcAZ2ILYKBQbqbHia0N1ian9vcE08mOWXQh4lwHsd5wmhibo0dL6iaxqLRBvCA/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)

根据上图所示，我们通过四重来进行架构设计：

分而治之：DDD通过规划四重边界，把领域知识做了合理的固化和分层。

+ 业务有核心领域和支持域、业务域中
+ 每个域又拆分成多个限界上下文（BC）
+ 一个BC中又根据领域知识核心与否进行分层，
+ 领域层中按照多个业务（子域）的强相关性进行聚合成一个子域。

【第一重边界】

确定项目的愿景与目标，确定问题空间，确定核心子领域、通用子领域（多个子领域可以复用）、支撑子领域（额外功能，如数据统计、导出报表）

【第二重边界】

解决方案空间里的限界上下文就是一道进程隔离层面的物理边界

【第三重边界】

每个限界上下文内，使用分层架构划分为：接口层、领域层、应用层、基础设施层之间的最小隔离

【第四重边界】

领域层里为了保证各个领域的完整性和一致性，引入聚合的设计作为隔离领域模型的最小单元

## 常见分层架构

### 整洁分层架构

![Image](https://mmbiz.qpic.cn/mmbiz_png/eQPyBffYbucd5TzIycUvPNK3KmtfJcAZkGicjfQ8LgB8tBh5Z7FicaT45RIlv54813FCnC1I0OOSFnsqdnJvUXQA/640?wx_fmt=png&tp=wxpic&wxfrom=5&wx_lazy=1&wx_co=1)