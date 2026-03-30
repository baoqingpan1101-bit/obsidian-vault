---
title: 读书写作
created: 2026-03-17
updated: 2026-03-17
tags: [领域, 读书, 写作]
health: 🟢
last_review: 2026-03-17
---

# 📚 读书写作

> 持续阅读、思考、输出，构建知识体系

---

## 🎯 领域目标

- 保持阅读习惯，每月至少 2 本书
- 深度阅读与思考，不仅摘抄更要提炼
- 定期输出书评、笔记、感悟

---

## 📖 读书记录

```dataview
TABLE
  author AS "作者",
  read_date AS "阅读日期",
  link(note, "笔记") AS "笔记",
  status AS "状态"
FROM "03-领域/读书写作"
WHERE !contains(file.name, "README")
AND contains(tags, "读书笔记")
SORT read_date DESC
```

---

## 📝 写作输出

---

## 📚 阅读计划

---

## 🔗 关联

- [[04-资源/阅读笔记]] - 深度读书笔记归档处
- [[20-日志/读书笔记]] - 按时间记录的读书笔记（临时）
