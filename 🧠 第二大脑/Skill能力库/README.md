---
title: Skill 能力库 - README
created: 2026-03-15
updated: 2026-03-15
tags: [Skill, 能力库, 安全]
---

# 🧰 Skill 能力库

> 管理所有已安装的扩展能力 · 防混乱 · 防安全失控

---

## 📊 已安装 Skill 一览

| Skill 名称 | 版本/来源 | 功能描述 | 安装日期 | 安全等级 | 审计报告 |
|-----------|---------|---------|---------|---------|---------|
| obsidian（内置）| WorkBuddy 内置 | 管理 Obsidian vault | — | ✅ P2 | 内置，无需审计 |
| defuddle | kepano/obsidian-skills | 网页内容提取为 Markdown | 2026-03-15 | ✅ P2 | [[defuddle/审计报告]] |
| json-canvas | kepano/obsidian-skills | 创建/编辑 Canvas 画布 | 2026-03-15 | ✅ P2 | [[json-canvas/审计报告]] |
| obsidian-markdown | kepano/obsidian-skills | Obsidian 风味 Markdown | 2026-03-15 | ✅ P2 | [[obsidian-markdown/审计报告]] |
| obsidian-cli | kepano/obsidian-skills | 命令行操作 vault | 2026-03-15 | ✅ P2 | [[obsidian-cli/审计报告]] |
| opencli | jackwener/opencli v0.4.2 | 任意网站转 CLI（npm 全局工具）| 2026-03-15 | ✅ P2 | [[opencli/使用手册]] |
| newsroom | goldengrape/newsroom | RSS 抓取 + AI 过滤 + 日报生成 | 2026-03-15 | ✅ P2 | [[newsroom/README]] |

---

## 📥 待安装 Skill

> 暂无待安装 Skill ✅

---

## 🔐 安全规范

1. **先审计后安装**：任何新 Skill 必须先完成安全审计（P2 才可安装）
2. **审计报告存档**：每个 Skill 的审计报告存放在对应子目录
3. **来源白名单**：优先使用官方或知名开发者的 Skill（如 Obsidian CEO kepano）
4. **定期复查**：每季度检查已安装 Skill 是否有更新或风险变化

---

## 📁 目录结构

```
Skill能力库/
├── README.md          ← 本文件（总览）
├── defuddle/
│   ├── 审计报告.md
│   └── 使用手册.md
├── json-canvas/
│   └── 审计报告.md
├── obsidian-markdown/
│   └── 审计报告.md
└── obsidian-cli/
    └── 审计报告.md
```

---

## 更新记录

| 日期 | 更新内容 |
|------|---------|
| 2026-03-15 | 初始建立，登记 4 个待安装 Skill |
