
# skill icon

https://skillicons.dev/icons?i=python,go,js,ts,react,nodejs,docker,kubernetes,postgres,redis,git,linux,vscode&perline=7


# snake


把下面内容放到：

```
.github/workflows/snake.yml
name: Generate Snake

on:
  schedule:
    - cron: "0 0 * * *"
  workflow_dispatch:

jobs:
  generate:
    runs-on: ubuntu-latest

    permissions:
      contents: write

    steps:
      - name: Generate snake svg files
        uses: Platane/snk@v3
        with:
          github_user_name: hsiong
          outputs: |
            dist/github-contribution-grid-snake.svg
            dist/github-contribution-grid-snake-dark.svg?palette=github-dark
            dist/ocean.gif?palette=github-dark&color_snake=#ff4fd8&color_dots=#1f1535,#2b1d4d,#4a2870,#7a35a8,#ff4fd8

      - name: Push snake to output branch
        uses: crazy-max/ghaction-github-pages@v4
        with:
          target_branch: output
          build_dir: dist
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

> 注意: 非常重要的地方: 必须要 workflow - generate !

然后 README 里用这个，效果最好：

```
## 🐍 Contribution Snake

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hsiong/hsiong/output/github-contribution-grid-snake-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hsiong/hsiong/output/github-contribution-grid-snake.svg">
  <img alt="github contribution grid snake animation" src="https://raw.githubusercontent.com/hsiong/hsiong/output/github-contribution-grid-snake.svg">
</picture>
```

如果你想要 **更炸一点的发光动图**，再加这个 GIF 版本：

```
## ✨ Neon Snake

<img src="https://raw.githubusercontent.com/hsiong/hsiong/output/ocean.gif" alt="snake gif" 
```

