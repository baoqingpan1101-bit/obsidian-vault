---
title: Windows PowerShell 中文路径问题
created: 2026-03-15
updated: 2026-03-15
tags: [专题知识库, 踩坑记录, Windows, PowerShell, 编码]
severity: 🟡 中等风险
---

# 🐛 Windows PowerShell 中文路径问题

> 来源：2026-03-15 实际操作踩坑 · 提炼自工作日志

---

## 问题现象

在 Windows 上通过 PowerShell 脚本（`.ps1` 或 `.bat`）批量操作含有**中文字符或 emoji** 的文件路径时，可能出现：
- 文件名乱码（GBK vs UTF-8 不匹配）
- 路径解析失败
- 文件被移动到错误位置

**高危场景**：把含中文/emoji 路径的 PowerShell 命令写入 `.ps1` 文件再执行。

---

## 根本原因

Windows 中文系统默认代码页是 **GBK（936）**，而文本文件通常是 **UTF-8** 编码。当 PowerShell 读取脚本文件时，GBK 解码 UTF-8 中文内容会产生乱码。

---

## 解决方案

### ✅ 方案一：直接执行命令（推荐）

不写 `.ps1` 文件，直接在工具的 `execute_command` 中运行：

```powershell
Remove-Item "D:\Life Knowledge System\CLAUDE.md"
```

### ✅ 方案二：用文件管理器操作

涉及中文路径的批量文件操作，直接在 Windows 文件管理器手动完成，100% 安全。

### ✅ 方案三：设置 PowerShell 编码

如果必须用脚本文件，在脚本开头加：

```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001
```

并确保脚本文件以 **UTF-8 with BOM** 格式保存。

---

## 相关规则

参见 `🧠 第二大脑/L3-核心记忆/SOUL.md`：  
> ⚠️ 批量修改 / 重命名 / 移动超过 5 个文件 → 需要明确授权

---

## 参考

- WorkBuddy 文件组织安全协议：始终优先用直接命令而非脚本文件
