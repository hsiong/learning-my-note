
1. https://zhuanlan.zhihu.com/p/1975133084153316267
2. https://www.youtube.com/watch?v=ZprAy8lhBiY
3. 咸鱼6.块买个卡

2025.12.19

# gemini  auto-approval  &  sandbox disabled

The important difference is this:

- **Codex**: `--dangerously-bypass-approvals-and-sandbox` means “no approvals + no sandbox”
- **Gemini CLI**: approvals and sandbox are **separate controls**. In Gemini, `Ctrl + Y` auto-approves actions, but the docs also say YOLO mode **enables sandbox by default**. 

So the nearest Gemini-style equivalent is:

```
GEMINI_SANDBOX=false gemini
```

That is the cleanest documented way to get:

- auto-approval via `Ctrl + Y`
- sandbox disabled via `GEMINI_SANDBOX=false` 

You can also make it persistent in `~/.gemini/settings.json`, because Gemini documents `tools.sandbox` as a setting that can be enabled or disabled.