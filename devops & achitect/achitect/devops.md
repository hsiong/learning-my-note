# Reference
https://www.zhihu.com/question/58702398/answer/1755254160


# 微服务架构+DEVOPS
远程部署一些机器，专门用来管理代码，进行上线工作，由运维事先把上线的规则都给定义好了，开发只要按照他的规则都访问这台服务器进行各自的代码合成和发布，自己上线呢，能用代码自动完成的事情就绝不要手动解决，这是每个开发人员都在想的东西。运维需要做的事情，慢慢的都沉淀到了各个平台上面，例如监控，有专门的监控组件和可视化，基础服务例如服务器，CDN，负载均衡等基础服务可以外包到云服务厂商，日志也有专门的日志工具，链路追踪也有专门的组件和可视化，还有网关等，渐渐的，只要这些都配置好了，开发也可以做运维的部分工作，毕竟开发才是最了解代码的人，哪里出了问题看看监控日志，可以最快速度定位到问题，于是DEVOPS开发模式诞生了，开发也是运维。

DevOps 已经是扩大到“端到端”的概念了，如下图：
<img src="https://picx.zhimg.com/50/v2-1a6b2102b1b400308afe5b625c3c0cbc_720w.jpg?source=1940ef5c" data-rawwidth="1338" data-rawheight="458" data-size="normal" data-caption="" data-default-watermark-src="https://pic1.zhimg.com/50/v2-7ab80df45b59b700614491aef3a4f4d2_720w.jpg?source=1940ef5c" class="origin_image zh-lightbox-thumb" width="1338" data-original="https://pic1.zhimg.com/v2-1a6b2102b1b400308afe5b625c3c0cbc_r.jpg?source=1940ef5c"/>

DevOps 的三大支柱之中，即人（People）、流程（Process）和平台（Platform）。即

DevOps = 人 + 流程 + 平台

人 + 流程 = 文化

流程 + 平台 = 工具

平台 + 人 = 赋能



# **devops实现相关工具**

人自然不用多说，开发前后中涉及到的所有人，流程前期是产品出原型，UI出设计，然后前后端代码开发，QA测试，最终部署上线，下图是部分流程图：

![img](https://pica.zhimg.com/80/v2-e345a2227ff1716e36e5c87c9ba1f4a9_1440w.webp?source=1940ef5c)

## **devops平台搭建工具**

`项目管理（PM）`：jira。运营可以上去提问题，可以看到各个问题的完整的工作流，待解决未解决等；

`代码管理`：gitlab。jenkins或者K8S都可以集成gitlab，进行代码管理，上线，回滚等；

`持续集成CI（Continuous Integration）`：[gitlab ci](https://www.zhihu.com/search?q=gitlab ci&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1755254160})。开发人员提交了新代码之后，立刻进行构建、（单元）测试。根据测试结果，我们可以确定新代码和原有代码能否正确地集成在一起。

`持续交付CD（Continuous Delivery）`：[gitlab cd](https://www.zhihu.com/search?q=gitlab cd&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1755254160})。完成单元测试后，可以把代码部署到连接数据库的 Staging 环境中更多的测试。如果代码没有问题，可以继续手动部署到生产环境中。

`镜像仓库`：VMware Harbor，私服nexus。

`容器`：Docker。

`编排`：K8S。

`服务治理`：Consul。

`脚本语言`：Python。

`日志管理`：Cat+Sentry，还有种常用的是ELK。

`系统监控`：Prometheus。

`负载均衡`：Nginx。

`网关`：Kong，zuul。

`链路追踪`：Zipkin。

`产品和UI图`：蓝湖。

`公司内部文档`：Confluence。

`报警`：推送到工作群。

有了这一套完整的流程工具，整个开发流程涉及到人员都可以无阻碍的进行协调工作了，开发每天到公司，先看看jira,看看线上日志，出了问题看看监控日志，运营同学反馈问题不着急的去JIRA，着急的群里吆喝，产品和UI的图直接蓝湖看，运维关注监控着大盘，改革春风开满地，互联网人民真高兴~