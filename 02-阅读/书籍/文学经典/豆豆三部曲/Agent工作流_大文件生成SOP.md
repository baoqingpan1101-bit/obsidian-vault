---
title: Agent工作流_大文件生成SOP
date: 2026-04-07
tags: [AI工作流, 技术SOP, 最佳实践]
created: 2026-04-07
---

# Agent 工作流：大文件生成 SOP

> **适用场景**：需要生成大文件（>1万字）、多文件协同、或连续多轮写入的任务
> **验证日期**：2026-04-07，基于《天幕红尘》深度分析项目实战

---

## 核心原则

> **不要让 Agent 一次做完。**
> Agent 的稳定写入单元远小于"一个完整文件"。接受这个约束，比对抗它更高效。

### 三条铁律

1. **极限单操作**：每次只做一件事。写入成功 → 立即停 → 下一轮。
2. **骨架先行**：先写框架和占位符，再逐段填充内容。
3. **外部写入优于 Agent 直写**：复杂字符串拼接交给 Python，Agent 只负责吐内容。

---

## 排障手册

### 问题 1：连续 `unknown` 错误

**现象**：
- 连续出现 `unknown` 或文件写入失败
- 工具调用被截断，部分文件内容丢失

**根因**：单次响应体超限。Agent 在一次回复里携带过多上下文（历史说明、思考过程、工具指令），导致输出过大。

**解决路径**：

```
❌ 一次生成完整文件
✅ 骨架 + 占位符 + 分段替换
✅ 每轮只写一个最小单元
```

---

### 问题 2：`replace_in_file` 偶尔成功、连续失败

**现象**：
- 第一次 `replace_in_file` 成功
- 连续多次 patch 后开始失败

**根因**：连续编辑累计上下文，导致响应体再次超限。

**解决路径**：

```
❌ 连续多次编辑同一个文件
✅ 每轮只替换一个标记，成功后立即停
✅ 如果需要多处修改，分成多轮，每轮之间验证文件状态
```

---

### 问题 3：PowerShell 执行含中文的 Python 脚本失败

**现象**：
- `python -c "中文内容"` 报错
- 编码相关异常

**根因**：PowerShell 对中文内联脚本处理有编码问题。

**解决路径**：

```
❌ python -c "中文代码"
❌ powershell -Command "中文内容"
✅ 用 write_to_file 写 .py 文件
✅ 用 & "path/to/python.exe" "script.py" 执行
```

---

### 问题 4：HTML 里 JSON 被截断（f-string 陷阱）

**现象**：
- 生成的 HTML 思维导图空白
- JS 里只有顶层节点，所有 children 丢失

**根因**：
Python f-string 会把所有单花括号 `{}` 当作变量插值。JS 对象字面量 `{...}` 必须写成 `{{...}}`，但凡漏掉一个，JSON 在第一个 `{` 处截断。

**错误示例**：

```python
# ❌ f-string 把 { 当插值符，JSON 被截断
html = f"const DATA={json.dumps(data)};"

# ❌ JS 模板里的 {{ 也会出错
html = f"""
const DATA = {{
  name: '{data["name"]}',
  children: {json.dumps(data["children"])}
}};
"""
```

**正确做法**：

```python
# ✅ 方案 A（推荐）：JS 数据和 HTML 模板完全分离
# Step 1: 写 JSON 数据文件
with open('data.js', 'w', encoding='utf-8') as f:
    f.write(f"const DATA = {json.dumps(tree, ensure_ascii=False)};")

# Step 2: 读取 HTML 模板
with open('template.html', 'r', encoding='utf-8') as f:
    html = f.read()

# Step 3: 合并（模板里已有 DATA 的 script 标签引用 data.js）
with open('output.html', 'w', encoding='utf-8') as f:
    f.write(html)

# ✅ 方案 B：用 string.Template（无 f-string 问题）
from string import Template
t = Template('const DATA=$json;')
html = t.substitute(json=json.dumps(data, ensure_ascii=False))

# ✅ 方案 C（最稳）：Python 脚本分三步走
# ① 写 JS 数据文件
# ② 写 HTML 模板文件（含 <script src="data.js">）
# ③ 无需合并，直接打开 HTML
```

**核心教训**：

> **永远不要在 f-string 里嵌含 `{}` 的内容。**
> 包括：JS 对象字面量、正则表达式、CSS 变量、SQL 片段。
> 遇见 `{}` → 换方案。

---

## 分块工作流

### 标准流程（五步）

```
Step 1: 确定文件骨架
        ↓
Step 2: 生成占位符版本（验证写入链路）
        ↓
Step 3: Agent 逐段吐内容（每段 < 2000 字）
        ↓
Step 4: 外部程序（Python）负责拼接和写入
        ↓
Step 5: 验证最终文件
```

### 骨架模板

```markdown
# ${filename}

## 一、[章节一]
${placeholder_1}

## 二、[章节二]
${placeholder_2}

## 三、[章节三]
${placeholder_3}

<!-- END OF FILE -->
```

Agent 只需填充 `${placeholder_N}` 部分，不要自己写入文件。

---

## 文件大小与工具选择

| 文件大小 | 推荐工具 | 说明 |
|----------|----------|------|
| < 500 字 | `replace_in_file` | 直接替换标记 |
| 500~2000 字 | `write_to_file` | 一次写入 |
| 2000~10000 字 | Python 脚本 + 分段吐内容 | Agent 吐，Python 写 |
| > 10000 字 | 骨架 + 分章节 + Python 合并 | 强制分段 |
| 含复杂字符串（HTML/JS/JSON） | **必须**用 Python 脚本 | 不要让 Agent 直写 |

---

## 验证清单

每次大文件任务完成后，核查：

- [ ] 文件大小符合预期（不为 0，不过小）
- [ ] 关键结构完整（章节标题、层级关系）
- [ ] 无乱码或截断
- [ ] 涉及 JS/HTML 的文件，在浏览器打开验证
- [ ] 涉及 Python 的脚本，执行一次验证无报错

---

## 案例复盘

### 案例 1：《天幕红尘》思维导图（2026-04-07）

**任务**：5个分析文件 + 1个交互式思维导图 HTML

**问题**：
- 连续 unknown（响应体超限）
- HTML 空白（f-string JSON 截断）

**解决**：
1. 5个 MD 文件：用骨架 + `replace_in_file` 分段写入
2. 思维导图 JSON：用 Python 脚本转换并写文件
3. 思维导图 HTML：用 Python 脚本生成（JS 模板和数据分离）

**总耗时**：约 3 小时（含排障）
**文件数**：6个（5 MD + 1 HTML）
**节点数**：40节点，4层嵌套

**学到的**：分块 >> 一次完成；Python 脚本 >> Agent 直写大文件。

---

## 附录：PowerShell 正确执行 Python 的方式

```powershell
# ❌ 错误：内联含中文的代码
python -c "print('你好')"

# ✅ 正确：写文件再执行
& "C:\path\to\python.exe" "C:\path\to\script.py"

# ✅ 正确：绝对路径更稳
& "C:/Users/Administrator/AppData/Local/Programs/Python/Python314/python.exe" "C:/Users/Administrator/WorkBuddy/20260407073513/build.py"
```

**注意**：Windows 路径用正斜杠 `/` 或双反斜杠 `\\`，不要用单反斜杠 `\`

---

*本文档基于 2026-04-07 《天幕红尘》项目实战排障经验总结，每一条经验均经根因验证。*
