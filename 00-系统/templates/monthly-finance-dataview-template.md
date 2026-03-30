---
date: {{date:YYYY-MM}}
tags: [财务, 月度记账]
---

# {{date:YYYY}}年{{date:MM}}月 · 账单

---

## 账单记录

```dataview
TABLE date as "日期", item as "项目", category as "类别", amount as "金额"
FROM "03-领域/财务规划/记账"
WHERE contains(file.name, "{{date:YYYY-MM}}")
AND type = "消费记录"
SORT date ASC
```

---

## 月度汇总

```dataview
TABLE category as "类别", sum(amount) as "金额"
FROM "03-领域/财务规划/记账"
WHERE contains(file.name, "{{date:YYYY-MM}}")
AND type = "消费记录"
GROUP BY category
```

### 总支出

```dataview
CALCULATE sum(amount) FROM "03-领域/财务规划/记账" WHERE contains(file.name, "{{date:YYYY-MM}}") AND type = "消费记录"
```

---

## 消费分析

### 类别占比

```dataview
CALCULATE map(dv.pages('"03-领域/财务规划/记账"')
  .where(p => p.file.name.includes("{{date:YYYY-MM}}") && p.type == "消费记录")
  .groupBy(p => p.category)
  .sort(p => p.rows.amount.sum(), 'desc'),
  p => [p.key, p.rows.amount.sum(), round(p.rows.amount.sum() / total * 100) + "%"]
)
```

---

## 本月备注

[本月消费特点、异常支出、下月计划等]

---

*账单创建时间：{{date:YYYY-MM-DD}}*
