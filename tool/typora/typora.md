
# short key
`ctrl + comman + 1,2,3` switch window

`ctrl + +/-` change paragraph

`ctrl + /` show origin code 

`ctrl + <- / -> ` to the line start / end

`command + shift + enter` table next line

## table

`alt + enter` table next line

`ctrl + shift + backspace` table delete line

`ctrl + shift + enter` add `<br />` to this line

鼠标放在边界, 可以拖动

## typera -> docx pandoc style
https://www.cnblogs.com/fancy2022/p/16365046.html

> Modify style -> format -> 
>
> + font
> + paragraph
> + numbering
> + ...

+ normal text style
  + First Paragraph
  + Body Text
  + Normal
+ header \\###
  + Heading 1
  + Heading 2
  + Heading 3
  + Heading 4
  + ...

## typera order list, pdf export error

2em 为需要控制的空余量

![image](https://user-images.githubusercontent.com/37357447/221492307-6a957780-3d35-4aed-b74b-a27d8fed004d.png)

![image](https://user-images.githubusercontent.com/37357447/221492356-01aff4fa-9157-4f41-85c7-1beaacd22f75.png)

## Mac下的Typora草稿/未保存恢复
https://blog.csdn.net/Sensente/article/details/125703890

## 自动图片替换
变动大会自动替换, 似乎有算法



# 流程图

（适用于 Mermaid 11.x、Typora 最新版）

```mermaid
graph TD
    A[下游系统/客户端] -->|REST / Knife4j| B[Customer360 API<br/>backend-system]

    subgraph S[API 层]
        B --> C[Customer360Controller]
    end

    subgraph Q[查询 / 同步层]
        C --> D[CrmService<br/>CrmTempService<br/>CrmCommonService]
        C --> E[Customer360QueryService]
        C --> F[Customer360Service<br/>DS postgres]
        C --> G[RestAiService]
    end

    D --> H[(Oracle CRM 视图<br/>正式 / 渠道)]
    E --> H

    F --> I[(PostgreSQL<br/>t_customer_* 核心 / 热数据 / 明细)]
    E --> I

    F --> J[(Redis 缓存)]
    E --> J
```