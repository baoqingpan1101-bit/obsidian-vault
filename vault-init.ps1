# Vault 初始化脚本
# 运行前：右键 PowerShell → 以管理员身份运行
# 把下面路径改成你的 vault 实际位置

$vault = "D:\Life Knowledge System"

# ─── 1. 创建目录结构 ───────────────────────────────────────────

$folders = @(
    "00-系统\templates",
    "01-收件箱",
    "02-知识库\专业",
    "02-知识库\计算机",
    "02-知识库\管理",
    "02-知识库\个人成长",
    "02-知识库\杂项",
    "03-读书",
    "04-记账",
    "05-剪藏",
    "🧠 AI大脑\工作日志",
    "90-附件\归档"
)

foreach ($f in $folders) {
    $path = Join-Path $vault $f
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "已创建: $f"
    } else {
        Write-Host "已存在（跳过）: $f"
    }
}

# ─── 2. 创建模板文件 ───────────────────────────────────────────

$templates = @{

"reading-clip.md" = @"
---
来源: [原文标题](../../05-剪藏/文件名.md)
日期: YYYY-MM-DD
分类: 
tags: []
---

## 这篇在讲什么
（3句话以内）

## 核心观点
- 
- 
- 

## 我能用的结论
（直接可操作的部分）

## 关联笔记
- [[]]
"@

"expense.md" = @"
---
日期: YYYY-MM-DD
类别: 
金额: 
备注: 
---
"@

"monthly-bill.md" = @"
# YYYY-MM 账单

## 月度汇总
| 类别 | 金额 |
|------|------|
| 餐饮 |  |
| 购物 |  |
| 交通 |  |
| 其他 |  |
| 合计 |  |

---

## 明细
### YYYY-MM-DD
- 项目 | 类别 | 金额
"@

"reading-note.md" = @"
---
书名: 
作者: 
日期: YYYY-MM-DD
tags: []
---

## 核心观点

## 书摘

## 我的想法
"@

"quick-note.md" = @"
---
日期: YYYY-MM-DD
tags: []
---

"@

}

foreach ($name in $templates.Keys) {
    $path = Join-Path $vault "00-系统\templates\$name"
    if (-not (Test-Path $path)) {
        $templates[$name] | Out-File -FilePath $path -Encoding UTF8 -NoNewline
        Write-Host "已创建模板: $name"
    } else {
        Write-Host "已存在（跳过）: $name"
    }
}

# ─── 3. 创建 AGENTS.md ────────────────────────────────────────

$agentsPath = Join-Path $vault "🧠 AI大脑\AGENTS.md"
if (-not (Test-Path $agentsPath)) {

$agentsContent = @"
---
title: AGENTS - 标准操作流程
updated: $(Get-Date -Format "yyyy-MM-dd")
---

# AGENTS — 标准操作流程 (SOP)

> 每次新会话只需读取此文件 + USER.md，无需加载其他文件。

---

## 启动流程

1. 读取 🧠 AI大脑/USER.md
2. 检查 01-收件箱/ 是否有待处理内容
3. 回报状态：「已就绪，收件箱 X 条待处理」

---

## 记账 SOP

触发词：「记账」「花了」「买了」

1. 解析：日期 + 项目 + 类别 + 金额
2. 写入：04-记账/YYYY-MM 账单.md，追加到对应日期分组
3. 更新月度各分类小计

---

## 读书笔记 SOP

触发词：「记录读书笔记」「写书摘」

1. 解析：书名 + 章节 + 核心观点 + 个人想法
2. 写入：03-读书/书名.md
3. 使用 reading-note 模板

---

## 剪藏处理 SOP

触发词：「帮我处理」「剪藏」「消化这篇」

1. 原文存入 05-剪藏/YYYY-MM-DD-标题.md
2. 判断分类（专业/计算机/管理/个人成长/杂项）
3. 使用 reading-clip 模板提炼，写入 02-知识库/对应分类/标题.md
4. 关联 vault 已有笔记（wikilink）
5. 告知处理结果

---

## 专业问答 SOP

触发词：「这个规范怎么说」「帮我查」

1. 先查 02-知识库/专业/ 有无相关内容
2. 有 → 基于已有内容回答
3. 无 → 回答后询问是否存入知识库

---

## 杂项归并 SOP

触发词：「整理杂项」（建议每季度一次）

1. 读取 02-知识库/杂项/ 所有笔记
2. 按主题归类，给出合并建议
3. 等待确认后执行，移入对应分类

---

## 工作日志规范

- 路径：🧠 AI大脑/工作日志/YYYY-MM.md
- 每次操作追加一条记录，格式：
  ``YYYY-MM-DD HH:mm | 操作类型 | 简述``
"@

    $agentsContent | Out-File -FilePath $agentsPath -Encoding UTF8 -NoNewline
    Write-Host "已创建: 🧠 AI大脑\AGENTS.md"
} else {
    Write-Host "已存在（跳过）: 🧠 AI大脑\AGENTS.md"
}

# ─── 4. 创建 USER.md 占位文件 ────────────────────────────────

$userPath = Join-Path $vault "🧠 AI大脑\USER.md"
if (-not (Test-Path $userPath)) {
$userContent = @"
---
title: USER - 个人信息
updated: $(Get-Date -Format "yyyy-MM-dd")
---

# 关于我

（在这里填写你的个人背景、职业、使用习惯等，供 AI 每次会话读取）
"@
    $userContent | Out-File -FilePath $userPath -Encoding UTF8 -NoNewline
    Write-Host "已创建: 🧠 AI大脑\USER.md（请手动填写内容）"
} else {
    Write-Host "已存在（跳过）: 🧠 AI大脑\USER.md"
}

# ─── 完成 ──────────────────────────────────────────────────────

Write-Host ""
Write-Host "========================================"
Write-Host "初始化完成"
Write-Host "----------------------------------------"
Write-Host "接下来需要手动完成："
Write-Host "1. 填写 🧠 AI大脑\USER.md 的个人信息"
Write-Host "2. 将旧的「🧠 第二大脑」移到 90-附件\归档\"
Write-Host "3. 旧笔记按分类手动移入 02-知识库\"
Write-Host "4. Obsidian 设置新笔记默认路径为 01-收件箱"
Write-Host "========================================"
