---
title: 🏠 HOME
created: 2026-01-01
updated: 2026-03-15
tags: [系统, 主页]
---

# 🏠 Life Knowledge System

---

## 🧠 第二大脑 — 快速入口

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
| 📔 今日日记 | [[20-日志/日记/${year}/${month}/${dateStr}\\|${dateStr}]] |
| 📅 本周周记 | [[20-日志/周记/${weekStr}\\|${weekStr}]] |
| 💰 本月账单 | [[03-领域/财务规划/记账/${year}-${month} 账单\\|${year}-${month} 账单]] |
| 📥 代办池 | [[🧠 第二大脑/任务看板/📥-代办池]] |
| 🔴 阻塞中 | [[🧠 第二大脑/任务看板/🔴-阻塞中]] |
| 🤖 AI操作规范 | [[🧠 第二大脑/操作手册/AGENTS]] |`);
```

---

## 📊 本月账单速览

```dataviewjs
const today = dv.date("today");
const month = String(today.month).padStart(2, "0");
const year = today.year;
const billFile = dv.page(`03-领域/财务规划/记账/${year}-${month} 账单`);
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
FROM "20-日志/日记"
WHERE file.name != "_模板"
SORT file.name DESC
LIMIT 7
```

---

## 📅 最近周记

```dataview
LIST
FROM "20-日志/周记"
WHERE file.name != "_模板"
SORT file.name DESC
LIMIT 4
```

---

## 🧰 第二大脑导航

| 层级 | 目录 | 说明 |
|------|------|------|
| 🔐 L3 核心记忆 | [[🧠 第二大脑/L3-核心记忆/IDENTITY\|身份]] · [[🧠 第二大脑/L3-核心记忆/USER\|用户档案]] · [[🧠 第二大脑/L3-核心记忆/SOUL\|安全红线]] | 极低频更新 |
| 📋 操作手册 | [[🧠 第二大脑/操作手册/AGENTS\|SOP]] · [[🧠 第二大脑/操作手册/TOOLS\|环境配置]] · [[🧠 第二大脑/操作手册/HEARTBEAT\|定时任务]] | 中频更新 |
| ⚙️ 任务看板 | [[🧠 第二大脑/任务看板/📥-代办池\|代办]] · [[🧠 第二大脑/任务看板/⚙️-进行中\|进行中]] · [[🧠 第二大脑/任务看板/🔴-阻塞中\|阻塞]] | 高频更新 |
| 📋 工作日志 | [[🧠 第二大脑/工作日志/2026/2026-03-15\|今日日志]] | 每次任务后写入 |
| 🧰 Skill库 | [[🧠 第二大脑/Skill能力库/README\|能力库总览]] | 安装新技能时更新 |
| 📚 专题库 | [[🧠 第二大脑/专题知识库/README\|专题总览]] | 定期从日志提炼 |

---

## 🗂️ Vault 导航

| 区域 | 说明 |
|------|------|
| [[01-收件箱/\|📥 收件箱]] | 临时捕获，每日清理 |
| [[02-项目/\|🚀 项目]] | 有截止日期的目标 |
| [[03-领域/\|🌱 领域]] | 持续关注的生活领域 |
| [[04-资源/\|📚 资源]] | 外部参考材料 |
| [[10-卡片盒/\|🃏 卡片盒]] | Zettelkasten 原子笔记 |
| [[05-归档/\|📦 归档]] | 完成项目归档 |
