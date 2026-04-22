@"

\# Life Knowledge System (LKS)

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository. It documents both the conceptual architecture (Obsidian knowledge graph) and the necessary technical workflows (plugin files, scripts).

## 核心目标 (Core Goal)
这是一个个人知识管理系统，基于 Obsidian 构建，用于知识的捕获、组织、关联和沉淀。

## 目录结构 (Directory Structure)
... (rest of the directory list)


这是我的个人知识管理系统，基于 Obsidian 构建。

使用者是一名岩土地质专业人员。



\## 目录结构

\- 00-系统/     - 系统配置、模板文件

\- 01-收件箱/   - 临时捕获、待处理内容

\- 02-阅读/     - 阅读中的文章、网页剪藏

\- 03-读书/     - 读书笔记

\- 04-记账/     - 财务记录

\- 05-剪藏/     - 网页剪藏归档

\- 06-日记/     - 每日记录

\- 07-卡片盒/   - 永久笔记、核心知识卡片

\- 🧠 AI大脑/  - AI 相关笔记

\- E:\\电子书\\   - 个人藏书库

\- E:\\常用规范\\ - 岩土地质专业规范文档



\## Obsidian 使用约定

\- 文件格式：Markdown（.md）

\- 双链语法：\[\[文件名]]

\- 标签格式：#标签名

\- 主要语言：中文



\## 专业背景

\- 专业方向：岩土工程、地质勘察

\- 常用规范位于 E:\\常用规范\\

\- 电子书资料位于 E:\\电子书\\



\## 助手行为要求

\- 所有回复请使用中文

\- 保留 Obsidian wikilink \[\[]] 格式

\- 修改或创建文件前必须先告知用户确认

\- 读取规范时请注明具体条文编号

\- 生成笔记时遵循 Obsidian 双链结构

\- 新建笔记优先放入 01-收件箱/，整理后再归档

\- 永久知识卡片保存至 07-卡片盒/

"@ | Set-Content -Path "E:\\Life Knowledge System\\CLAUDE.md" -Encoding UTF8



