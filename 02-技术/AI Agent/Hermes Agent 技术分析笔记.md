# Hermes Agent 技术分析笔记

> 来源：[NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent)
> 分析时间：2026-04-08

---

## 一、FTS5 Query 清洗

### 为什么需要

SQLite FTS5 使用自己的分词器，中文语境下搜索带英文术语的内容时会出现：

| 搜索词 | FTS5 默认行为 | 结果 |
|--------|-------------|------|
| `RAG-system` | 拆成 `RAG AND system` | 命中任何同时含两个词的结果 |
| `P2.2` | 拆成 `p2 AND 2` | 误命中 P2.1、P2.3 |
| `"见路不走"` | 引号短语可能被二次处理 | 短语语义丢失 |

### 实现要点（`_sanitize_fts5_query()`）

核心思路：**分步处理，保护优先级高的模式**

```
Step 1: 引号短语 → 占位符（最高优先级，原样保留）
Step 2: 去掉 +{}()^（FTS5 特殊符号）
Step 3: 折叠多余 *，去掉行首孤立 *
Step 4: 清理开头/结尾悬空布尔运算符
Step 5: 连字符/点号词 → 包引号
Step 6: 还原占位符
```

**去掉的符号**：`+ { } ( ) ^`（保留 `*` 用于前缀搜索）
**包引号**：`\w+[.\-&]\w+` 模式（如 RAG-system、P2.2、Q&A）

### 移植到 GBrain

- 文件：`gbrain_embedding.py:289-324`
- 函数：静态方法 `_sanitize_fts5_query()`
- 调用位置：`hybrid_search()` 内，FTS5 查询执行前

---

## 二、搜索结果上下文窗口

### 设计思路

`search_messages()` 额外返回命中结果前后各 1 条消息：

```sql
SELECT role, content FROM messages
WHERE session_id = ? AND id >= ? - 1 AND id <= ? + 1
ORDER BY id
```

### 为什么有用

- 孤立命中片段可读性差
- 上下文提供场景信息（前一条是项目背景，后一条是结论）
- 用户快速判断是否相关，减少无效点击

### 移植到 GBrain

- 文件：`gbrain_embedding.py:381-402`
- 逻辑：命中 chunk 后查 `embeddings` 表，取 `chunk_index ±1` 的相邻块
- 返回结构：`hit["context"] = [{"chunk_index": N, "text": "..."}]`
- CLI 输出：显示 `上下文[N]：...` 行

**注意**：纯 FTS5 搜索命中时没有 `chunk_index`（因为 FTS5 查的是 `pages_fts` 而非 `embeddings` 表），此时上下文为空。

---

## 三、Skills 系统 vs GBrain 手动维护

### Hermes Skills 本质

**结构化 Markdown 提示词模板**，不是插件，不是代码模块。

```
skills/
  dogfood/
    SKILL.md          # 核心：执行指南（Markdown）
    references/       # 参考资料（按需读取）
    templates/        # 输出模板
```

Agent 加载 Skill 后，`SKILL.md` 内容注入 system prompt，相当于给 Agent 一份**操作手册**。

### 自我改进机制

不是模型权重学习，而是 prompt-level 的程序化记忆：

```
Agent 完成复杂任务
  → 系统 nudge Agent
  → Agent 把经验写成新的 SKILL.md 或更新已有 Skill
```

本质是**把成功的任务执行模式结构化沉淀**。

### GBrain 当前状态

- 跨会话记忆：手动维护 `MEMORY.md` + daily log
- 知识检索：向量 + FTS5 混合搜索
- 没有 Skill 机制：读书笔记体系是静态文本，Agent 无法主动按需调用

### 升级方向

把现有笔记体系升级为 Agent 可调用的 Skill 库：

| 现有 | 目标 |
|------|------|
| 读书笔记 `.md` | `skills/xxx/SKILL.md` + `references/` |
| 手动记忆维护 | nudge 机制自动沉淀 |
| 静态文本检索 | Skill 内嵌执行流程，Agent 按需调用 |

**具体路径**（待探索）：
1. 梳理高频任务模式（如"读一本书"、"整理笔记"、"写报告"）
2. 每种模式写成 `SKILL.md`（触发条件 + 执行流程 + 参考资料）
3. 引入 nudge 机制：Agent 完成新任务后提示是否沉淀为 Skill

---

## 相关文件

- GBrain：`C:\Users\Administrator\WorkBuddy\20260407073513\gbrain\gbrain_embedding.py`
- Hermes 源码：`hermes_state.py`（FTS5 实现）、`agent/skill_utils.py`（Skill 加载）
