---
name: writing-shape
description: 把 markdown 原始材料通过对话塑造成文章：候选开头、逐段生长、逐步争论格式（列表、表格、callout、引用）。当用户有 notes、fragments 或 rough draft，想变成可发布文章时使用。
---

<what-to-do>

用户传入或将传入一个 markdown 原材料文件。先完整读取。

然后运行 shaping session，产出单独文章文档。不要编辑原材料文件，它是只读输入。

如果用户没说文章保存到哪里，问一次并记住。用户可能编辑文章文件；每次写入前重新读取。

</what-to-do>

<supporting-info>

## 循环

1. 读完整材料，形成整体感。
2. 草拟 2-3 个候选开头。每个开头应暗示不同 thesis 或 angle。让用户选或组合。
3. 逐段生长：问“基于这个开头，读者下一步需要知道什么？” 从材料中取用。争论下一 beat 应是段落、列表、表格、callout、引用或代码块。
4. 每个确定的块立即追加到文章文件。
5. 重复直到文章完成。

## 对话姿态

这是一种反向 grill。问题是：“这篇文章真正论证什么？读者应按什么顺序知道？”

持续追问：

- “这一段给读者新增了什么？”
- “删掉它会断哪里？”
- “这是 prose 还是 list？为什么？”
- “这句做了两件事，拆开或选一个。”
- “开头承诺 X，现在偏到 Y。拉回来或改开头。”

## 从材料中取用

把材料当 quarry，不当 script。fragment 可拆、合并、改写。缺材料时明确说：“这里需要例子，材料里没有；现在给一个，或者删掉这段。”

## 格式判断

- Prose vs list：prose 承载论证，list 承载并列项。
- Inline vs callout：tip、warning、aside 才用 callout。
- Table vs repeated structure：同一 shape 重复 3 次以上才用表格。
- Quote vs paraphrase：原文措辞重要时引用，否则转述。
- Code block vs inline code：多行、可运行、示意用 block；单 token 用 inline。

## 写入节奏

每个块确认后立即追加。写入前重读文章文件。不要盲目覆盖；用户要改某段时只改该段。

## 不做

- 不从材料外挖新素材，除非指出缺口并让用户补。
- 不编辑原材料文件。
- 不发布、不适配平台格式、不添加用户没要的 frontmatter。

</supporting-info>
