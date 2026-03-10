最稳的办法就是把 **`github-readme-stats` 部署到你自己的 Vercel**。官方仓库现在也明确建议：公共实例是 **best-effort**，会因为流量和限流不稳定；想稳定用就自己部署。

## 最简单做法：部署到自己的 Vercel

### 第 1 步：Fork 官方仓库

先把官方仓库 fork 到你自己的 GitHub 账号。官方仓库就是 `anuraghazra/github-readme-stats`。

无需手动 fork, 

### 第 2 步：创建 GitHub Token

你需要一个 **GitHub Personal Access Token**，用于让你的实例去请求 GitHub API。
官方文档提到：如果你想显示更稳定的数据，尤其是私有仓库相关统计，需要用你自己的 token 部署。

一般这样配就够了：

- 经典 Token：勾选 `repo`（如果你要统计私有仓库）
- 只统计公开仓库时，通常不需要那么高权限，但很多人还是直接按官方常见方式配 PAT

建议你在 GitHub 的 token 页面新建一个，记下来。

### 第 3 步：在 Vercel 配环境变量

> 注意: 先加环境变量, 再部署

最关键的是加环境变量：

```
PAT_1=你的GitHubToken
```

一些自托管说明和相关实现都使用 `PAT_1` 作为环境变量名。

如果你访问量比较大，可以继续加：

```
PAT_2=第二个Token
PAT_3=第三个Token
```

这样可以分摊 GitHub API 限额。官方项目本身就是支持多 token 轮换的。

### 第 4 步：去 Vercel 导入项目

登录 Vercel 后，选择 **Add New / New Project**，导入你刚 fork 的 `github-readme-stats` 仓库。
社区和相关自托管说明里，Vercel 仍然是最常见的部署方式。

### 第 5 步：点 Deploy

部署完成后，你会拿到一个自己的域名，比如：

```
https://github-readme-stats-yourname.vercel.app
```

以后把原来的地址：

```
https://github-readme-stats.vercel.app/api?username=hsiong&theme=jolly
```

改成你自己的域名：

```
https://你的域名.vercel.app/api?username=hsiong&theme=jolly
```

语言卡片同理：

```
https://你的域名.vercel.app/api/top-langs/?username=hsiong&layout=compact&card_width=400&theme=jolly
```

## 你这两个卡片，替换后直接这么写

```
<img src="https://你的域名.vercel.app/api/top-langs/?username=hsiong&layout=compact&card_width=400&theme=jolly" width="100%">
<img src="https://你的域名.vercel.app/api?username=hsiong&theme=jolly" width="100%">
```

## 常见坑

### 1. 部署成功但图片还是不显示

先直接在浏览器打开：

```
https://你的域名.vercel.app/api?username=hsiong&theme=jolly
```

如果这里都打不开，通常是：

- `PAT_1` 没填对
- Vercel 环境变量没保存
- 部署后没重新触发一次 redeploy

### 2. 私有仓库数据没出来

官方说明里提到，默认卡片只统计公开仓库；想带上私有统计，需要自部署并使用你自己的 GitHub API token。语言卡片也是一样。

### 3. 还是担心 Vercel 限流

这个担心是对的。2026 年官方仓库讨论里就有人提到，Vercel 免费层限流会影响可用性，所以社区也在推动其他自托管方案或 GitHub Actions 方案。

## 还有一个更稳的方案：GitHub Actions 生成静态 SVG

官方仓库最近的讨论里，也有人建议不要依赖在线 API，而是用 **GitHub Actions 定时生成 SVG 文件**，直接提交到你的 profile 仓库。这样没有外部服务依赖，稳定性更高。

但如果你现在只是想尽快恢复，**先上 Vercel 自部署**最省事。

## 我建议你直接照这个最短流程走

1. fork `anuraghazra/github-readme-stats`
2. 新建 GitHub PAT
3. Vercel 导入 fork 后的仓库
4. 配 `PAT_1` 环境变量
5. 部署
6. 把 README 里的 `github-readme-stats.vercel.app` 全部换成你自己的域名

你要的话，我可以直接把 **从注册到部署完成的完整中文版步骤** 给你写成一份，连 **PAT 怎么创建、Vercel 每一步点哪里、README 最终替换代码** 都给你配好。