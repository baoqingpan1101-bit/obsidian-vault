# Newsroom - RSS 智能日报

基于 [goldengrape/newsroom](https://github.com/goldengrape/newsroom) 设计，适配 WorkBuddy 的 RSS 抓取 + AI 过滤 + 日报生成系统。

---

## 核心功能

- **RSS 抓取**：从多个源自动获取最新内容
- **AI 智能过滤**：按纯文本规则筛选相关内容
- **自动翻译**：标题和摘要翻译为中文
- **日报生成**：输出结构化 Markdown 到 Obsidian
- **反馈学习**：通过工作日志记录优化过滤规则

---

## 文件结构

```
🧠 第二大脑/Skill能力库/newsroom/
├── README.md              # 本文件
├── config.json            # RSS 源配置
├── FILTER_PROFILE.md      # AI 过滤规则
└── 使用手册.md             # 详细使用说明

20-日志/新闻日报/
└── YYYY-MM-DD-新闻日报.md  # 生成的日报
```

---

## 快速开始

### 1. 配置 RSS 源

编辑 `config.json`，添加你想跟踪的 RSS 源：

```json
{
  "sources": [
    {"name": "Hacker News", "url": "https://news.ycombinator.com/rss", "category": "tech"},
    {"name": "MedRxiv", "url": "https://www.medrxiv.org/rss", "category": "medical"}
  ]
}
```

### 2. 调整过滤规则

编辑 `FILTER_PROFILE.md`，用自然语言描述你的兴趣：

```markdown
## 关注领域
- AI/机器学习技术进展
- 编程工具和开发效率

## 排除内容
- 政治相关
- 娱乐八卦
```

### 3. 生成日报

对我说：

> 「帮我抓取今日新闻」

或

> 「运行 newsroom」

---

## 工作流程

```
用户触发 → 读取 config.json → 抓取 RSS → AI 按 FILTER_PROFILE 筛选
                                              ↓
                                    翻译标题/摘要 → 生成 Markdown
                                              ↓
                                    存入 vault/20-日志/新闻日报/
```

---

## 与原版对比

| 特性 | goldengrape/newsroom | WorkBuddy 版 |
|------|----------------------|--------------|
| 运行环境 | Python + GitHub Actions | WorkBuddy 内置 |
| AI 模型 | Gemini API | WorkBuddy AI |
| 输出位置 | GitHub Pages | Obsidian vault |
| 触发方式 | 定时自动 | 手动或 HEARTBEAT |
| 反馈机制 | 网站点击 + 学习脚本 | 工作日志记录 |

---

## 自动化配置（可选）

在 `HEARTBEAT.md` 中添加每日任务：

```markdown
| 时机 | 任务 | 执行方式 |
|------|------|---------|
| 每天 8:00 | 抓取新闻并生成日报 | AI 执行 |
```

---

## 使用提示

1. **首次使用**：先运行一次，检查输出格式是否符合预期
2. **调整规则**：根据日报内容调整 FILTER_PROFILE.md
3. **记录反馈**：在工作日志中记录哪些内容有价值
4. **月度优化**：每月末根据反馈更新过滤规则

---

*基于 goldengrape/newsroom 适配 | MIT License*
