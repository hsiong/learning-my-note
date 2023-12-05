# change Edge default search engine

> Refer: https://www.jianshu.com/p/51472eae3b7a

地址栏中搜索默认使用Bing国际版，在国内使用不会自动跳转到国内版cn.bing.com

Edge设置——隐私、搜索和服务——地址栏和搜索（最下面）——管理搜索引擎
 或者在地址栏输入：`edge://settings/searchEngines`
 **添加搜索引擎**
 搜索引擎：必应国际
 快捷方式：`www.bing.com`    (注意此处不可设为 bing.com)
 查询URL：`https://www.bing.com/search?q=%s&{bing:cvid}{bing:msb}{google:assistedQueryStats}`
 **将其设为默认值**

> edge 在 search engine 中添加了新的引擎, 并且保存了, 但是 Search engine used in the address bar 中选择不了

right click to new engine, then set it to `make default`