---
title: 🏠 HOME
created: 2026-01-01
updated: 2026-03-30
tags: [系统, 主页]
---

# 🏠 Life Knowledge System

---

## 🧠 AI 大脑 — 快速入口

```dataviewjs
const today = dv.date("today");
const year = today.year;
const month = String(today.month).padStart(2, "0");
const day = String(today.day).padStart(2, "0");
const dateStr = `${year}-${month}-${day}`;

// 计算 ISO 周数
const startOfYear = new Date(year, 0, 1);
const dayOfYear = Math.ceil((new Date(year, today.month - 1, today.day) - startOfYear) / 86400000) + 1;
const weekNum = String(Math.ceil((dayOfYear + startOfYear.getDay()) / 7)).padStart(2, "0");
const weekStr = `${year}-W${weekNum}`;

dv.paragraph(`| 快速入口 | 链接 |
|---------|------|
| 📔 今日日记 | [[06-日记/${year}/${month}/${dateStr}\\|${dateStr}]] |
| 📅 本周周记 | [[06-日记/周记/${weekStr}\\|${weekStr}]] |
| 💰 本月账单 | [[04-记账/${year}-${month} 账单\\|${year}-${month} 账单]] |
| 🤖 AI操作规范 | [[🧠 AI大脑/AGENTS\\|AGENTS.md]] |
| 👤 用户档案 | [[🧠 AI大脑/USER\\|USER.md]] |`);
```

---

## 📊 本月账单速览

```dataviewjs
const today = dv.date("today");
const month = String(today.month).padStart(2, "0");
const year = today.year;
const billFile = dv.page(`04-记账/${year}-${month} 账单`);
if (billFile) {
  dv.paragraph(`> 账单文件存在，在 Obsidian 中打开查看明细`);
} else {
  dv.paragraph(`> ⚠️ 本月账单文件未创建，告诉 WorkBuddy「帮我建本月账单」`);
}
```

---

## 📔 最近日记

```dataview
LIST
FROM "06-日记/2026"
WHERE file.name != "_模板"
SORT file.name DESC
LIMIT 7
```

---

## 🗂️ Vault 导航

| 区域 | 说明 |
|------|------|
| [[01-收件箱/\|📥 收件箱]] | 临时捕获，每日清理 |
| [[02-知识库/\|📚 知识库]] | 原料笔记，按主题分类 |
| [[03-读书/\|📖 读书]] | 读书笔记 |
| [[04-记账/\|💰 记账]] | 月度账单 |
| [[05-剪藏/\|✂️ 剪藏]] | 原文存档 |
| [[06-日记/\|📔 日记]] | 每日记录 |
| [[07-卡片盒/\|🃏 卡片盒]] | Zettelkasten 原子笔记 |
| [[🧠 AI大脑/\|🧠 AI大脑]] | AI 代理上下文 |
| [[90-附件/\|📎 附件]] | 媒体文件 |

---

## 📥 收件箱状态

```dataview
LIST
FROM "01-收件箱"
WHERE file.name != "01-收件箱-README"
LIMIT 10
```

---

## 🃏 最近卡片

```dataview
LIST
FROM "07-卡片盒"
WHERE file.name != "10-卡片盒-README"
SORT file.name DESC
LIMIT 5
```

---

⬅️ [[📖 使用手册]] | [[🗺️ 知识地图]] | [[🧠 AI大脑/AGENTS\|AI操作规范]] ➡️
