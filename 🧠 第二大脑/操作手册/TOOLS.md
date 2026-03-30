---
title: TOOLS - 本地环境配置
created: 2026-03-15
updated: 2026-03-15
tags: [操作手册, 工具, 环境配置]
---

# 🛠️ TOOLS — 本地环境配置

> 操作手册层 · 中频更新 · 记录本地环境特殊配置，避免每次重新确认

---

## 📁 关键路径

| 用途 | 路径 |
|------|------|
| **Obsidian Vault** | `D:\Life Knowledge System` |
| **日记存放** | `D:\Life Knowledge System\20-日志\日记\YYYY\MM\` |
| **周记存放** | `D:\Life Knowledge System\20-日志\周记\` |
| **月记存放** | `D:\Life Knowledge System\20-日志\月记\` |
| **账单存放** | `D:\Life Knowledge System\03-领域\财务规划\记账\` |
| **模板目录** | `D:\Life Knowledge System\00-系统\templates\` |
| **第二大脑** | `D:\Life Knowledge System\🧠 第二大脑\` |
| **工作日志** | `D:\Life Knowledge System\🧠 第二大脑\工作日志\YYYY\` |
| **Skill库** | `D:\Life Knowledge System\🧠 第二大脑\Skill能力库\` |
| **专题库** | `D:\Life Knowledge System\🧠 第二大脑\专题知识库\` |

---

## 💻 系统环境

| 项目 | 内容 |
|------|------|
| **OS** | Windows（win32） |
| **Shell** | PowerShell / CMD |
| **工作目录** | `C:\Users\Administrator\WorkBuddy\Claw` |
| **包管理器** | npm / pip（根据需要）|

---

## 🔧 已安装工具

| 工具 | 状态 | 用途 |
|------|------|------|
| WorkBuddy | ✅ 运行中 | 主 AI 助手 |
| Obsidian | ✅ 安装在 D 盘 | 笔记管理 |
| WPS | ✅ 已安装 | 办公文档 |
| obsidian-cli | ❌ 未安装 | 命令行操作 vault |
| defuddle | ❌ 未安装 | 网页内容提取 |
| json-canvas | ❌ 未安装 | Canvas 画布操作 |

---

## 🌐 网络 & API

| 服务 | 配置 | 备注 |
|------|------|------|
| 暂无外部 API | — | 按需补充 |

> ⚠️ API Key 等敏感信息不得写入此文件，存放到系统密钥管理器或单独的 `.env` 文件（不纳入 vault）

---

## 📝 特殊说明

- **文件编码**：PowerShell 执行含中文路径命令时优先用 `cmd /c`，避免乱码
- **批量文件操作**：必须先备份再操作（参考 SOUL.md 红线）
- **Dataview 查询**：vault 已启用 Dataview 插件，支持动态查询

---

## 更新记录

| 日期 | 更新内容 |
|------|---------|
| 2026-03-15 | 初始建立 |
