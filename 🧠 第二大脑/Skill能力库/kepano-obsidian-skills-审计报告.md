---
title: json-canvas / obsidian-markdown / obsidian-cli 安全审计报告
created: 2026-03-15
tags: [Skill, 安全审计]
---

# 🔍 kepano/obsidian-skills 批量审计报告

> 适用于：json-canvas / obsidian-markdown / obsidian-cli

---

## 执行摘要

| 字段 | 内容 |
|------|------|
| **审计对象** | kepano/obsidian-skills（3个 Skill）|
| **来源** | GitHub 官方仓库，作者 Obsidian CEO kepano |
| **审计时间** | 2026-03-15 |
| **P0 阻断级** | 0 个 |
| **P1 需关注** | 0 个 |
| **安全评分** | 95/100 |

---

## 各 Skill 说明

### json-canvas ⭐⭐

| 项目 | 内容 |
|------|------|
| **功能** | 创建和编辑 `.canvas` 画布文件（可视化知识图谱）|
| **工作方式** | 操作本地 JSON Canvas 文件格式 |
| **对你的价值** | 你 vault 已有 `.canvas` 文件，做知识图谱有用 |
| **安全结论** | ✅ P2 安全 |

### obsidian-markdown ⭐⭐

| 项目 | 内容 |
|------|------|
| **功能** | 教 AI 使用 Obsidian 风味 Markdown（Wikilinks、Callouts、属性等）|
| **工作方式** | 纯知识文档，让 AI 更准确地写 Obsidian 笔记 |
| **对你的价值** | 辅助提升，我已基本掌握，装了锦上添花 |
| **安全结论** | ✅ P2 安全 |

### obsidian-cli ⭐

| 项目 | 内容 |
|------|------|
| **功能** | 通过命令行工具操作 Obsidian vault（打开文件、触发命令等）|
| **工作方式** | 依赖 `obsidian-cli` 本地工具（当前未安装）|
| **对你的价值** | 低（需先安装 CLI 工具，配置成本高）|
| **安全结论** | ✅ P2 安全，但配置依赖较多 |

---

## 审计结论

**全部 P2 — 可以安全安装** ✅

---

## 安装状态

- [ ] json-canvas — 待安装
- [ ] obsidian-markdown — 待安装
- [ ] obsidian-cli — 待安装（需先安装 obsidian-cli 本地工具）
